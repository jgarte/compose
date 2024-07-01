(in-package :jgart.compose)

(defclass tone-row ()
  ((note-one :initarg :note-one :accessor note-one :type note)
   (note-two :initarg :note-two :accessor note-two :type note)
   (note-three :initarg :note-three :accessor note-three :type note)
   (note-four :initarg :note-four :accessor note-four :type note)
   (note-five :initarg :note-five :accessor note-five :type note)
   (note-six :initarg :note-six :accessor note-six :type note)
   (note-seven :initarg :note-seven :accessor note-seven :type note)
   (note-eight :initarg :note-eight :accessor note-eight :type note)
   (note-nine :initarg :note-nine :accessor note-nine :type note)
   (note-ten :initarg :note-ten :accessor note-ten :type note)
   (note-eleven :initarg :note-eleven :accessor note-eleven :type note)
   (note-twelve :initarg :note-twelve :accessor note-twelve :type note)))

(defmethod initialize-instance :after ((tone-row tone-row) &key)
  (with-accessors ((note-one note-one)
                   (note-two note-two)
                   (note-three note-three)
                   (note-four note-four)
                   (note-five note-five)
                   (note-six note-six)
                   (note-seven note-seven)
                   (note-eight note-eight)
                   (note-nine note-nine)
                   (note-ten note-ten)
                   (note-eleven note-eleven)
                   (note-twelve note-twelve))
      tone-row
    (check-type note-one note)
    (check-type note-two note)
    (check-type note-three note)
    (check-type note-four note)
    (check-type note-five note)
    (check-type note-six note)
    (check-type note-seven note)
    (check-type note-eight note)
    (check-type note-nine note)
    (check-type note-ten note)
    (check-type note-eleven note)
    (check-type note-twelve note)))

(defmethod print-object ((obj tone-row) stream)
  (print-unreadable-object (obj stream :type t :identity t)
    (with-slots (note-one note-two note-three note-four note-five note-six note-seven note-eight note-nine note-ten note-eleven note-twelve) obj
      (format stream
              "~a ~a ~a ~a ~a ~a ~a ~a ~a ~a ~a ~a"
              (note note-one)
              (note note-two)
              (note note-three)
              (note note-four)
              (note note-five)
              (note note-six)
              (note note-seven)
              (note note-eight)
              (note note-nine)
              (note note-ten)
              (note note-eleven)
              (note note-twelve)))))

(defun tone-row-to-list-of-notes (tone-row)
  (list (note-one tone-row)
        (note-two tone-row)
        (note-three tone-row)
        (note-four tone-row)
        (note-five tone-row)
        (note-six tone-row)
        (note-seven tone-row)
        (note-eight tone-row)
        (note-nine tone-row)
        (note-ten tone-row)
        (note-eleven tone-row)
        (note-twelve tone-row)))

(defun from-universe (tone-row)
  (destructuring-bind (note-one
                       note-two
                       note-three
                       note-four
                       note-five
                       note-six
                       note-seven
                       note-eight
                       note-nine
                       note-ten
                       note-eleven
                       note-twelve)
      tone-row
    (make-instance 'tone-row
                   :note-one (parse-note note-one) ; todo i shouldn't parse here
                   :note-two (parse-note note-two)
                   :note-three (parse-note note-three)
                   :note-four (parse-note note-four)
                   :note-five (parse-note note-five)
                   :note-six (parse-note note-six)
                   :note-seven (parse-note note-seven)
                   :note-eight (parse-note note-eight)
                   :note-nine (parse-note note-nine)
                   :note-ten (parse-note note-ten)
                   :note-eleven (parse-note note-eleven)
                   :note-twelve (parse-note note-twelve))))

(defun parse-tone-row (tone-row)
  (destructuring-bind (note-one
                       note-two
                       note-three
                       note-four
                       note-five
                       note-six
                       note-seven
                       note-eight
                       note-nine
                       note-ten
                       note-eleven
                       note-twelve)
      tone-row
    (make-instance 'tone-row :note-one (parse-note note-one)
                             :note-two (parse-note note-two)
                             :note-three (parse-note note-three)
                             :note-four (parse-note note-four)
                             :note-five (parse-note note-five)
                             :note-six (parse-note note-six)
                             :note-seven (parse-note note-seven)
                             :note-eight (parse-note note-eight)
                             :note-nine (parse-note note-nine)
                             :note-ten (parse-note note-ten)
                             :note-eleven (parse-note note-eleven)
                             :note-twelve (parse-note note-twelve))))

(defun read-tone-rows (filepath-name)
  (with-open-file (f filepath-name)
    (-> f iterator
        (map #'uiop:split-string)
        collect)))

(defun parse-tone-rows-helper (tone-rows)
  (loop (tone-row tone-rows)
    (when (<= (length tone-row)
              (length *universe*))
      (collecting (parse-tone-row tone-row)))))

;; (defun parse-tone-rows-helper (tone-rows)
;;   (loop (tone-row tone-rows)
;;     (when (<= (length tone-row)
;;               (length *universe*))
;;       (let* ((left-half tone-row)
;;              (right-half (-> left-half comp shuffle))
;;              (tone-row (append left-half right-half)))
;;         (collecting (parse-tone-row tone-row))))))

(defun parse-tone-rows (filepath-name)
  (let ((tone-rows (read-tone-rows filepath-name)))
    (parse-tone-rows-helper tone-rows)))
