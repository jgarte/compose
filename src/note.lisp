(in-package :jgart.compose)

(deftype pitch-integer ()
  '(integer 0 11))

(deftype octave () '(member :c1 :c2 :c3 :c4 :c5 :c6))

(defclass note-class ()
  ((note :initarg :note :accessor note :type pitch-integer)))

(deftype lilypond-note ()
  '(member
    :c-natural
    :c-sharp
    :d-natural
    :d-sharp
    :e-natural
    :f-natural
    :f-sharp
    :g-natural
    :g-sharp
    :a-natural
    :a-sharp
    :b-natural))

(deftype duration () '(member :whole-note :half-note))

(defclass note (note-class)
  ((octave :initarg :octave :accessor octave :type octave)
   (duration :initarg :duration :initform :whole-note :accessor duration :type duration)
   (lilypond-note :initarg :lilypond-note :accessor lilypond-note :type lilypond-note)))

(defmethod initialize-instance :after ((note note) &key)
  (with-accessors ((note note)
                   (octave octave)
                   (lilypond-note lilypond-note))
      note
    (check-type note pitch-integer)
    (check-type octave octave)
    (check-type lilypond-note lilypond-note)))

(defmethod print-object ((obj note) stream)
  (print-unreadable-object (obj stream :type t :identity t)
    (with-slots (note) obj
      (format stream "note: ~a~%" note))))

(defun parse-note (note)
  (etypecase note
    (string
     (multiple-value-bind (note pos)
         (parse-integer note)
       (declare (ignore pos))
       (make-instance 'note
                      :note note
                      :octave (map-note-to-octave note)
                      :lilypond-note (parse-lilypond-note note))))
    (integer
     (make-instance 'note
                    :note note
                    :octave (map-note-to-octave note)
                    :lilypond-note (parse-lilypond-note note)))))

(defun parse-lilypond-note (note)
  "Convert from a NOTE to a lilypond note."
  (case note
    (0 :c-natural)
    (1 :c-sharp)
    (2 :d-natural)
    (3 :d-sharp)
    (4 :e-natural)
    (5 :f-natural)
    (6 :f-sharp)
    (7 :g-natural)
    (8 :g-sharp)
    (9 :a-natural)
    (10 :a-sharp)
    (t :b-natural)))

(defun serialize-lilypond-note (note)
  "Serialize a lilypond note from a NOTE."
  (case note
    (:c-natural "c")
    (:c-sharp "cs")
    (:d-natural "d")
    (:d-sharp "ds")
    (:e-natural "e")
    (:f-natural "f")
    (:f-sharp "fs")
    (:g-natural "g")
    (:g-sharp "gs")
    (:a-natural "a")
    (:a-sharp "as")
    (:b-natural "b")))

(defun map-note-to-octave (note)
  "Map from a NOTE to an associated octave."
  (case note
    ((0 2 11 t) :c4)
    ((1 5 10) :c5)
    (3 :c6)
    ((4 9) :c2)
    ((6 7 8) :c3)))

(defun serialize-lilypond-octave (octave)
  "Serialize lilypond octave from an OCTAVE."
  (case octave
    (:c2 ",")
    (:c3 "")
    (:c4 "'")
    (:c5 "''")
    (:c6 "'''")))

(defun serialize-lilypond-duration (duration)
  "Serialize lilypond duration from a DURATION."
  (case duration
    (:whole-note "1")
    (:half-note "2")))
