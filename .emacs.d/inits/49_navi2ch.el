(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/navi2ch/"))
(autoload 'navi2ch "navi2ch" "Navigator for 2ch for Emacs" t)

;;; navi2ch の設定
(setq load-path (cons (expand-file-name "~/site-lisp/navi2ch/") load-path))
(autoload 'navi2ch "navi2ch" "Navigator for 2ch for Emacs" t)
;; 送信控えをとる
(setq navi2ch-message-save-sendlog t)
;; 以下はエラーになる
;; (add-to-list 'navi2ch-list-navi2ch-category-alist
;;              navi2ch-message-sendlog-board)
;; 送信控えのレスに板名も表示する
(setq navi2ch-message-sendlog-message-format-function
      'navi2ch-message-sendlog-message-format-with-board-name)
;; キーバインド
;; http://navi2ch.sourceforge.net/doc/navi2ch_4.html#SEC32
(add-hook 'navi2ch-article-mode-hook
          (lambda ()
            (let ((map navi2ch-article-mode-map))
              (define-key map "w" 'navi2ch-article-write-sage-message) ; w で sage
              (define-key map "W" 'navi2ch-article-write-message)      ; W で age
              (define-key map "j" 'navi2ch-article-next-message)       ; j で次のレスへ
              (define-key map "k" 'navi2ch-article-previous-message)   ; k で前のレスへ
              (define-key map "n" 'navi2ch-article-few-scroll-up)      ; n で1行下ヘスクロール
              (define-key map "p" 'navi2ch-article-few-scroll-down)    ; p で1行上へスクロール
              )))

;(setq navi2ch-net-http-proxy "localhost:8118")
