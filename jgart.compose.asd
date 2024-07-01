(defsystem "jgart.compose"
  :depends-on ("charje.loop" "binding-arrows")
  :components
  ((:module "src"
    :serial t
    :components
    ((:file "package")
     (:file "utils")
     (:file "universe")
     (:file "note")
     (:file "row")
     (:file "io")
     (:file "main"))))
  :build-operation "program-op"
  :entry-point "jgart.compose:main"
  :build-pathname #.(merge-pathnames #p"compose" (uiop:getcwd)))
