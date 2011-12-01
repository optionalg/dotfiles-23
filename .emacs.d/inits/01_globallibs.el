(add-to-list 'load-path "~/.emacs.d/lib/apel")

;; disable default load-path for cedet on emacs-version > 23
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lib/cedet-1.0/common"))
(load-file (expand-file-name "~/.emacs.d/lib/cedet-1.0/common/cedet.el"))

;; semantic
(setq semantic-load-turn-useful-things-on t)
(unless (featurep 'cedet) (load "cedet"))
;; enable semantic-imenu
(semantic-load-enable-code-helpers)
(semantic-load-enable-minimum-features)

;; deferred
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lib/emacs-deferred"))
(load-file (expand-file-name "~/.emacs.d/lib/emacs-deferred/deferred.el"))
(load-file (expand-file-name "~/.emacs.d/lib/emacs-deferred/concurrent.el"))