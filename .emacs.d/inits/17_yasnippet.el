(add-to-list 'load-path
              "~/.emacs.d/vendor/yasnippet")

(require 'yasnippet) ;; not yasnippet-bundle
;; anything 連携はうまく動かないので、今の所有効にしない - 2011-11-08
;; (require 'anything-c-yasnippet)
;;
;; (setq anything-c-yas-space-match-any-greedy t)
;; (global-set-key (kbd "C-c y") 'anything-c-yas-complete)

(yas/initialize)
(yas/load-directory "~/.emacs.d/vendor/yasnippet/snippets")
(yas/load-directory "~/.emacs.d/snippets")

(require 'dropdown-list)
(setq yas/prompt-functions '(yas/dropdown-prompt))

;; for auto-complete
; (require 'auto-complete-yasnippet)


;; from http://d.hatena.ne.jp/antipop/20080321/1206090430
;;; [2008-03-17]
;;; yasnippet展開中はflymakeを無効にする
(defvar flymake-is-active-flag nil)

(defadvice yas/expand-snippet
  (before inhibit-flymake-syntax-checking-while-expanding-snippet activate)
  (setq flymake-is-active-flag
        (or flymake-is-active-flag
            (assoc-default 'flymake-mode (buffer-local-variables))))
  (when flymake-is-active-flag
    (flymake-mode-off)))

(add-hook 'yas/after-exit-snippet-hook
          '(lambda ()
             (when flymake-is-active-flag
               (flymake-mode-on)
               (setq flymake-is-active-flag nil))))

