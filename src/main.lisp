(in-package :jgart.compose)

(defun check-arg (arg)
  (member arg (uiop:command-line-arguments) :test #'string=))

(defun main (&optional
               (input-filepath (first (uiop:command-line-arguments)))
               (output-filepath "output.ly"))
  (when (or (check-arg "--help")
            (null input-filepath))
    (format t "Usage: compose [FILE]...~%")
    (uiop:quit))
  (write-music input-filepath output-filepath)
  (lilypond output-filepath))
