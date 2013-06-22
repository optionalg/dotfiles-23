(reqpac 'magit)
(define-key global-map [(super g)] 'magit-status)

(require 'magit-flow)

(add-hook 'magit-mode-hook 'turn-on-magit-flow)
