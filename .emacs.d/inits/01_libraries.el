(add-to-list 'load-path "~/.emacs.d/vendor/apel")

;; disable default load-path for cedet on emacs-version > 23
(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/cedet-1.0/common"))
(load-file (expand-file-name "~/.emacs.d/vendor/cedet-1.0/common/cedet.el"))

