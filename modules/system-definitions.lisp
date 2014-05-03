#|
 This file is a part of Colleen
 (c) 2013 TymoonNET/NexT http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package :org.tymoonnext.colleen)

(define-module-system auth ("authenticate"))
(define-module-system backup ("backup") (:trivial-timers :cl-fad))
(define-module-system chatlog ("chatlog") (:clsql :clsql-mysql))
(define-module-system convert ("convert") (:drakma :ieee-floats :ironclad :parse-number :cl-json))
(define-module-system core ("core"))
(define-module-system counter ("counter"))
(define-module-system dictionary ("dictionary") (:alexandria))
(define-module-system dramatica ("dramatica") (:xencl :cl-wiki))
(define-module-system emoticon ("emoticon"))
(define-module-system essentials ("essentials") (:uiop :local-time :alexandria))
(define-module-system eval ("eval"))
(define-module-system google ("google" "google-lng") (:split-sequence :drakma :cl-json))
(define-module-system markov ("markov"))
(define-module-system medals ("medals"))
(define-module-system notify ("notify"))
(define-module-system rss ("rss") (:lquery :drakma :cl-json))
(define-module-system rules ("rules") (:alexandria))
(define-module-system search ("search") (:lquery :split-sequence :drakma :cl-wiki))
(define-module-system shiritori ("shiritori"))
(define-module-system silly ("silly") (:cl-ppcre))
(define-module-system stevenchan ("stevenchan") (:lquery :drakma :alexandria))
(define-module-system syslog ("syslog"))
(define-module-system markov-twitter-bridge ("markov-twitter-bridge") (:co-markov :chirp))
(define-module-system twitter ("twitter") (:chirp))
(define-module-system weather ("weather") (:drakma :cl-json))
