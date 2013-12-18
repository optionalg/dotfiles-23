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
   "\n+$" "" (shell-command-to-string "gem env gemdir")))

(defun rails-source-update-tag ()
  (interactive)
  (let ((root (rails-gems-root))
        (current default-directory))
  (cd root)
  (when (executable-find "global")
    (start-process "gtags-update" nil
                   "global" "-uvO"))
  (cd current)))

(defun rails-source-create-tag ()
  (interactive)
  (let ((root (rails-gems-root))
        (current default-directory))
  (cd root)
  (when (executable-find "gtags")
    (start-process "gtags-create" nil
                   "gtags" "-O"))
  (cd current)))

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
;; (require 'rhtml-mode)
;; (add-hook 'rhtml-mode-hook
;;           (lambda () (rinari-launch)))
;; (add-to-list 'auto-mode-alist '("\\.erb$" . rhtml-mode))

;; slim-mode
(reqpac 'slim-mode)

;; Web API Reference
(define-key rinari-minor-mode-map (kbd "<f1> y")
  '(lambda ()
     (interactive)
     (browse-url (concat "http://apidock.com/rails/search?query=" (region-string-or-currnet-word)))))
