(setenv "WITHIN_EMACS" "1")
(setenv "INSIDE_EMACS" "1")

(load-file (expand-file-name  "private.el" user-emacs-directory))

(defun my/add-to-load-path (path)
  "Add path to load-path."
  (setq load-path
        (cons path
              load-path)))

(defun my/add-subdir-to-load-path (directory-path)
  (when (file-directory-p directory-path)
    (dolist (filename (directory-files directory-path))
      (let ((fullpath (expand-file-name filename directory-path)))
        (when (and (not (equal "." filename))
                   (not (equal ".." filename))
                   (file-directory-p fullpath))
          (message (format "added to loadpath: %S"
                           fullpath))
          (my/add-to-load-path fullpath))))))

;; load-paths
;; lib and sub-dir
(setq user-lib-directory
      (expand-file-name "lib" user-emacs-directory))
(my/add-to-load-path user-lib-directory)
(my/add-subdir-to-load-path user-lib-directory)
;; vendor sub-dir
(setq user-vendor-directory
      (expand-file-name "vendor" user-emacs-directory))
(my/add-subdir-to-load-path user-vendor-directory)


(my/add-to-load-path user-emacs-directory)
(require 'init-loader)
(init-loader-load (expand-file-name "inits" user-emacs-directory))
