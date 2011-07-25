(add-to-list 'load-path "~/.emacs.d/vendor/js2")

(setq-default c-basic-offset 2)

(when (load "js2" t)
  (setq js2-cleanup-whitespace t
        js2-mirror-mode t
        js2-bounce-indent-flag nil
        js2-mode-show-parse-errors t)

  (defun indent-and-back-to-indentation ()
    (interactive)
    (indent-for-tab-command)
    (let ((point-of-indentation
           (save-excursion
             (back-to-indentation)
             (point))))
      (skip-chars-forward "\s " point-of-indentation)))
  (define-key js2-mode-map "\C-i" 'indent-and-back-to-indentation)

  (define-key js2-mode-map "\C-m" nil)

  (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode)))


(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; (defun js-custom ()
;;   "js-mode-hook"
;;    (set (make-local-variable 'tab-width) 2))

;; (add-hook 'js2-mode-hook '(lambda () (js-custom)))

;; flymake for javascript using jslint
(add-to-list 'flymake-allowed-file-name-masks '("\\.js\\'" flymake-js-init))
(defun flymake-js-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list "jslint" (list "--no-es5" local-file))))
(defun flymake-js-load ()
  (interactive)
  (setq flymake-err-line-patterns
        (cons '("^ *[[:digit:]] \\([[:digit:]]+\\),\\([[:digit:]]+\\)\: \\(.+\\)$"
                nil 1 2 3)
              flymake-err-line-patterns))
  (flymake-mode t))

(add-hook 'js2-mode-hook '(lambda () (flymake-js-load)))

(add-hook 'js2-mode-hook 'my-flymake-minor-mode) ;; keybindings for flymake
