(setq auto-mode-alist
      (append '(("\\.rake$" . ruby-mode)
                ("Gemfile$" . ruby-mode)
                ("\\.gemspec$" . ruby-mode)
                ("\\.ru$" . ruby-mode)
                ("Rakefile$" . ruby-mode)) auto-mode-alist))

(setq ruby-insert-encoding-magic-comment nil)

;; indent
(setq ruby-deep-indent-paren-style nil)
;; reduce indent depth of last paren
(defadvice ruby-indent-line (after unindent-closing-paren activate)
  (let ((column (current-column))
        indent offset)
    (save-excursion
      (back-to-indentation)
      (let ((state (syntax-ppss)))
        (setq offset (- column (current-column)))
        (when (and (eq (char-after) ?\))
                   (not (zerop (car state))))
          (goto-char (cadr state))
          (setq indent (current-indentation)))))
    (when indent
      (indent-line-to indent)
      (when (> offset 0) (forward-char offset)))))

;; Enhanced ruby mode
;; (setq enh-ruby-program 
;;       (replace-regexp-in-string
;;        "\n+$" "" (shell-command-to-string "rbenv which ruby")))
;; (autoload 'enh-ruby-mode "enh-ruby-mode" "Major mode for ruby files" t)
;; (add-to-list 'auto-mode-alist '("\\.rb$" . enh-ruby-mode))
;; (add-to-list 'auto-mode-alist '("\\.rake$" . enh-ruby-mode))
;; (add-to-list 'auto-mode-alist '("Rakefile$" . enh-ruby-mode))
;; (add-to-list 'auto-mode-alist '("\\.gemspec$" . enh-ruby-mode))
;; (add-to-list 'auto-mode-alist '("\\.ru$" . enh-ruby-mode))
;; (add-to-list 'auto-mode-alist '("Gemfile$" . enh-ruby-mode))
 
;; (add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))
 
;; (setq enh-ruby-bounce-deep-indent t)
;; (setq enh-ruby-hanging-brace-indent-level 2)
 
