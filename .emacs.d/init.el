(setenv "WITHIN_EMACS" "1")
(setenv "INSIDE_EMACS" "1")

(load-file (expand-file-name  "private.el" user-emacs-directory))

(add-to-list 'load-path "~/.emacs.d")
(require 'init-loader)
(init-loader-load "~/.emacs.d/inits")
