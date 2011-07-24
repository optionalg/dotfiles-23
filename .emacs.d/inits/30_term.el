(require 'multi-term)
(setq multi-term-program shell-file-name)
(global-set-key (kbd "C-c t") '(lambda ()
                                 (interactive)
                                 (if (get-buffer "*terminal<1>*")
                                     (switch-to-buffer "*terminal<1>*")
                                   (multi-term))))
(global-set-key (kbd "C-c n") 'multi-term-next)
(global-set-key (kbd "C-c p") 'multi-term-prev)

(setq locale-coding-system 'utf-8)
(set-language-environment  'utf-8)
(prefer-coding-system 'utf-8)

(setq term-default-bg-color nil)
(setq term-default-fg-color nil)

;; C-y for paste
(add-hook 'term-mode-hook
          (lambda()
            (define-key term-raw-map (kbd "C-y") 'term-paste)))
