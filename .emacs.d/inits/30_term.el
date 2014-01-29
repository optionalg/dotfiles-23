;; (setq multi-term-dedicated-select-after-open-p t)
;; (setq multi-term-dedicated-window-height 22)
(setq multi-term-program shell-file-name)

(setq locale-coding-system 'utf-8)
(set-language-environment  'utf-8)
(prefer-coding-system 'utf-8)

(setq term-default-bg-color nil)
(setq term-default-fg-color nil)

(setq system-uses-terminfo nil)


(require 'multi-term)
(require 'ucs-normalize)

;; Toggle
(setq my/multi-term-dedicated-name (multi-term-dedicated-get-buffer-name))

; cd
(defun my/term-cd-cmd-for-dir (dir) (concat "cd " dir "\n"))

(defun my/term-cd-cmd ()
  (cond (buffer-file-name (my/term-cd-cmd-for-dir (file-name-directory buffer-file-name)))
        (list-buffers-directory (my/term-cd-cmd-for-dir list-buffers-directory))
        ("")))

(defun my/find-multi-term-dedicated-window ()
  (car
   (my/filter '(lambda (win)
                 (equal (buffer-name (window-buffer win)) my/multi-term-dedicated-name))
              (window-list))))

(defun my/multi-term-dedicated-open ()
  (interactive)
  (let ((cd-cmd (my/term-cd-cmd)))
    (when (not (multi-term-buffer-exist-p multi-term-dedicated-buffer))
      (setq multi-term-dedicated-buffer (multi-term-get-buffer nil t)))
    (pop-to-buffer multi-term-dedicated-buffer)
    (term-char-mode)
    (term-send-raw-string cd-cmd)))

(global-set-key [(super t)]
                '(lambda ()
                   (interactive)
                   (let ((term-win (my/find-multi-term-dedicated-window)))
                     (if term-win
                         (delete-window term-win)
                       (my/multi-term-dedicated-open)))))

;; (global-set-key [(super t)] 'my/multi-term-dedicated-open)

(global-set-key (kbd "C-c t") 'multi-term)
(global-set-key (kbd "C-c n") 'multi-term-next)
(global-set-key (kbd "C-c p") 'multi-term-prev)

;; Misc
; keybindings
(add-hook 'term-mode-hook
          (lambda()
            (define-key term-raw-map [(super v)] 'term-paste)
            (define-key term-raw-map (kbd "M-r")
              '(lambda ()
                 (interactive)
                 (term-send-raw-string (kbd "C-r")))) ; bck-i-search
            ;; (set-fill-column 60) ; no need?
            ;; (toggle-truncate-lines nil)
            ))

;; Shell mode
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

; Don't scroll back after showing complete candidates
(setq-default term-scroll-show-maximum-output t)
(setq-default term-scroll-to-bottom-on-output 'all)
; (setq-default multi-term-scroll-show-maximum-output t) ; not necessary
