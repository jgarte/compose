(in-package :jgart.compose)

(defun concat (&rest strings)
  (apply #'concatenate 'string strings))

(defun shuffle (list)
  (let* ((random-index (random (1- (length list))))
	 (random-value (nth random-index list))
	 (first-item-in-list (first list)))
    (setf (first list) random-value
	  (nth random-index list) first-item-in-list))
  list)



