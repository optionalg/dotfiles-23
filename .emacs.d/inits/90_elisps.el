(setq load-path (cons (expand-file-name "~/.emacs.d/vendor/elisps") load-path))

(require 'auto-save-buffers)
(run-with-idle-timer 5 t 'auto-save-buffers)

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

;; (require 'direx)
;; (global-set-key (kbd "C-x C-j") 'direx:jump-to-directory-other-window)
;; ;; direx:direx-modeのバッファをウィンドウ左辺に幅25でポップアップ
;; ;; :dedicatedにtを指定することで、direxウィンドウ内でのバッファの切り替えが
;; ;; ポップアップ前のウィンドウに移譲される
;; (push '(direx:direx-mode :position left :width 50 :dedicated t)
;;       popwin:special-display-config)

(require 'jaunte)
(global-set-key (kbd "C-c C-j") 'jaunte)

(load "liquid.el")


;; Auto insert corresponding parenthesis
;; (require 'parenthesis)
;; (setq my-parenthesis-settings
;;       '((emacs-lisp-mode . "(\"")
;;         (c-mode . "{(\'\"[")
;;         (coffee-mode . "{(\"\'[/")
;;         ))
;; (defmacro my-parenthesis-gen-register-func (keystr mapname)
;;   `(lambda ()
;;     (parenthesis-register-keys ,(eval keystr) ,(eval mapname))))
;; (dolist (setting my-parenthesis-settings)
;;   (add-hook
;;    (intern (concat (symbol-name (car setting)) "-hook"))
;;    (my-parenthesis-gen-register-func
;;     (cdr setting)
;;     (intern (concat (symbol-name (car setting)) "-map")))))

;; nore
(add-to-list 'load-path "~/Dropbox/Proj/nore/misc")
(require 'nore)
(add-hook 'javascript-mode-hook
          '(lambda ()
             (define-key javascript-mode-map (kbd "<f1> n") 'nore-search-doc-at-point)))
(add-hook 'coffee-mode-hook
          '(lambda ()
             (define-key coffee-mode-map (kbd "<f1> n") 'nore-search-doc-at-point)))


;; dash
(autoload 'dash-at-point "dash-at-point"
          "Search the word at point with Dash." t nil)
(global-set-key (kbd "C-c r") 'dash-at-point)

;; edit server
(reqpac 'edit-server)
(edit-server-start)

;; nav
(add-to-load-path "vendor/nav/")
(require 'nav)
(nav-disable-overeager-window-splitting)
;; Optional: set up a quick key to toggle nav
(global-set-key [f8] 'nav-toggle)
;; (nav-jump-to-dir default-directory)


;; git-messenger
(reqpac 'popup)
(add-to-load-path "vendor/emacs-git-messenger")
(require 'git-messenger)
(global-set-key [f9] 'git-messenger:popup-message)
