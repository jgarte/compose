#!/bin/env -S sbcl --script
(require "asdf")
(pushnew #P"/home/jgart/quicklisp/local-projects/loop/" asdf:*central-registry*)
(pushnew #P"/home/jgart/quicklisp/local-projects/documentation/" asdf:*central-registry*)
(pushnew #P"/home/jgart/quicklisp/local-projects/compose-one/" asdf:*central-registry*)
(asdf:load-system "jgart.compose")
(asdf:make "jgart.compose")
