(in-package :jgart.compose)

(deftype twelve-tone-row () '(array 12 (or null note)))

(defun init-twelve-tone-row ()
  (make-array 12
              :element-type '(or note null)
              :initial-element nil))

(defun read-tone-rows (filepath-name)
  (with-open-file (f filepath-name)
    (-> f iterator
        (map #'uiop:split-string)
        collect)))

(defun parse-tone-rows (filepath-name)
  (let ((result '())
        (row (init-twelve-tone-row))
        (tone-rows (read-tone-rows filepath-name)))
    (loop (tone-row tone-rows)
      (loop ((note tone-row)
             (i (step)))
        (setf (aref row i) (parse note)))
      (push row result))
    result))
