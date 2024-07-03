(in-package :jgart.compose)

(defun concat (&rest strings)
  (apply #'concatenate 'string strings))
