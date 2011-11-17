(add-to-list 'load-path "~/.emacs.d/vendor/elisps")

(setq multi-term-dedicated-select-after-open-p t)
(setq multi-term-dedicated-window-height 22)
(setq multi-term-program shell-file-name)

(require 'multi-term)

;; BUG: elscreen で他のスクリーンに遷移するとpopwinのウィンドウが閉じなくなる
(defun my-term-cd-cmd-for-dir (dir) (concat "cd " dir "\n"))

(defun my-term-cd-cmd ()
  (cond (buffer-file-name (my-term-cd-cmd-for-dir (file-name-directory buffer-file-name)))
        (list-buffers-directory (my-term-cd-cmd-for-dir list-buffers-directory))
        ("")))

(defun my-multi-term-popwin-exist-p ()
  (if (member "*MULTI-TERM-DEDICATED*"
              (mapcar '(lambda (win) (buffer-name (window-buffer win))) (window-list))) t
    nil))

(defun my-multi-term-popwin-open-cd ()
  (interactive)
  (let ((cd-cmd (my-term-cd-cmd)))
    (if (not (multi-term-buffer-exist-p multi-term-dedicated-buffer))
        (setq multi-term-dedicated-buffer (multi-term-get-buffer current-prefix-arg t))
      (set-buffer (multi-term-dedicated-get-buffer-name)))
    (popwin:popup-buffer multi-term-dedicated-buffer :height 70 :position :right)
    (term-send-raw-string cd-cmd)))

(defun my-multi-term-popwin-close ()
  (interactive)
  (popwin:close-popup-window-if-necessary t))

; C-x t で multi-term-dedicated-window をトグル
(global-set-key (kbd "C-x t")
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

;; Command-v for paste
(add-hook 'term-mode-hook
          (lambda()
            (define-key term-raw-map [(super v)] 'term-paste)))

