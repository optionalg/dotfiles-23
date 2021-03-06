;; for vimpulse
;; <ESC> once to normal mode
;; from: https://sites.google.com/site/fudist/Home/vimpulse
(setq ac-use-quick-help nil)
(setq ac-use-menu-map t)
(setq ac-auto-start nil)
(setq ac-dictionary-directories (list "~/.emacs.d/vendor/auto-complete/dict"))
(require 'auto-complete-config)

;; for vimpulse
;; ESC が先立つキーバインドが無効になる・・
(define-key ac-complete-mode-map "\C-[" 'evil-esc)
;(ac-config-default)
(global-auto-complete-mode t)
;(define-key ac-mode-map (kbd "TAB") 'auto-complete)
(ac-set-trigger-key "TAB")
(setq ac-candidate-max 20)

(add-to-list 'ac-modes 'coffee-mode)
(add-to-list 'ac-modes 'jade-mode)
(add-to-list 'ac-modes 'stylus-mode)
(add-to-list 'ac-modes 'sws-mode)
(add-to-list 'ac-modes 'markdown-mode)
(add-to-list 'ac-modes 'js2-mode)
(add-to-list 'ac-modes 'jde-mode)
(add-to-list 'ac-modes 'nxml-mode)
(add-to-list 'ac-modes 'makefile-mode)

(defun my/ac-ruby-mode-setup ()
  (setq ac-sources (append '(ac-source-yasnippet ac-source-gtags) ac-sources)))

(defun my/ac-config-default ()
  (setq-default ac-sources '(ac-source-abbrev ac-source-dictionary ac-source-yasnippet ac-source-words-in-same-mode-buffers))
  (add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)
  (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
  (add-hook 'ruby-mode-hook 'my/ac-ruby-mode-setup)
  (add-hook 'css-mode-hook 'ac-css-mode-setup)
  (add-hook 'auto-complete-mode-hook 'ac-common-setup)
  (global-auto-complete-mode t))

(my/ac-config-default)

;; Mode Specific
(add-hook
 'ruby-mode-hook '(lambda ()
                    (define-key ruby-mode-map (kbd "TAB") nil))) ;ruby-indent-line conflicts with auto-complete
