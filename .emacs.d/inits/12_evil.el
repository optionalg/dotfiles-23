(reqpack 'evil)
(setq-default evil-shift-width 2)
(evil-mode 1)

(setq my-evil-hjkl-maps
      '(("d" evil-backward-char)
        ("h" evil-next-visual-line)
        ("t" evil-previous-visual-line)
        ("n" evil-forward-char)
        ("k" evil-delete)))

(dolist (map my-evil-hjkl-maps)
  (apply 'define-key evil-normal-state-map map)
  (apply 'define-key evil-visual-state-map map)
  (apply 'define-key evil-motion-state-map map)
  )

(define-key evil-normal-state-map "q" 'quit-window)

;; Prevent quit command from exit Emacs
(defun my-kill-current-butffer ()
  :repeat nil
  (interactive)
  (kill-buffer (current-buffer)))

(defun my-save-kill-current-butffer ()
  :repeat nil
  (interactive)
  (save-buffer)
  (kill-buffer (current-buffer)))

(evil-ex-define-cmd "q[uit]" 'my-kill-current-butffer)
(evil-ex-define-cmd "wq" 'my-save-kill-current-butffer)
(evil-ex-define-cmd "Wq" 'my-save-kill-current-butffer)
(evil-ex-define-cmd "W" 'save-buffer)


;; plugins
(reqpack 'evil-numbers)
(define-key evil-normal-state-map "+" 'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map "-" 'evil-numbers/dec-at-pt)

(add-to-load-path "vendor/evil-plugins")
(require 'surround)
(global-surround-mode 1)
