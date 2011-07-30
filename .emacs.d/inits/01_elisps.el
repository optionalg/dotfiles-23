(add-to-list 'load-path "~/.emacs.d/vendor/elisps")

(require 'auto-save-buffers)
(run-with-idle-timer 5 t 'auto-save-buffers)

(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)
(setq anything-samewindow nil)
(push '("*anything*" :height 20) popwin:special-display-config)

(require 'recentf)
(setq recentf-max-saved-items 1000)
(recentf-mode 1)

(autoload 'ac-mode "ac-mode" "Minor mode for advanced completion." t nil)
