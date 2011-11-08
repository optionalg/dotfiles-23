(add-to-list 'load-path
              "~/.emacs.d/vendor/yasnippet-0.6.1c")

(require 'yasnippet) ;; not yasnippet-bundle
;; (require 'anything-c-yasnippet)

(setq anything-c-yas-space-match-any-greedy t)
(global-set-key (kbd "C-c y") 'anything-c-yas-complete)
(yas/initialize)
(yas/load-directory "~/.emacs.d/vendor/yasnippet-0.6.1c/snippets")

(require 'dropdown-list)
(setq yas/prompt-functions '(yas/dropdown-prompt))

;; for auto-complete
(require 'auto-complete-yasnippet)

