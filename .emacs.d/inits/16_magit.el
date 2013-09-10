(reqpac 'magit)
(define-key global-map [(super g)] 'magit-status)

(add-to-load-path "vendor/magit-plugins")
(require 'magit-flow)

(add-hook 'magit-mode-hook 'turn-on-magit-flow)
