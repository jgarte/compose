(in-package :jgart.compose)

(defun main (&optional
               (input-filepath (first (uiop:command-line-arguments)))
               (output-filepath "output.ly"))
  (setf *random-state* (make-random-state t))
  (write-music input-filepath output-filepath)
  (lilypond output-filepath))
