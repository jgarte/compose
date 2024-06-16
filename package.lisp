(defpackage :jgart.compose
  (:use cl)
  (:import-from #:uiop #:split-string)
  (:import-from #:binding-arrows #:->)
  (:shadowing-import-from #:charje.loop
			  #:collect
			  #:input-stream-iterator
			  #:loop
			  #:map)
  (:export #:notes
	   #:comp
	   #:main))
