(setq load-path (cons (expand-file-name "~/.emacs.d/vendor/elisps") load-path))

(require 'auto-save-buffers)
(run-with-idle-timer 5 t 'auto-save-buffers)

;; popwin.el
;; https://github.com/m2ym/popwin-el#readme
(setq popwin:popup-window-position 'bottom)
(setq popwin:popup-window-height 15)
(setq popwin:adjust-other-windows nil)
(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)
(setq anything-samewindow nil)
(push '("*anything*" :height 50 :position :left) popwin:special-display-config)
(push '("*anything imenu*" :height 40 :position :left) popwin:special-display-config)
;; (push '("*Moccur*" :height 50 :position :left) popwin:special-display-config)
(define-key global-map [(super o)] 'dired-jump-other-window)
(push '(dired-mode :height 80 :position :left) popwin:special-display-config)
(push '("Mew: \\+draft/" :height 120 :position :left) popwin:special-display-config)

(require 'recentf)
(setq recentf-max-saved-items 1000)
(recentf-mode 1)

;; (autoload 'term-toggle "term-toggle"
;;   "Toggles between the *terminal* buffer and whatever buffer you are editing." t)
;; (autoload 'term-toggle-cd "term-toggle"
;;   "Pops up a shell-buffer and insert a \"cd <file-dir>\" command." t)
;; (global-set-key [M-f1] 'term-toggle)
;; (global-set-key (kbd "C-x t") 'term-toggle-cd)

(require 'savekill)
;; auto-complete に同じ機能
;; (autoload 'ac-mode "~/.emacs.d/vendor/elisps/ac-mode" "Minor mode for advanced completion." t nil)
;; (load "~./.emacs.d/vendor/elisps/ac-mode")
;; (load "ac-mode")
;; (ac-mode) ;; enable

(require 'moccur-edit)

;; remember line
(setq-default save-place t)
(require 'saveplace)

(autoload 'html-fold-mode "html-fold" "Minor mode for hiding and revealing elements." t)
