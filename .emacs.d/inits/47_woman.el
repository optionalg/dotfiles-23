(autoload 'woman "woman"
  "Decode and browse a UN*X man page." t)
(autoload 'woman-find-file "woman"
  "Find, decode and browse a specific UN*X man-page file." t)

(setq woman-use-own-frame nil)
(setq woman-cache-filename "~/.emacs.d/.woman-cache.el")
(setq woman-imenu-generic-expression
      '((nil "^\\(   \\)?\\([ぁ-んァ-ヴー一-龠ａ-ｚＡ-Ｚ０-９a-zA-Z0-9]+\\)" 2)))

(setq woman-manpath '("/usr/local/jman/share/man/ja_JP.UTF-8/" 
                      "/opt/local/share/man"
                      "/usr/local/share/man"
                      "/usr/share/man"
                      ;; "/usr/X11/man"
                      ))

;; これをしないとWoManでanything-imenuしてもなにも候補がでない
(setq woman-imenu t)

;; migemoを使用したimenuソースを定義
;; (setq anything-c-source-imenu
;;   '((name . "Imenu")
;;     (candidates . anything-c-imenu-candidates)
;;     (volatile)
;;     (persistent-action . (lambda (elm)
;;                            (anything-c-imenu-default-action elm)
;;                            (unless (fboundp 'semantic-imenu-tag-overlay)
;;                              (anything-match-line-color-current-line))))
;;     (action . anything-c-imenu-default-action)
;;     (migemo)))

