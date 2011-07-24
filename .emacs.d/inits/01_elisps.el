(add-to-list 'load-path "~/.emacs.d/vendor/elisps")

(require 'auto-save-buffers)
(run-with-idle-timer 5 t 'auto-save-buffers)
