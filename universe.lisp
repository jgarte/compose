(in-package :jgart.compose)

(defvar *universe* '("0" "1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11"))

(defun set-complement (larger-set smaller-set &key (test #'equal))
  "Return the complement of SMALLER-SET with respect to LARGER-SET."
  (remove-if (lambda (element)
               (member element smaller-set :test test))
             larger-set))

(deftype notes () `(member ,@*universe*))

(defun comp (s)
  (set-complement *universe* s))
