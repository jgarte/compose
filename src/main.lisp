(in-package :jgart.compose)

(defun check-arg (arg)
  (member arg (uiop:command-line-arguments) :test #'string=))

(defun check-no-arg ()
  (when (null (uiop:command-line-arguments))
    (print-help)
    (uiop:quit)))

(defun print-help ()
  (format t "Usage: compose [FILE]...~%"))

(defun check-help-flag ()
  (when (check-arg "--help")
    (print-help)
    (uiop:quit)))

(defun check-too-many-args ()
  (when (> (length (uiop:command-line-arguments)) 1)
    (print-help)
    (uiop:quit)))

(defun check-missing-file-arg (file)
  (when (and file
             (not (file-exists-p file)))
    (format *error-output* "`~A' does not exist.~%" file)
    (uiop:quit)))

(defun main (&optional
               (input-filepath (first (uiop:command-line-arguments)))
               (output-filepath "output.ly"))
  (check-no-arg)
  (check-help-flag)
  (check-missing-file-arg input-filepath)
  (check-too-many-args)
  (write-music input-filepath output-filepath)
  (lilypond output-filepath))
