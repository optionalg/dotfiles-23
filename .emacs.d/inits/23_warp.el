(add-to-list 'load-path "~/Documents/OldProjects/warp")
(require 'warp)
(require 'warp-reload)
(global-set-key (kbd "C-c C-w C-w") 'warp-mode)
(global-set-key (kbd "C-c C-w C-r") 'warp-reload)

;; For require module installed globally on node.js
(setenv "NODE_PATH"
        (replace-regexp-in-string
         "\n+$" "" (shell-command-to-string "echo $NODE_PATH")))

(custom-set-variables
 '(warp-base-url "http://dev")
 '(warp-reload-default-base-url "http://dev:"))

(add-to-list 'warp-format-converter-alist
             '("\\.md\\|\\.markdown" t (lambda ()
                                         ;; Set command you are using
                                         '("redcarpet"))))
;; (add-to-list 'warp-format-converter-alist
;;              '(markdown-mode t (lambda ()
;;                                          ;; Set command you are using
;;                                          '("markdown"))))

(setenv "LC_ALL" "en_US.UTF-8")

;; Textile
;; (setenv "LC_ALL" "en_US.UTF-8") ;; For redcloth error
;; (add-to-list 'warp-format-converter-alist
;;              '("\\.textile" t (lambda ()
;;                                 (progn
;;                                   '("redcloth")))))

;; Using github-markup
(add-to-list 'warp-format-converter-alist
             '("\\.textile\\|\\.rdoc\\|\\.org\\|\\.creole\\|\\.mediawiki\\|\\.rst\\|\\.asciidoc\\|\\.pod"
               nil
               (lambda ()
                 (let* ((string (buffer-string))
                        (ext (file-name-extension (buffer-file-name)))
                        (temp-file (concat "warp-temp." ext)))
                   (with-temp-file temp-file
                     (insert string))
                   (list "github-markup" temp-file)))))
