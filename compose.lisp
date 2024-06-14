(in-package :jgart.compose)

(defun convert-note (note)
  "Convert from a pitch integer to a lilypond NOTE."
  (cond 
    ((string= "0" note) "c")
    ((string= "1" note) "cs")
    ((string= "2" note) "d")
    ((string= "3" note) "ds")
    ((string= "4" note) "e")
    ((string= "5" note) "f")
    ((string= "6" note) "fs")
    ((string= "7" note) "g")
    ((string= "8" note) "gs")
    ((string= "9" note) "a")
    ((string= "10" note) "as")
    ((string= "11" note) "b")
    (t "")))

(defun add-octave (note)
  (flet ((concat (note octave)
	   (concatenate 'string note octave)))
    (cond 
      ((string= "c" note) (concat note "'"))
      ((string= "cs" note) (concat note "''"))
      ((string= "d" note) (concat note "'"))
      ((string= "ds" note) (concat note "'''"))
      ((string= "e" note) (concat note "'''"))
      ((string= "f" note) (concat note ""))
      ((string= "fs" note) (concat note "'"))
      ((string= "g" note) (concat note "'"))
      ((string= "gs" note) (concat note ""))
      ((string= "a" note) (concat note ""))
      ((string= "as" note) (concat note ""))
      ((string= "b" note) (concat note "''"))
      (t ""))))

(defun process-note (note)
  (-> note convert-note add-octave))

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
    (-> (input-stream-iterator f)
      (map #'uiop:split-string)
      collect)))

(defun write-system-break (stream)
  (write-line "\\break" stream))

(defun write-tone-rows (filepath-name stream)
  (let ((tone-rows (parse-tone-rows filepath-name)))
    (loop (tone-row tone-rows)
	  (if (< (length tone-row)
		 (length *universe*))
	      (let* ((left-half tone-row)
		     (right-half (comp tone-row))
		     (tone-row (append left-half right-half)))
		(loop (note tone-row)
		      (write-line (process-note note) stream)))
	      (loop (note tone-row)
		    (write-line (process-note note) stream)))
	  (write-system-break stream))))

(defun write-music (filepath-name stream)
  (write-line "{" stream)
  (write-line "\\override Score.BarLine.transparent = ##t" stream)
  (write-tone-rows filepath-name stream)
  (write-line "}" stream))

(defun write-score (filepath-name stream)
  (write-header stream)
  (write-music filepath-name stream))

(defun main (&optional (filepath-name (first (uiop:command-line-arguments))))
  (with-open-file (stream "output.ly"
			  :direction :output
			  :if-exists :supersede
			  :if-does-not-exist :create)
    (write-score filepath-name stream)))
