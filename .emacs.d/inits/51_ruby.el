(setq auto-mode-alist
      (append '((".rake$" . ruby-mode)
                ("Gemfile$" . ruby-mode)
                ("Rakefile$" . ruby-mode)) auto-mode-alist))

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
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
         (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "ruby" (list "-c" local-file))))

(push '(".+\\.rb$" flymake-ruby-init) flymake-allowed-file-name-masks)
(push '("Rakefile$" flymake-ruby-init) flymake-allowed-file-name-masks)

(push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3) flymake-err-line-patterns)

(add-hook 'ruby-mode-hook
          '(lambda ()
             ;; Don't want flymake mode for ruby regions in rhtml files and also on read only files
             (if (and (not (null buffer-file-name)) (file-writable-p buffer-file-name))
                 (flymake-mode t))
             ))

(add-hook 'ruby-mode-hook 'my-flymake-minor-mode) ;keybindings for flymake


;; rubydb
(add-to-list 'load-path "~/.emacs.d/vendor/ruby-mode")
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
          (region-string-or-currnet-word)))
  (ri-search-ri item))

(defun ri-search-doc (&optional item)
  (interactive)
  (setq item (read-string "Search symbol: "
                          (if item item
                            (region-string-or-currnet-word))))
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
;; (add-to-list 'load-path "~/.rbenv/versions/2.0.0-p0/lib/ruby/gems/2.0.0/gems/rcodetools-0.8.5.0/")
;; (require 'rcodetools)
;; (define-key ruby-mode-map (kbd "<C-return>") 'rct-complete-symbol)
