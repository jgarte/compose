(defsystem "jgart.compose"
  :depends-on ("charje.loop" "binding-arrows")
  :components ((:file "package")
	       (:file "universe")
	       (:file "compose"))
  :build-operation "program-op"
  :entry-point "jgart.compose:main"
  :build-pathname #.(merge-pathnames #p"compose" (uiop:getcwd)))
