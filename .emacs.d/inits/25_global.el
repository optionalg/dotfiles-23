(add-to-load-path "vendor/global")
(require 'gtags)

;; Use with helm
(reqpack 'helm)
(reqpack 'helm-gtags)

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
