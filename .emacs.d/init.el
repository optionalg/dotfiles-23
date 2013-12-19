(setenv "WITHIN_EMACS" "1")
(setenv "INSIDE_EMACS" "1")

(load-file (expand-file-name  "private.el" user-emacs-directory))

;; load-paths
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

;; lib and sub-dir
(setq user-lib-directory
      (expand-file-name "lib" user-emacs-directory))
(my/add-to-load-path user-lib-directory)
(my/add-subdir-to-load-path user-lib-directory)
;; vendor sub-dir
(setq user-vendor-directory
      (expand-file-name "vendor" user-emacs-directory))
(my/add-subdir-to-load-path user-vendor-directory)
;; el-get
(my/add-to-load-path "~/.emacs.d/el-get/el-get")

;; path
;; When opened from Desktep entry, PATH won't be set to shell's value.
(let ((path-str
           (replace-regexp-in-string
            "\n+$" "" (shell-command-to-string "echo $PATH"))))
     (setenv "PATH" (concat path-str ":" (getenv "PATH")))
     (setq exec-path (nconc (split-string (getenv "PATH") ":") exec-path)))
;; Custom Paths
;; より下に記述した物が PATH の先頭に追加されます
(dolist (dir (list
              "/sbin"
              "/usr/sbin"
              "/bin"
              "/usr/bin"
              "/opt/local/bin"
              "/sw/bin"
              "/usr/local/bin"
              (expand-file-name "~/bin")
              (expand-file-name "~/.emacs.d/local/bin")
              ))
  ;; PATH と exec-path に同じ物を追加します
  (when (and (file-exists-p dir) (not (member dir exec-path)))
    (setenv "PATH" (concat dir ":" (getenv "PATH")))
    (setq exec-path (append (list dir) exec-path))))

;; Exec inits
(load-file (expand-file-name  "init-loader.el" user-emacs-directory))
(require 'init-loader)
(init-loader-load (expand-file-name "inits" user-emacs-directory))
