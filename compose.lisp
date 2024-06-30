(in-package :jgart.compose)

(defun write-language-directive (stream &optional (language "english"))
  (write-line (concat "\\language \"" language "\"") stream))

;;; With class I know what type it is
;;; I'm using the octave accessor on that
;; Parse the string and count how many apostrophes are in that string
(defun write-system-break-directive (stream)
  (write-line "\\break" stream))

(defun write-tone-rows (filepath-name stream)
  (let ((tone-rows (parse-tone-rows filepath-name)))
    (let ((first-timep t)
          (duration "1"))
      (loop (tone-row tone-rows)
        (when (<= (length tone-row)
                  (length *universe*))
          (let* ((left-half tone-row)
                 (right-half (-> left-half comp shuffle))
                 (tone-row (append left-half right-half)))
            (loop (note tone-row)
              (write-line (process-note note duration) stream)
              (when first-timep
                (setf duration ""
                      first-timep nil)))))
        (write-system-break-directive stream)))))

(defun write-music-body (filepath-name stream)
  (write-line "{" stream)
  (write-line "\\omit TimeSignature" stream)
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

(defun main (&optional
               (input-filepath (first (uiop:command-line-arguments)))
               (output-filepath "output.ly"))
  (setf *random-state* (make-random-state t))
  (write-music input-filepath output-filepath)
;;   (lilypond output-filepath))
