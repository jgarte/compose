#!/bin/env -S sbcl --script
(require "asdf")
(require "uiop")
(let ((libs (uiop:subdirectories "libs/")))
  (dolist (lib libs)
   (pushnew lib asdf:*central-registry*)))
(pushnew (uiop:getcwd) asdf:*central-registry*)
(asdf:load-system "jgart.compose")
(asdf:make "jgart.compose")
