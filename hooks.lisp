(in-package :quickproject)

(defvar *after-make-project-hooks* nil
  "A list of functions to call after MAKE-PROJECT is finished making a
  project. It is called with the same arguments passed to
  MAKE-PROJECT, except that NAME is canonicalized if necessary.")

;; TODO: Instead of &key docs do (when (stringp docs) ...)?
(defmacro defhook (name (&key docs) &body body)
  "Define a function with the given NAME and an appropriate lambda list,
pushing it onto *after-make-project-hooks* after definition. BODY will be
executed inside a LABELS providing RELATIVE and NAMETYPE functions as in
WRITE-PROJECT-FILES."
  `(progn
     (defun ,name (pathname &key depends-on name)
       ,@(when docs (list docs))
       (labels ((relative (file &optional (path pathname))
                  (merge-pathnames file path))
                (nametype (type)
                  (relative (make-pathname :name name :type type))))
         ,@body))
     (pushnew ',name *after-make-project-hooks*)))

(defun toggle-hook (hook)
  "Add or remove HOOK from *AFTER-MAKE-PROJECT-HOOKS*."
  (if (member hook *after-make-project-hooks*)
      (delete hook *after-make-project-hooks*)
      (push hook *after-make-project-hooks*)))
