(require 'cl)

(load-file (concat user-emacs-directory "lib/mylib.el"))


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
(load-file (expand-file-name "~/.emacs.d/lib/emacs-deferred/deferred.el"))
(load-file (expand-file-name "~/.emacs.d/lib/emacs-deferred/concurrent.el"))

;; migemo
(setq migemo-command (executable-find "cmigemo"))
(when migemo-command
  (setq migemo-options '("-q" "--emacs" "-i" "\g"))
  (setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)
  (setq migemo-coding-system 'utf-8-unix)
  (require 'migemo)
  (load-library "migemo")
  (migemo-init)
  (set-process-query-on-exit-flag (get-process "migemo") nil))
