;; from: http://sakito.jp/moin/moin.cgi/nxml-mode

(add-to-list 'auto-mode-alist '("\\.\\(htm\\|html\\|shtm\\|shtml\\)\\'" . nxml-mode))
(fset 'html-mode 'nxml-mode)

(add-hook 'nxml-mode-hook
          (lambda ()
            (setq auto-fill-mode -1)
            (setq nxml-slash-auto-complete-flag t)
            (setq nxml-child-indent 2)
            (setq indent-tabs-mode nil)
            (setq tab-width 2)
            ;(html-fold-mode)
            ))

(custom-set-faces
  ;; custom-set-faces was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 ;; '(mode-line ((((type x w32 mac) (class color)) (:background "navy" :foreground "yellow" :box (:line-width -1 :style released-button)))))
 '(nxml-comment-content-face ((t (:foreground "yellow4"))))
 '(nxml-comment-delimiter-face ((t (:foreground "yellow4"))))
 '(nxml-delimited-data-face ((t (:foreground "lime green"))))
 '(nxml-delimiter-face ((t (:foreground "grey"))))
 '(nxml-element-local-name-face ((t (:inherit nxml-name-face :foreground "medium turquoise"))))
 '(nxml-name-face ((t (:foreground "rosy brown"))))
 '(nxml-tag-slash-face ((t (:inherit nxml-name-face :foreground "grey")))))


;; multi-web-mode: https://github.com/fgallina/multi-web-mode
(add-to-load-path "vendor/multi-web-mode")
(require 'multi-web-mode)
(setq mweb-default-major-mode 'nxml-mode)
(setq mweb-tags '((php-mode "<\\?php\\|<\\? \\|<\\?=" "\\?>")
                  (js-mode "<script[^>]*>" "</script>")
                  (css-mode "<style[^>]*>" "</style>")))
(setq mweb-filename-extensions '("php" "htm" "html" "ctp" "phtml" "php4" "php5"))
(multi-web-global-mode 1)
