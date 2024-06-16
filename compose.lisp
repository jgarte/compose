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
    (t "")))

(defun process-note (note duration)
  "DURATION is only given to the first note."
  (concat (-> note convert-note add-octave) duration))

(defun write-language (stream &optional (language "english"))
  (write-line (concat "\\language \"" language "\"") stream))

(defun write-version (stream &optional (version "2.25.12"))
  "TODO: Use lilypond --version to get the string?"
  (write-line
   (concat "\\version \"" version "\"") stream))

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
    (let ((first-timep t)
	  (duration "1"))
      (loop (tone-row tone-rows)
	    (when (<= (length tone-row)
		      (length *universe*))
	      (let* ((left-half tone-row)
		     (right-half (comp left-half))
		     (tone-row (append left-half right-half)))
		(loop (note tone-row)
		      (write-line (process-note note duration) stream)
		      (when first-timep
			(setf duration ""
			      first-timep nil)))))
	    (write-system-break stream)))))

;; TODO rename and refactor
(defun write-music (filepath-name stream)
  (write-line "{" stream)
  (write-line "\\omit TimeSignature" stream)
  (write-line "\\override Score.BarLine.transparent = ##t" stream)
  (write-line "\\override Score.BarNumber.break-visibility = #end-of-line-invisible" stream)
  (write-line "\\override Score.BarNumber.stencil = ##f" stream)
  (write-tone-rows filepath-name stream)
  (write-line "}" stream))

(defun write-score (filepath-name stream)
  (write-header stream)
  (write-line "\\paper { oddFooterMarkup = ##f evenFooterMarkup = ##f }" stream)
  (write-music filepath-name stream))

(defun lilypond (input-filepath)
  (uiop:launch-program (list "lilypond" input-filepath)))

(defun main
    (&optional (input-filepath (first (uiop:command-line-arguments)))
       (output-filepath "output.ly"))
  (with-open-file (stream output-filepath
			  :direction :output
			  :if-exists :supersede
			  :if-does-not-exist :create)
    (write-score input-filepath stream))
  (lilypond output-filepath))
