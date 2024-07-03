(in-package :jgart.compose)

(defun write-language-directive (stream &optional (language "english"))
  (write-line (concat "\\language \"" language "\"") stream))

(defun write-system-break-directive (stream)
  (write-line "\\break" stream))

(defun write-tone-rows (filepath-name stream)
  (let ((tone-rows (parse-tone-rows filepath-name)))
    (dolist (tone-row tone-rows)
      (dolist (note tone-row)
        (write-line
         (concatenate 'string
                      (serialize-lilypond-note (lilypond-note note))
                      (serialize-lilypond-octave (octave note))
                      (serialize-lilypond-duration (duration note)))
         stream))))
  (write-system-break-directive stream))

(defun write-music-body (filepath-name stream)
  (write-line "{" stream)
  (write-line "\\override Staff.TimeSignature.stencil = ##f" stream)
  (write-line "\\override Score.BarLine.transparent = ##t" stream)
  (write-line "\\override Score.BarNumber.break-visibility = #end-of-line-invisible" stream)
  (write-line "\\override Score.BarNumber.stencil = ##f" stream)
  (write-tone-rows filepath-name stream)
  (write-line "}" stream))

(defun write-score (filepath-name stream)
  (write-language-directive stream)
  (write-line "\\paper { oddFooterMarkup = ##f evenFooterMarkup = ##f }" stream)
  (write-music-body filepath-name stream))

(defun write-music (input-filepath output-filepath)
  (with-open-file (stream output-filepath
                          :direction :output
                          :if-exists :supersede
                          :if-does-not-exist :create)
    (write-score input-filepath stream)))

(defun lilypond (input-filepath)
  (uiop:launch-program (list "lilypond" "--silent" input-filepath)))
