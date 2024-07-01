(defpackage :jgart.compose
  (:use cl)
  (:import-from #:uiop #:split-string)
  (:import-from #:binding-arrows #:->)
  (:shadowing-import-from #:charje.loop
                          #:collect
                          #:collecting
                          #:collecting-vector
                          #:iterator
                          #:loop
                          #:step
                          #:map)
  (:export #:main))
