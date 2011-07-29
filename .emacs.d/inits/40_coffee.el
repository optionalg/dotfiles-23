(add-to-list 'load-path "~/.emacs.d/vendor/coffee-mode")
(require 'coffee-mode)

(defun coffee-custom ()
  "coffee-mode-hook"
   (set (make-local-variable 'tab-width) 2))

(add-hook 'coffee-mode-hook
    '(lambda() (coffee-custom)))

;; flymake for coffee script, form: http://d.hatena.ne.jp/antipop/20110508/1304838383
(setq flymake-coffeescript-err-line-patterns
      '(("\\(Error: In \\([^,]+\\), .+ on line \\([0-9]+\\).*\\)" 2 3 nil 1)))

(defconst flymake-allowed-coffeescript-file-name-masks
  '(("\\.coffee$" flymake-coffeescript-init)))

(defun flymake-coffeescript-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list "coffee" (list "--compile" "--bare" local-file))))

(defun flymake-coffeescript-load ()
  (interactive)
  (defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
    (setq flymake-check-was-interrupted t))
  (ad-activate 'flymake-post-syntax-check)
  (setq flymake-allowed-file-name-masks
        (append flymake-allowed-file-name-masks
                flymake-allowed-coffeescript-file-name-masks))
  (setq flymake-err-line-patterns flymake-coffeescript-err-line-patterns)
  (flymake-mode t))

(add-hook 'coffee-mode-hook 'flymake-coffeescript-load)

(add-hook 'coffee-mode-hook 'my-flymake-minor-mode) ;keybindings for flymake


;; funcs
;; using coffee-command in vender/coffee-mode/coffee-mode.el
(defun coffee-run-buffer-file-saving ()
  "Run coffee script in current buffer in new window"
  (interactive)

  (if buffer-file-name
      (progn
        (save-buffer)
        (set-buffer
         (apply 'make-comint "CoffeeRun"
                coffee-command nil (cons buffer-file-name '())))

        (display-buffer "*CoffeeRun*")
        (read-string "press some key to close..")
        (kill-buffer "*CoffeeRun*"))

    (message "Please save buffer first.")))

(define-key coffee-mode-map (kbd "C-c r") 'coffee-run-buffer-file-saving)
(define-key coffee-mode-map [(super r)] 'coffee-compile-buffer)
