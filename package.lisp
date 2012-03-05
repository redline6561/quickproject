;;;; package.lisp

(defpackage #:quickproject
  (:use #:cl)
  (:export #:make-project
           #:*after-make-project-hooks*
           #:defhook
           #:toggle-hook))

(in-package #:quickproject)

