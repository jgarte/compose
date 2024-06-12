(in-package :jgart.compose)

(defvar *universe* '(0 1 2 3 4 5 6 7 8 9 10 11))

(defun set-complement (larger-set smaller-set &key (test #'eql))
  "Return the complement of SMALLER-SET with respect to LARGER-SET."
  (remove-if (lambda (element)
               (member element smaller-set :test test))
             larger-set))

(deftype notes () `(member ,@*universe*))

(defun comp (s)
  (set-complement *universe* s))

(defun parse-pitch-integer (ch)
  (flet ((convert (ch)
	   (parse-integer (string ch))))
    (case ch
      (#\0 (convert ch))
      (#\1 (convert ch))
      (#\2 (convert ch))
      (#\3 (convert ch))
      (#\4 (convert ch))
      (#\5 (convert ch))
      (#\6 (convert ch))
      (#\7 (convert ch))
      (#\8 (convert ch))
      (#\9 (convert ch))
      (#\Newline "newline")
      (otherwise ""))))

(defun write-language (stream &optional (language "english"))
  (write-line
   (concatenate 'string "\\language \"" language "\"") stream))

(defun write-version (stream &optional (version "2.25.12"))
  "TODO: Use lilypond --version to get the string?"
  (write-line
   (concatenate 'string "\\version \"" version "\"") stream))

(defun write-header (stream)
  (write-language stream)
  (write-version stream))

(defun parse-music-helper (ch)
  (parse-pitch-integer ch))

(defun parse-music (&optional (file "compose.txt"))
  (with-open-file (f file)
    (-> (input-stream-iterator f :parser #'read-char)
      (take-while 
       (lambda (m)
	 m
	 ;; (and (stringp m)
	 ;;      (string/= m "newline"))
	 ))
      ;; (map #'cons)
      collect)))

;; (defun read-music (stream)
;;   (write-lilypond-header stream)
;;   (write-line "{" stream)
;;   ;; (write-line (parse-note ch) stream)
;;   (write-line "}" stream))

;; (defun write-music (&optional (output-file "output.ly"))
;;   (with-open-file (stream output-file
;; 			  :direction :output
;; 			  :if-exists :supersede
;; 			  :if-does-not-exist :create)
    
;;     (read-music stream)))
