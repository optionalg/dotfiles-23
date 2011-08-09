(add-to-list 'load-path "~/.emacs.d/vendor/auto-complete")

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/vendor/auto-complete/dict")
(ac-config-default)

;; other than default
(add-to-list 'ac-modes 'coffee-mode)
(add-to-list 'ac-modes 'jade-mode)
(add-to-list 'ac-modes 'sws-mode)
(add-to-list 'ac-modes 'markdown-mode)
(add-to-list 'ac-modes 'js2-mode)
