(require 'magit)
;; (require 'magithub)
(define-key global-map [(super g)] 'magit-status)

(require 'magit-flow)

(add-hook 'magit-mode-hook 'turn-on-magit-flow)

;; fix starting new Emacs
(set-variable 'magit-emacsclient-executable "/usr/local/Cellar/emacs/HEAD/bin/emacsclient")
