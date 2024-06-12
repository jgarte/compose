(defsystem "jgart.compose"
  :depends-on ("charje.loop" "str" "binding-arrows")
  :components ((:file "package")
	       (:file "compose")))
