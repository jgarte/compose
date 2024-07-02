(in-package :jgart.compose)

(defvar *universe*
  (mapcar #'parse '(0 1 2 3 4 5 6 7 8 9 10 11)))

(defun note-equal (note other-note)
  (when (and note other-note)
      (equal (note note) (note other-note))))

(defun set-complement (larger-set smaller-set &key (test #'note-equal))
  "Return the complement of SMALLER-SET with respect to LARGER-SET."
  (remove-if (lambda (element)
               (member element smaller-set :test test))
             larger-set))

(defun comp (s)
  (set-complement *universe* s))
