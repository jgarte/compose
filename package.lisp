(defpackage :jgart.compose
  (:use cl)
  (:import-from #:binding-arrows #:->)
  (:shadowing-import-from #:charje.loop
			  #:loop
			  #:take-while
			  #:collect
			  #:finally
			  #:input-stream-iterator))
