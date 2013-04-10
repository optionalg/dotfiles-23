(add-to-load-path "vendor/elisps")

(setq multi-term-dedicated-select-after-open-p t)
(setq multi-term-dedicated-window-height 22)
(setq multi-term-program shell-file-name)

(require 'multi-term)
(reqpack 'popwin)
(require 'ucs-normalize)

;; Toggle
(defvar my-dedicated-term-name "*MULTI-TERM-DEDICATED*")

(defun my-term-cd-cmd-for-dir (dir) (concat "cd " dir "\n"))

(defun my-term-cd-cmd ()
  (cond (buffer-file-name (my-term-cd-cmd-for-dir (file-name-directory buffer-file-name)))
        (list-buffers-directory (my-term-cd-cmd-for-dir list-buffers-directory))
        ("")))

(defun my-multi-term-popwin-exist-p ()
  (if (member my-dedicated-term-name
              (mapcar '(lambda (win) (buffer-name (window-buffer win))) (window-list))) t
    nil))

(defun my-multi-term-popwin-open-cd ()
  (interactive)
  (let ((cd-cmd (my-term-cd-cmd)))
    (if (not (multi-term-buffer-exist-p multi-term-dedicated-buffer))
        ;(setq multi-term-dedicated-buffer (multi-term-get-buffer current-prefix-arg t))
        (setq multi-term-dedicated-buffer (multi-term-get-buffer nil t))
        (set-buffer (multi-term-dedicated-get-buffer-name))
      )
    ; 他のウィンドウにフォーカスしたときに閉じたくないなら :stick t を追加で渡す
    ;; (popwin:popup-buffer multi-term-dedicated-buffer :width 60 :position :right :stick t)
    (popwin:popup-buffer multi-term-dedicated-buffer :height 30 :position :top :stick t)
    (term-char-mode)
    (term-send-raw-string cd-cmd)
    ))

(defun my-multi-term-popwin-close ()
  (interactive)
  ;(popwin:close-popup-window-if-necessary t))
  (popwin:close-popup-window))

; toggle multi-term-dedicated-window with C-x t
(global-set-key [(super t)]
                '(lambda ()
                   (interactive)
                   (if (not (my-multi-term-popwin-exist-p))
                       (my-multi-term-popwin-open-cd)
                     (my-multi-term-popwin-close))))

(global-set-key (kbd "C-c t") 'multi-term)
(global-set-key (kbd "C-c n") 'multi-term-next)
(global-set-key (kbd "C-c p") 'multi-term-prev)

(setq locale-coding-system 'utf-8)
(set-language-environment  'utf-8)
(prefer-coding-system 'utf-8)

(setq term-default-bg-color nil)
(setq term-default-fg-color nil)

(setq system-uses-terminfo nil)

;; Misc
; keybindings
(add-hook 'term-mode-hook
          (lambda()
            (define-key term-raw-map [(super v)] 'term-paste)
            (define-key term-raw-map (kbd "M-r")
              '(lambda ()
                 (interactive)
                 (term-send-raw-string (kbd "C-r"))))
            ))

;; Shell mode
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

; Don't scroll back after showing complete candidates
(setq-default term-scroll-show-maximum-output t)
; (setq-default multi-term-scroll-show-maximum-output t) ; not necessary
