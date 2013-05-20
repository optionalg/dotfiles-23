;; (defvar rails-tags-dirs '("app" "lib" "test" "db" "vendor")
;;   "make tag target directories"
;; )

;; (defvar rails-tags-command "gtags %s"
;;   "make tag target directories"
;; )

;; (defun rails-create-tags()
;;   "Create tags file"
;;   (interactive)
;;    (message "Creating TAGS, please wait...")
;;    (let ((tags-file-name (concat (rinari-root) "TAGS")))
;;      (shell-command
;;       (format rails-tags-command tags-file-name
;;         (mapconcat (function (lambda (s) (concat (rinari-root) "" s)))
;;                    rails-tags-dirs " ")))
;;      (visit-tags-table tags-file-name)))


;; Interactively Do Things (highly recommended, but not strictly required)
;; (require 'ido)
;; (ido-mode t)

(reqpac 'helm-gtags)
(defun rails-gems-root ()
  (replace-regexp-in-string
   "\\(/bin/rails$\\|\n+$\\)" "" (shell-command-to-string "rbenv which rails")))

(defun rails-source-find-tag ()
  (interactive)
  (with-helm-default-directory (rails-gems-root)
      (helm-gtags-find-tag)))

;; Rinari
(reqpac 'rinari)
(global-rinari-mode t)
(rinari-bind-key-to-func "]" (symbol-function 'rails-source-find-tag))

(setq rinari-tags-file-name "TAGS")


;; Override to use "bundle exec rake"
(defun ruby-compilation-rake (&optional edit task env-vars)
  "Run a rake process dumping output to a ruby compilation buffer."
  (interactive "P")
  (let* ((task (concat
                (or task (if (stringp edit) edit)
                    (completing-read "Rake: " (pcmpl-rake-tasks)))
                " "
                (mapconcat (lambda (pair)
                             (format "%s=%s" (car pair) (cdr pair)))
                           env-vars " ")))
         (rake-args (if (and edit (not (stringp edit)))
                        (read-from-minibuffer "Edit Rake Command: " (concat task " "))
                      task)))
    (pop-to-buffer (ruby-compilation-do
                    "rake" (nconc '("bundle" "exec" "rake")
                                 (split-string rake-args))))))
(ad-activate 'ruby-compilation-rake)

;; Use with ebenv
;; This affects rinari-script, rinari-test and rinari-web-server
(add-hook 'rinari-minor-mode-hook '(lambda ()
                                     (make-local-variable 'ruby-compilation-executable)
                                     (setq ruby-compilation-executable "")))


;; rhtml-mode
(add-to-load-path "vendor/rhtml")
(require 'rhtml-mode)
(add-hook 'rhtml-mode-hook
          (lambda () (rinari-launch)))

;; rspec-mode
(add-to-load-path "vendor/rspec-mode")
(require 'rspec-mode)
(defadvice rspec-compile (around rspec-compile-around)
  "Use BASH shell for running the specs because of ZSH issues."
  (let ((shell-file-name "/bin/bash"))
    ad-do-it))
(ad-activate 'rspec-compile)
(custom-set-variables
 '(rspec-use-rake-flag nil))


;; Web API Reference
(define-key rinari-minor-mode-map (kbd "<f1> y")
  '(lambda ()
     (interactive)
     (browse-url (concat "http://apidock.com/rails/search?query=" (region-string-or-currnet-word)))))
