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
;;(push '("^\\*anything" :regexp t :width 40 :position :left) popwin:special-display-config)
(push '("^\\*anything" :regexp t :width 40 :position :right) popwin:special-display-config)
(push '("*Help*" :width 64 :position :right :noselect t :stick t) popwin:special-display-config)
;; (push '("*anything imenu*" :width 40 :position :left) popwin:special-display-config)
;; (push '("*Moccur*" :height 50 :position :left) popwin:special-display-config)
(define-key global-map [(super o)] 'dired-jump-other-window)
(push '("*ri*" :width 70 :position :right :noselect t :stick t) popwin:special-display-config)

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

(require 'direx)
(global-set-key (kbd "C-x C-j") 'direx:jump-to-directory-other-window)
;; direx:direx-modeのバッファをウィンドウ左辺に幅25でポップアップ
;; :dedicatedにtを指定することで、direxウィンドウ内でのバッファの切り替えが
;; ポップアップ前のウィンドウに移譲される
(push '(direx:direx-mode :position left :width 50 :dedicated t)
      popwin:special-display-config)

(require 'jaunte)
(global-set-key (kbd "C-c C-j") 'jaunte)

(load "liquid.el")


;; Auto insert corresponding parenthesis
(require 'parenthesis)
(setq my-parenthesis-settings
      '((emacs-lisp-mode . "(\"")
        (c-mode . "{(\'\"[")
        (coffee-mode . "{(\"\'[/")
        ))
(defmacro my-parenthesis-gen-register-func (keystr mapname)
  `(lambda ()
    (parenthesis-register-keys ,(eval keystr) ,(eval mapname))))
(dolist (setting my-parenthesis-settings)
  (add-hook
   (intern (concat (symbol-name (car setting)) "-hook"))
   (my-parenthesis-gen-register-func
    (cdr setting)
    (intern (concat (symbol-name (car setting)) "-map")))))

;; nore
(add-to-list 'load-path "~/Dropbox/Proj/nore/misc")
(require 'nore)
(add-hook 'javascript-mode-hook
          '(lambda ()
             (define-key javascript-mode-map (kbd "<f1> n") 'nore-search-doc-at-point)))
(add-hook 'coffee-mode-hook
          '(lambda ()
             (define-key coffee-mode-map (kbd "<f1> n") 'nore-search-doc-at-point)))


:; physical line

