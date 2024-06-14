(defpackage :jgart.compose
  (:use cl)
  (:import-from #:binding-arrows #:->)
  (:import-from #:alexandria #:curry)
  (:shadowing-import-from #:charje.loop
			  #:loop
			  #:map
			  #:collect
			  #:input-stream-iterator)
  (:export #:main))
