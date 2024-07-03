(in-package :jgart.compose)

(defun main (&optional
               (input-filepath (first (uiop:command-line-arguments)))
               (output-filepath "output.ly"))
  (when (member "--help" (uiop:command-line-arguments) :test #'string=)
    (format t "Usage: compose [FILE]...~%")
    (uiop:quit))
  (setf *random-state* (make-random-state t))
  (write-music input-filepath output-filepath)
  (lilypond output-filepath))
