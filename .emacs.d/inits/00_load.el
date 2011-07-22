(add-to-list 'load-path "~/.emacs.d/vender/elisps")
(require 'auto-save-buffers)
(run-with-idle-timer 0.5 t 'auto-save-buffers)

(add-to-list 'load-path "~/.emacs.d/vimpulse")
(require 'vimpulse)

(add-to-list 'load-path "~/.emacs.d/vendor/coffee-mode")
(require 'coffee-mode)

