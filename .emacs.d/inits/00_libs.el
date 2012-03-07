; (add-to-list 'load-path "~/.emacs.d/lib/apel")
(load-file (concat user-emacs-directory "lib/mylib.el"))
(add-to-load-path "lib")

;; path
;; When opened from Desktep entry, PATH won't be set to shell's value.
(let ((path-str
           (replace-regexp-in-string
            "\n+$" "" (exec-shell-command-sync "echo" "$PATH"))))
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


;; ;; disable default load-path for cedet on emacs-version > 23
;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/lib/cedet-1.0/common"))
;; (load-file (expand-file-name "~/.emacs.d/lib/cedet-1.0/common/cedet.el"))

;; ;; semantic
;; (setq semantic-load-turn-useful-things-on t)
;; (unless (featurep 'cedet) (load "cedet"))
;; ;; enable semantic-imenu
;; (semantic-load-enable-code-helpers)
;; (semantic-load-enable-minimum-features)

;; deferred
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lib/emacs-deferred"))
(load-file (expand-file-name "~/.emacs.d/lib/emacs-deferred/deferred.el"))
(load-file (expand-file-name "~/.emacs.d/lib/emacs-deferred/concurrent.el"))

;; migemo
(require 'migemo)
(setq migemo-command "cmigemo")
(setq migemo-options '("-q" "--emacs" "-i" "\g"))
(setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
(setq migemo-user-dictionary nil)
(setq migemo-regex-dictionary nil)
(setq migemo-coding-system 'utf-8-unix)
(load-library "migemo")
(migemo-init)
