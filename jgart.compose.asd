(defsystem "jgart.compose"
  :components
  ((:module "src"
    :serial t
    :components
    ((:file "package")
     (:file "utils")
     (:file "note")
     (:file "universe")
     (:file "row")
     (:file "io")
     (:file "main"))))
  :build-operation "program-op"
  :entry-point "jgart.compose:main"
  :build-pathname #.(merge-pathnames #p"compose" (uiop:getcwd)))
