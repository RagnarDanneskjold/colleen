#|
 This file is a part of Colleen
 (c) 2014 TymoonNET/NexT http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package :org.tymoonnext.colleen)

(defvar *handler-map* (make-hash-table))
(defvar *priority-map* (make-hash-table))
(defvar *priority-names* (let ((map (make-hash-table)))
                           (loop for (name val) in '((:MAIN 0) (:STANDARD 0)
                                                     (:BEFORE 100) (:AFTER -100)
                                                     (:PREPROCESS 200) (:POSTPROCESS -200))
                                 do (setf (gethash name map) val))
                           map))

(defclass event-handler ()
  ((%event-type :initarg :event-type :initform 'event :accessor event-type)
   (%priority :initarg :priority :initform 0 :accessor priority)
   (%identifier :initarg :identifier :initform (error "Identifier required.") :accessor identifier)
   (%handler-function :initarg :handler-function :initform (error "Handler function required.") :accessor handler-function))
  (:documentation ""))

(defun generate-handler-priority-cache (&optional (handler-map *handler-map*))
  (let ((priority-map (make-hash-table)))
    ;; Rebuild
    (loop for handler being the hash-values of handler-map
          do (if (gethash (event-type handler) priority-map)
                 (setf (gethash (event-type handler) priority-map) (list handler))
                 (push handler (gethash (event-type handler) priority-map))))
    ;; Sort
    (loop for event-type being the hash-keys of priority-map
          for handlers being the hash-values of priority-map
          do (setf (gethash event-type priority-map)
                   (sort handlers #'> :key #'priority)))
    (v:trace :event "Rebuilding priority map.")
    (setf *priority-map* priority-map)))

(defun define-handler-function (event-class identifier function &optional (priority :MAIN))
  (assert (symbolp identifier) () "IDENTIFIER has to be a symbol.")
  (setf priority (gethash priority *priority-names* priority))
  (assert (realp priority) () "PRIORITY has to be a real or a symbol from *PRIORITY-NAMES*.")
  
  (when (gethash identifier *handler-map*)
    (v:warn :event "Redefining handler ~a" identifier))
  (setf (gethash identifier *handler-map*)
        (make-instance 'event-handler :event-type event-class :priority priority :identifier identifier :handler-function function))
  (generate-handler-priority-cache)
  identifier)

(defun dispatch (event)
  (loop for handler in (gethash (type-of event) *priority-map*)
        until (cancelled event)
        do (funcall (handler-function handler) event))
  event)
