(autoload 'csharp-mode "~/.emacs.d/vendor/elisps/csharp-mode-0.8.5.el" "Major mode for editing C# code." t)
(setq auto-mode-alist
      (append '(("\\.cs$" . csharp-mode)) auto-mode-alist))

;; Optionally, define and register a mode-hook function. To do so, use
;; something like this in your .emacs file:

(defun my-csharp-mode-fn ()
  "function that runs when csharp-mode is initialized for a buffer."
  (turn-on-auto-revert-mode)
  (setq indent-tabs-mode nil)
  ;; (require 'flymake)
  ;; (flymake-mode 1)
  (require 'yasnippet)
  (yas/minor-mode-on)
  ;; (require 'rfringe)
  )
(add-hook  'csharp-mode-hook 'my-csharp-mode-fn t)
