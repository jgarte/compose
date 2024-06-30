(in-package :jgart.compose)

(deftype note ()
  '(integer 0 11))

(deftype octave () '(member :c1 :c2 :c3 :c4 :c5 :c6))

(defclass note-class ()
  ((note :initarg :note :accessor note :type note)))

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

(defclass note (note-class)
  ((octave :initarg :octave :accessor octave :type octave)
   (lilypond-note :initarg :lilypond-note :accessor lilypond-note :type lilypond-note)))

(defmethod initialize-instance :after ((note note) &key)
  (with-accessors ((note note)
                   (octave octave)
                   (lilypond-note lilypond-note))
      note
    ;; (check-type note note)
    (check-type octave octave)
    (check-type lilypond-note lilypond-note)))

(defun parse-note (note)
  (multiple-value-bind (note pos)
      (parse-integer note)
    (declare (ignore pos))
    (make-instance 'note
                   :note note
                   :octave (parse-octave note)
                   :lilypond-note (parse-lilypond-note note))))

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

(defun parse-octave (note)
  "Convert from a NOTE to an octave."
  (case note
    (0 :c4)
    (1 :c5)
    (2 :c4)
    (3 :c6)
    (4 :c2)
    (5 :c5)
    (6 :c3)
    (7 :c3)
    (8 :c3)
    (9 :c2)
    (10 :c5)
    (t :c4)))
