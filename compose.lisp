(in-package :jgart.compose)

(defun comp (s)
  (set-complement *universe* s))

(defun convert-note (note)
  "Convert from a pitch integer to a lilypond NOTE."
  (case note
    ("0" "c")
    ("1" "cs")
    ("2" "d")
    ("3" "ds")
    ("4" "e")
    ("5" "f")
    ("6" "fs")
    ("7" "g")
    ("8" "gs")
    ("9" "a")
    ("10" "as")
    ("11" "b")))

(defun write-language (stream &optional (language "english"))
  (write-line
   (concatenate 'string "\\language \"" language "\"") stream))

(defun write-version (stream &optional (version "2.25.12"))
  "TODO: Use lilypond --version to get the string?"
  (write-line
   (concatenate 'string "\\version \"" version "\"") stream))

(defun write-header (stream)
  (write-language stream)
  (write-version stream))

(defun parse-tone-rows (filepath-name)
  (with-open-file (f filepath-name)
    ;; TODO: Remove once fixed packaged upstream.
    (-> (input-stream-iterator
	 f :parser (lambda (stream) (values (read-line stream))))
	(map (curry #'str:split " "))
	collect)))

(defun write-system-break (stream)
  (write-line "\\break" stream))

(defun write-tone-rows (filepath-name stream)
  (let ((tone-rows (parse-tone-rows filepath-name)))
    (loop (tone-row tone-rows)
	  (loop (note tone-row)
		(write-line (convert-note note) stream)
		(write-system-break stream)))))

(defun write-music (filepath-name stream)
  (write-line "{" stream)
  (write-tone-rows filepath-name stream)
  (write-line "}" stream))

(defun write-score (filepath-name stream)
  (write-header stream)
  (write-music filepath-name stream))

(defun main (&aux (filepath-name (first (uiop:command-line-arguments))))
  (with-open-file (stream "output.ly"
			  :direction :output
			  :if-exists :supersede
			  :if-does-not-exist :create)
    (write-score filepath-name stream)))
