(use-modules (guix packages)
             ((guix licenses) #:prefix license:)
             (guix gexp)
             (guix git-download)
             (guix build-system asdf)
             (guix utils)
             (guix packages)
             (gnu packages lisp)
             (gnu packages lisp-xyz))

(define (local-checkout)
  (local-file
   (dirname (current-filename)) #:recursive? #t))

(define-syntax lisp-package-for-development
  (lambda (x)
    (syntax-case x ()
      ((_ name inputs)
       #`(begin
	   (define-public name
	     (package
	       (name name)
	       (version "0.0.0")
	       (source (local-checkout))
	       (build-system asdf-build-system/sbcl)
	       (native-inputs (list sbcl sbcl-slynk))
	       (inputs inputs)
	       (synopsis "")
	       (home-page "")
	       (description "")
	       (license #f)))
	   
	   (define-public name
	     (sbcl-package->cl-source-package ,(symbol-append sbcl- name)))
	   
	   (define-public name
	     (sbcl-package->ecl-package name)))))))

(define-public sbcl-jgart.compose
  (package
    (name "sbcl-jgart.compose")
    (version "0.0.0")
    (source (local-checkout))
    (build-system asdf-build-system/sbcl)
    (native-inputs (list sbcl sbcl-slynk))
    (inputs (list sbcl-binding-arrows sbcl-charje.loop))
    (synopsis "DSL for composing with twelve tones")
    (home-page "https://git.sr.ht/~whereiseveryone/compose")
    (description "This package provides a domain specific language for
composing music with twelve tone rows.")
    (license license:agpl3+)))

(define-public cl-jgart.compose
  (sbcl-package->cl-source-package sbcl-jgart.compose))

(define-public ecl-jgart.compose
  (sbcl-package->ecl-package sbcl-jgart.compose))

cl-jgart.compose
