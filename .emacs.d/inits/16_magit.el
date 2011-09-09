(add-to-list 'load-path "~/.emacs.d/vendor/magit")
(require 'magit)
(define-key global-map [(super g)] 'magit-status)
