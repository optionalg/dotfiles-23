(autoload 'markdown-mode "~/.emacs.d/vendor/elisps/markdown-mode.el"
   "Major mode for editing Markdown files" t)

(setq auto-mode-alist
      (cons '("\\.md" . markdown-mode)
            (cons '("\\.md.erb\\'" . markdown-mode)
            (cons '("\\.howm\\'" . markdown-mode) auto-mode-alist)
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

(setq markdown-imenu-generic-expression
      '(("title"  "^\\(.*\\)[\n]=+$" 1)
        ("h2-"    "^\\(.*\\)[\n]-+$" 1)
        ("h1"   "^# \\(.*\\)$" 1)
        ("h2"   "^## \\(.*\\)$" 1)
        ("h3"   "^### \\(.*\\)$" 1)
        ("h4"   "^#### \\(.*\\)$" 1)
        ("h5"   "^##### \\(.*\\)$" 1)
        ("h6"   "^###### \\(.*\\)$" 1)
        ("fn"   "^\\[\\^\\(.*\\)\\]" 1)
        ))

(add-hook 'markdown-mode-hook
          (lambda ()
            (setq imenu-generic-expression markdown-imenu-generic-expression)))
