(reqpac 'evil)

(setq-default evil-shift-width 2)
(evil-mode 1)

; visual line move
(defun evil-swap-key (map key1 key2)
  ;; MAP中のKEY1とKEY2を入れ替え
  "Swap KEY1 and KEY2 in MAP."
  (let ((def1 (lookup-key map key1))
        (def2 (lookup-key map key2)))
    (define-key map key1 def2)
    (define-key map key2 def1)))
(evil-swap-key evil-motion-state-map "j" "gj")
(evil-swap-key evil-motion-state-map "k" "gk")


; for dvorak
; use dhtn as hjkl for dvorak keyboard
(dolist (keys-assoc '(("d" . "h") ("h" . "j") ("t" . "k") ("n" . "l")))
  (dolist (state '(normal motion visual))
    (evil-global-set-key state
                         (car keys-assoc)
                         (lookup-key
                          (symbol-value
                           (intern (concat "evil-" (symbol-name state) "-state-map")))
                          (cdr keys-assoc)))))

(defmacro evil-add-dhtn-bindings (keymap &optional state &rest bindings)
  "Add \"d\", \"h\", \"t\", \"n\" bindings to KEYMAP in STATE.
Add additional BINDINGS if specified. For dvorak keyboard."
  (declare (indent defun))
  `(evil-define-key ,state ,keymap
     "d" (lookup-key evil-motion-state-map "d")
     "h" (lookup-key evil-motion-state-map "h")
     "t" (lookup-key evil-motion-state-map "t")
     "n" (lookup-key evil-motion-state-map "n")
     ":" (lookup-key evil-motion-state-map ":")
     ,@bindings))


; 'k' for deletion
(let ((map '("k" evil-delete)))
  (apply 'define-key evil-normal-state-map map)
  (apply 'define-key evil-visual-state-map map)
  (apply 'define-key evil-motion-state-map map))

; 'q' for hide buffer
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

; dont care shift key
(evil-ex-define-cmd "W" 'save-buffer)
(evil-ex-define-cmd "Wq" 'my-save-kill-current-butffer)
(evil-ex-define-cmd "WQ" 'my-save-kill-current-butffer)


;; plugins
(reqpac 'evil-numbers)
(define-key evil-normal-state-map "+" 'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map "-" 'evil-numbers/dec-at-pt)

(add-to-load-path "vendor/evil-plugins")
(require 'surround)
(global-surround-mode 1)


;; integration
;;; Dired
(eval-after-load 'dired
  '(progn
     (evil-add-dhtn-bindings dired-mode-map 'normal
       "d" 'dired-up-directory
       "n" 'dired-find-file                   ; "j"
       ";" (lookup-key dired-mode-map ":")))) ; ":d", ":v", ":s", ":e"

;;; Magit
(add-hook 'magit-mode-hook
          '(lambda () (evil-define-key 'normal magit-status-mode-map
                        "h" 'magit-goto-next-section
                        "t" 'magit-goto-previous-section)))
