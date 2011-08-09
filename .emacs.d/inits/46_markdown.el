(autoload 'markdown-mode "~/.emacs.d/vendor/elisps/markdown-mode.el"
   "Major mode for editing Markdown files" t)

(setq auto-mode-alist
      (cons '("\\.md" . markdown-mode)
            (cons '("\\.howm" . markdown-mode) auto-mode-alist)
            ))

(setq markdown-command "markdown.php")

(add-hook 'markdown-mode-hook
          '(lambda ()
             (refill-mode nil)
             ))
