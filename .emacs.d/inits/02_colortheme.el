(add-to-list 'load-path "~/.emacs.d/vendor/color-theme")
(require 'color-theme)
(eval-after-load "color-theme"
                 '(progn
                    (color-theme-initialize)
                    (color-theme-dark-laptop)))
