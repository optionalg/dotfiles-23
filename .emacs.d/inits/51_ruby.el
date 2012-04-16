(add-to-list 'load-path "~/.emacs.d/vendor/ruby-mode")
(setq auto-mode-alist
      (append '(("^Rakefile$" . ruby-mode)) auto-mode-alist))


;; ruby-electric.el
(require 'ruby-electric)
(add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t)))


;; ruby-block.el
(require 'ruby-block)
(ruby-block-mode t)
(setq ruby-block-highlight-toggle 'overlay)


;; inf-ruby.el
(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")
(add-hook 'ruby-mode-hook
          '(lambda ()
             (inf-ruby-keys)
             ))


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
;; M-x rubydb
(autoload 'rubydb "rubydb3x"
  "run rubydb on program file in buffer *gud-file*.
the directory containing file becomes the initial working directory
and source-file directory for your debugger." t)


;; Without this, viper-mode will be disabled in ruby-mode.
;(add-to-list 'viper-vi-state-mode-list 'ruby-mode)


;; use rvm ruby
(require 'rvm)
(rvm-use-default) ;; use rvm's default ruby for the current Emacs session


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
