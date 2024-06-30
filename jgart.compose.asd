(defsystem "jgart.compose"
  :depends-on ("charje.loop" "binding-arrows")
  :components ((:file "package")
               (:file "utils")
               (:file "universe")
               (:file "note")
               (:file "row")
               (:file "compose"))
  :build-operation "program-op"
  :entry-point "jgart.compose:main"
  :build-pathname #.(merge-pathnames #p"compose" (uiop:getcwd)))
