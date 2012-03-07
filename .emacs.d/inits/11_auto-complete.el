(add-to-list 'load-path "~/.emacs.d/vendor/auto-complete")

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
(ac-config-default)
(global-auto-complete-mode t)
(define-key ac-mode-map (kbd "TAB") 'auto-complete)

(add-to-list 'ac-modes 'coffee-mode)
(add-to-list 'ac-modes 'jade-mode)
(add-to-list 'ac-modes 'sws-mode)
(add-to-list 'ac-modes 'markdown-mode)
(add-to-list 'ac-modes 'js2-mode)
(add-to-list 'ac-modes 'jde-mode)
(add-to-list 'ac-modes 'nxml-mode)
