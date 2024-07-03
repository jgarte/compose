(in-package :jgart.compose)

(defun read-lines (filepath-name)
  (let (lines)
    (with-open-file (stream filepath-name)
      (do ((line (read-line stream nil) (read-line stream nil)))
          ((null line))
        (push line lines)))
    (nreverse lines)))

(defun normalize (lines)
  (remove ""
          (remove-if (lambda (s) (string= " " s)) lines)
          :test #'string=))

(defun read-tone-rows (filepath-name)
  (let ((result '()))
    (let ((rows (read-lines filepath-name)))
      (dolist (row rows)
        (push (normalize (split-string row)) result)))
    (nreverse result)))

(defun parse-tone-rows (filepath-name)
  (let ((result '())
        (tone-rows (read-tone-rows filepath-name)))
    (let ((tone-row-index 1))
      (dolist (tone-row tone-rows)
        (when (or (> tone-row-index (length tone-rows))
                  (/= (length *universe*) (length tone-row)))
          (format *error-output*
                  "You supplied ~a notes on line ~a but only 12 notes are allowed per line.~%"
                  (length tone-row)
                  tone-row-index)
          (uiop:quit))
        (let ((row (make-list (length *universe*) :initial-element nil))
              (index 0))
          (dolist (note tone-row)
            (setf (elt row index) (parse-note note))
            (incf index))
          (push row result))
        (incf tone-row-index)))
    result))