;; rbenv
(setq rbenv-executable "/usr/local/bin/rbenv")
(setq rbenv-show-active-ruby-in-modeline nil)
(reqpac 'rbenv)
(global-rbenv-mode)

;; ruby-electric.el
(reqpac 'ruby-electric)


;; ruby-block.el
(reqpac 'ruby-block)
(ruby-block-mode t)
(setq ruby-block-highlight-toggle 'overlay)


;; inf-ruby.el
(reqpac 'inf-ruby)
(autoload 'inf-ruby "inf-ruby" "Run an inferior Ruby process" t)
(autoload 'inf-ruby-setup-keybindings "inf-ruby" "" t)
(eval-after-load 'ruby-mode
  '(add-hook 'ruby-mode-hook 'inf-ruby-setup-keybindings))


;; flymake-ruby
(defun flymake-ruby-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list "ruby-lint" (list local-file))))
 
(defconst flymake-allowed-ruby-file-name-masks
  '(("\.rb$" flymake-ruby-init)
    ("^Rakefile$" flymake-ruby-init)))
(defvar flymake-ruby-err-line-patterns
  '(("^\\(.*\\): .+: line \\([0-9]+\\), .+: \\(.*\\)$" 1 2 nil 3)))
; /tmp/a.rb: error: line 5, column 15: undefined local variable or method a
;sharings_helper.rb: error: line 9, column 27: undefined method request                                                 

(defun flymake-ruby-load ()
  (interactive)
  (defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
    (setq flymake-check-was-interrupted t))
  (ad-activate 'flymake-post-syntax-check)
  (setq flymake-allowed-file-name-masks
        (append flymake-allowed-file-name-masks flymake-allowed-ruby-file-name-masks))
  (setq flymake-err-line-patterns flymake-ruby-err-line-patterns)
  (flymake-mode t))
 
;(add-hook 'ruby-mode-hook '(lambda () (flymake-ruby-load)))
(add-hook
 'ruby-mode-hook
 '(lambda ()
    ;; rhtmlファイルではflymakeしない
    (if (not (null buffer-file-name)) (flymake-ruby-load))
    ))
(add-hook 'ruby-mode-hook 'my-flymake-minor-mode) ;keybindings for flymake


;; rubydb
;; M-x rubydb
(autoload 'rubydb "rubydb3x"
  "run rubydb on program file in buffer *gud-file*.
the directory containing file becomes the initial working directory
and source-file directory for your debugger." t)

;; use rbenv ruby
(setenv "PATH" (concat (getenv "HOME") "/.rbenv/shims:"
                       (getenv "HOME") "/.rbenv/bin:" (getenv "PATH")))
(setq exec-path (cons (concat (getenv "HOME") "/.rbenv/shims")
                      (cons (concat (getenv "HOME") "/.rbenv/bin") exec-path)))

;; ri search
(defvar ri-command "ri"
  "ri command"
)

(defun ri-search-doc-at-point (&optional item)
  (interactive)
  (setq item
        (if item item
          (my/region-string-or-current-word)))
  (ri-search-ri item))

(defun ri-search-doc (&optional item)
  (interactive)
  (setq item (read-string "Search symbol: "
                          (if item item
                            (my/region-string-or-current-word))))
  (ri-search-ri item)
)

(defun ri-search-doc-for-ri (&optional item)
  (interactive)
  (setq item (thing-at-point 'filename))
  (setq item (if (string-match "," item)
                 (replace-match "" nil nil item)))
  (ri-search-doc item)
)

(defun ri-search-ri (&optional item)
  (if item
      (let ((buf (buffer-name)))
        (unless (string= buf "*ri*")
          (switch-to-buffer-other-window "*ri*"))
        (setq buffer-read-only nil)
        (kill-region (point-min) (point-max))
        (message (concat "Please wait..."))
        (call-process ri-command nil "*ri*" t "--format=ansi" item)
        (local-set-key [f1] 'ri-search-doc)
        (local-set-key [return] 'ri-search-doc-for-ri)
        (ansi-color-apply-on-region (point-min) (point-max))
        (setq buffer-read-only t)
        (goto-char (point-min)))))

(defun ri-search-init ()
  (define-key ruby-mode-map (kbd "<f1> r") 'ri-search-doc-at-point))

(add-hook 'ruby-mode-hook 'ri-search-init)
(add-hook 'rhtml-mode-hook 'ri-search-init)


;; RSense
;; (setq rsense-home (expand-file-name "~/.emacs.d/vendor/rsense-0.3"))
;; (add-to-list 'load-path (concat rsense-home "/etc"))
;; (require 'rsense)
;; (add-hook 'ruby-mode-hook
;;           (lambda ()
;;             (add-to-list 'ac-sources 'ac-source-rsense-method)
;;             (add-to-list 'ac-sources 'ac-source-rsense-constant)))

;; rcodetools
;; (add-to-list 'load-path "~/.rbenv/versions/2.0.0-p247/lib/ruby/gems/2.0.0/gems/rcodetools-0.8.5.0/")
;; (require 'rcodetools)
;; (setq rct-find-tag-if-available nil)
;; (defun ruby-mode-hook-rcodetools ()
;;   (define-key ruby-mode-map (kbd "<C-tab>") 'rct-complete-symbol)
;;   (define-key ruby-mode-map (kbd "<C-return>") 'xmp))
;; (add-hook 'ruby-mode-hook 'ruby-mode-hook-rcodetools)
;; (defun make-ruby-scratch-buffer ()
;;   (with-current-buffer (get-buffer-create "*ruby scratch*")
;;     (ruby-mode)
;;     (current-buffer)))
;; (defun ruby-scratch ()
;;   (interactive)
;;   (pop-to-buffer (make-ruby-scratch-buffer)))

;; rspec-mode
(reqpac 'rspec-mode)
(reqpac 'rinari)
(defadvice rspec-compile (around rspec-compile-around)
  "Use BASH shell for running the specs because of ZSH issues."
  (let ((shell-file-name "/bin/bash"))
    ad-do-it))
(ad-activate 'rspec-compile)
(custom-set-variables
 '(rspec-use-rake-flag nil)
 '(rspec-use-bundler-when-possible t))
(defun rspec-spring-p ()
  (and rspec-use-spring-when-possible
       (rinari-root) ; in rails project
       (stringp (executable-find "spring"))))
(defun rspec-find-spec-file ()
  (interactive)
  (find-file-other-window
   (rspec-spec-file-for (buffer-file-name))))
(defun rspec-find-target-file ()
  (interactive)
  (find-file-other-window
   (rspec-target-file-for (buffer-file-name))))
(defun rspec-find-spec-or-target-file ()
  (interactive)
  (if (rspec-spec-file-p (buffer-file-name))
      (rspec-find-target-file)
    (rspec-find-spec-file)))
(define-key rspec-mode-verifiable-keymap (kbd "f") 'rspec-find-spec-or-target-file)
