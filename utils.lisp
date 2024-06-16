(in-package :jgart.compose)

(defun concat (&rest strings)
  (apply #'concatenate 'string strings))

(defun swap (list)
  (list (second list) (first list)))

(defun shuffle (list)
  (cond
    ((null list) list)
    ((= (length list) 1) (first list))
    ((= (length list) 2) (swap list))
    ((> (length list) 2)
     (let* ((random-index (random (1- (length list))))
	    (random-value (nth random-index list))
	    (first-item-in-list (first list)))
       (setf (first list) random-value
	     (nth random-index list) first-item-in-list)
       list))))



