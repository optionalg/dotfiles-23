(add-to-list 'load-path "~/.emacs.d/vendor/coffee-mode")
(reqpac 'coffee-mode)

(defun coffee-custom ()
  "coffee-mode-hook"
   (set (make-local-variable 'tab-width) 2))

(add-hook 'coffee-mode-hook
    '(lambda() (coffee-custom)))

;; avoid to show escape charactors in REPL
(setenv "NODE_NO_READLINE" "1")

(define-key coffee-mode-map [(super r)] 'coffee-compile-buffer)

(reqpac 'flymake-coffee)
(add-hook 'coffee-mode-hook 'flymake-coffee-load)
(add-hook 'coffee-mode-hook 'my-flymake-minor-mode) ;keybindings for flymake

;; funcs
;; using coffee-command in vender/coffee-mode/coffee-mode.el
;; (defun coffee-run-buffer-file-saving ()
;;   "Run coffee script in current buffer in new window"
;;   (interactive)

;;   (if buffer-file-name
;;       (progn
;;         (save-buffer)
;;         (set-buffer
;;          (apply 'make-comint "CoffeeRun"
;;                 coffee-command nil (cons buffer-file-name '())))

;;         (display-buffer "*CoffeeRun*")
;;         (read-string "press Enter to close..")
;;         (kill-buffer-and-window))

;;     (message "Please save buffer first.")))

;; (define-key coffee-mode-map (kbd "C-c r") 'coffee-run-buffer-file-saving)

;; for imenu
;; donot use semantic one
(add-hook 'coffee-mode-hook
          (lambda ()
            (setq imenu-create-index-function 'coffee-imenu-create-index)
            (imenu-add-menubar-index)
            ))

;; Use RHTML mode for eco template
(setq auto-mode-alist
      (append '(("\\.eco$" . rhtml-mode)) auto-mode-alist))
