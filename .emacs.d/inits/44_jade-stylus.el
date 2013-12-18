(require 'sws-mode)
(require 'jade-mode)
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))
(require 'stylus-mode)
(add-to-list 'auto-mode-alist '("\\.styl$" . stylus-mode))

;; flymake for jade
(add-to-list 'flymake-allowed-file-name-masks '("\\.jade\\'" flymake-jade-init))
(defun flymake-jade-init ()
  (let* ((local-dir (file-name-directory buffer-file-name))
         (local-file (file-relative-name
                      buffer-file-name
                      local-dir)))
    (list "jade" (list local-file "--out" local-dir)))
  )
(defun flymake-jade-load ()
  (interactive)
  (defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
    (setq flymake-check-was-interrupted t))
  (ad-activate 'flymake-post-syntax-check)
  (setq flymake-err-line-patterns
        (cons '("\\(.*: \\(.+\\):\\([[:digit:]]+\\)\\)"
                2 3 nil 1)
              flymake-err-line-patterns))
  (flymake-mode t))

(add-hook 'jade-mode-hook '(lambda () (flymake-jade-load)))

(add-hook 'jade-mode-hook 'my-flymake-minor-mode)


;; flymake for stylus (just compile on the place now)
;; in the future, if stylus begin to output error message,
;; we should modify flymake-err-line-patterns
(add-to-list 'flymake-allowed-file-name-masks '("\\.styl\\'" flymake-stylus-init))
(defun flymake-stylus-init ()
  (let* ((local-dir (file-name-directory buffer-file-name))
         (local-file (file-relative-name
                      buffer-file-name
                      local-dir)))
    (list "stylus" (list local-file "--out" local-dir)))
  )
(defun flymake-stylus-load ()
  (interactive)
  (defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
    (setq flymake-check-was-interrupted t))
  (ad-activate 'flymake-post-syntax-check)
  ;; (setq flymake-err-line-patterns
  ;;       (cons '("\\(.*: \\(.+\\):\\([[:digit:]]+\\)\\)"
  ;;               2 3 nil 1)
  ;;             flymake-err-line-patterns))
  (flymake-mode t))

(add-hook 'stylus-mode-hook '(lambda () (flymake-stylus-load)))

(add-hook 'stylus-mode-hook 'my-flymake-minor-mode)
