(defpackage :jgart.compose
  (:use cl)
  (:import-from #:uiop #:split-string)
  (:import-from #:binding-arrows #:->)
  (:shadowing-import-from #:charje.loop
			  #:loop
			  #:map
			  #:collect
			  #:input-stream-iterator)
  (:export #:notes
	   #:comp
	   #:main))
