(setq imenu-modes '(emacs-lisp-mode c-mode c++-mode makefile-mode js-mode coffee-mode objc-mode markdown-mode))

(require 'imenu)
;(require 'semantic-imenu)

;; (defcustom imenu-modes
;;   '(emacs-lisp-mode c-mode c++-mode makefile-mode js-mode coffee-mode objc-mode markdown-mode)
;;   "List of major modes for which Imenu mode should be used."
;;   :group 'imenu
;;   :type '(choice (const :tag "All modes" t)
;;                  (repeat (symbol :tag "Major mode"))))

;; (defun my-imenu-ff-hook ()
;;   "File find hook for Imenu mode."
;;   (if (member major-mode imenu-modes)
;;       (imenu-add-to-menubar "imenu")))
;; (add-hook 'find-file-hooks 'my-imenu-ff-hook t)

;; (global-set-key "\C-cg" 'imenu)

