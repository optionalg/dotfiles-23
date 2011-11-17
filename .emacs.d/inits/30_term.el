(add-to-list 'load-path "~/.emacs.d/vendor/elisps")

(setq multi-term-dedicated-select-after-open-p t)
(setq multi-term-dedicated-window-height 22)
(setq multi-term-program shell-file-name)

(require 'multi-term)

;; BUGS:
;;   * elscreen 使用時：dedicated開く → 別スクリーンへ移動 → dedicated開き閉じる → もとのスクリーンへ → dedicated 閉じる
;;   と新しく dedicated を開く。閉じるのが期待される挙動。
(defun my-term-cd-cmd (dir) (concat "cd " dir "\n"))
;; 標準の物はたまに違う値を返すので試しにこっちを使う
;; ウィンドウの参照を中で持っているのが変な値になっているっぽい
(defun my-multi-term-dedicated-exist-p ()
  (if
      (member "*MULTI-TERM-DEDICATED*"
              (mapcar '(lambda (w) (buffer-name (window-buffer w)))
                      (window-list))) t
    nil))
(global-set-key (kbd "C-x t")
                '(lambda ()
                   (interactive)
                   (let ((cd-cmd (cond (buffer-file-name (my-term-cd-cmd (file-name-directory buffer-file-name)))
                                       (list-buffers-directory (my-term-cd-cmd list-buffers-directory))
                                       (""))))
                     (if (my-multi-term-dedicated-exist-p)
                         (multi-term-dedicated-close)
                       (multi-term-dedicated-open)
                       (if multi-term-dedicated-select-after-open-p
                           (term-send-raw-string cd-cmd))))))

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

