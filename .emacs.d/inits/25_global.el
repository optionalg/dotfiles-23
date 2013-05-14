;; Install gnu global
;;
;; On Mac:
;;     $ brew install global --with-exuberant-ctags
;;     $ brew link --overwrite ctags #if necessary, remove emacs bundled ctags
;;
;; Set EnVar(bash/zsh):
;;     export GTAGSLABEL=exuberant-ctags

(add-to-load-path "vendor/global")
(require 'gtags)

;; Use with helm
(reqpack 'helm)
(reqpack 'helm-gtags)
(custom-set-variables '(helm-gtags-read-only nil))

;;; Enable helm-gtags-mode
(dolist (hook '(asm-mode-hook c-mode-common-hook))
  (add-hook hook '(lambda()
                    (helm-gtags-mode))))

;; customize
(setq helm-gtags-path-style 'relative)
(setq helm-gtags-ignore-case t)
(setq helm-gtags-read-only t)

;; key bindings (evil integration)
(reqpack 'evil)
(define-key evil-normal-state-map (kbd "C-]") 'helm-gtags-find-tag)
(define-key evil-normal-state-map (kbd "C-=") 'helm-gtags-find-rtag) ;reference
(define-key evil-normal-state-map (kbd "C-/") 'helm-gtags-find-symbol)
(define-key evil-normal-state-map (kbd "C-t") 'helm-gtags-pop-stack)

;; update tags files on saving files
;; http://qiita.com/items/8e8c7fca64b4810d8e78
(defun my/update-gtags ()
  (let* ((file (buffer-file-name (current-buffer)))
         (dir (directory-file-name (file-name-directory file))))
    (when (executable-find "global")
      (start-process "gtags-update" nil
                     "global" "-uvO"))))
(add-hook 'after-save-hook 'my/update-gtags)
