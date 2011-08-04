(add-to-list 'load-path "~/.emacs.d/vendor/zencoding")
(require 'zencoding-mode)

(add-hook 'nxml-mode 'zencoding-mode)
