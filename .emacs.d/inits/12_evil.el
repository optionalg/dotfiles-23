(add-to-load-path "vendor/evil")
(setq evil-shift-width 2)
(require 'evil)
(evil-mode 1)

(setq my-evil-hjkl-maps
      '(("d" evil-backward-char)
        ("h" evil-next-line)
        ("t" evil-previous-line)
        ("n" evil-forward-char)
        ("k" evil-delete)))

(dolist (map my-evil-hjkl-maps)
  (apply 'define-key evil-normal-state-map map)
  (apply 'define-key evil-visual-state-map map)
  )

;; Prevent quit command from exit Emacs
(defun my-kill-current-butffer ()
  :repeat nil
  (interactive)
  (kill-buffer (current-buffer)))

(evil-ex-define-cmd "q[uit]" 'my-kill-current-butffer)

;; plugins
(add-to-load-path "vendor/evil-plugins")

(require 'evil-numbers)
(define-key evil-normal-state-map "+" 'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map "-" 'evil-numbers/dec-at-pt)

(require 'surround)
(global-surround-mode 1)
