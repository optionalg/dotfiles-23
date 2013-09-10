(autoload 'markdown-mode "~/.emacs.d/vendor/elisps/markdown-mode.el"
   "Major mode for editing Markdown files" t)

(setq auto-mode-alist
      (cons '("\\.md" . markdown-mode)
            (cons '("\\.md.erb" . markdown-mode)
            (cons '("\\.howm" . markdown-mode) auto-mode-alist)
            )))

(setq markdown-command "redcarpet")

(defun outline-imenu-create-index ()
  (let (index)
    (goto-char (point-min))
    (while (re-search-forward "^\*\s*\\(.+\\)" (point-max) t)
      (push (cons (match-string 1) (match-beginning 1)) index))
    (nreverse index)))

(add-hook 'markdown-mode
          (lambda ()
            (setq imenu-create-index-function 'outline-imenu-create-index)
            (auto-fill-mode)
            ))

;; (add-hook 'markdown-mode-hook
;;           '(lambda ()
;;              (refill-mode -1)
;;              ))

