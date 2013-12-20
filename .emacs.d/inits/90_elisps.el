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

;; Moccur
;; (setq moccur-split-word t)
;; (global-set-key [(super m)] 'moccur-grep-find)
;; (require 'color-moccur)
;; (require 'moccur-edit)

;; remember line
(setq-default save-place t)
(require 'saveplace)

(autoload 'html-fold-mode "html-fold" "Minor mode for hiding and revealing elements." t)

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

;; git-messenger
(reqpac 'popup)
(require 'git-messenger)
(custom-set-variables
 '(git-messenger:show-detail t))
; set evil key bind
(let ((map '("c" git-messenger:popup-message)))
  (apply 'define-key evil-normal-state-map map)
  ;; (apply 'define-key evil-visual-state-map map)
  ;; (apply 'define-key evil-motion-state-map map)
  )

;; direx
;; (require 'direx-project)
;; (push '(direx:direx-mode
;;         :position left
;;         :width 32
;;         :dedicated t
;;         :stick t)
;;       popwin:special-display-config)

;; (defun my/buffer-mode (buffer-or-string)
;;   "Returns the major mode associated with a buffer."
;;   (with-current-buffer buffer-or-string
;;      major-mode))

;; (defun my/find-mode-window (major-mode-symbol)
;;   (car
;;    (my/filter '(lambda (win)
;;                  (equal (my/buffer-mode (window-buffer win)) major-mode-symbol))
;;               (window-list))))

;; (global-set-key [f8]
;;                 '(lambda ()
;;                    (interactive)
;;                    (let* ((direx-win (my/find-mode-window 'direx:direx-mode))
;;                           (direx-buffer (window-buffer direx-win))
;;                           (current-win (selected-window)))
;;                      (if direx-win
;;                          (progn
;;                            (delete-window direx-win)
;;                            (kill-buffer direx-buffer))
;;                        (progn
;;                          (direx-project:jump-to-project-root-other-window)
;;                          (select-window current-win)))))) ;select-window not working..

;; dirtree
(setq  dirtree-windata '(frame left 0.2 nil))

(require 'dirtree)

(defmacro my/if-dirtree-window-exist (win &rest on-t on-nil)
  `(let* ((buffer (get-buffer dirtree-buffer))
          (,win (and buffer
                    (get-buffer-window buffer))))
         (if ,win
             ,@on-t
           ,@on-nil)))

(global-set-key [f8]
                #'(lambda ()
                   (interactive)
                   (my/if-dirtree-window-exist window
                                               (delete-window window)
                                               (dirtree default-directory nil))))

(defun my/dirtree-update ()
  (my/if-dirtree-window-exist window
                              (progn
                                        ; set window dedicated sometimes dedicated is cancelled somehow
                                (set-window-dedicated-p window 1)
                                        ; dont update when in dirtree-buffer
                                (unless (equal (buffer-name) dirtree-buffer)
                                  (dirtree default-directory nil)))))

(defadvice switch-to-buffer (after dirtree-update (buffer-or-name
                                                   &optional
                                                   norecord
                                                   force-same-window))
  (my/dirtree-update))
(defadvice quit-window (after dirtree-update (&optional kill window))
  (my/dirtree-update))
;; Windmove 使ってない時は他の関数をアドバイス
(defadvice windmove-do-window-select (after dirtree-update (dir &optional arg window))
  (my/dirtree-update))

(ad-activate 'switch-to-buffer)
(ad-activate 'quit-window)
(ad-activate 'windmove-do-window-select)

;; toggle with fullscreen state
(defadvice toggle-frame-fullscreen (after dirtree-show-hide)
  (if (frame-parameter nil 'fullscreen) ; if fullscreen, non-nil
      (progn
        (sit-for 1) ; wait resising
        (dirtree default-directory nil)
        (split-window-right))
    (progn
      (my/if-dirtree-window-exist window
                                  (delete-window window))
      (delete-other-windows)
      )))
(ad-activate 'toggle-frame-fullscreen)

;; font-lock
;; TODO:
(defface my/face-u-1 '((t (:foreground "SteelBlue"))) nil)
(defvar my/face-u-1 'my/face-u-1)
(font-lock-add-keywords 'tree-mode
                        '(
                          ("^[^\s-]*" . 'my/face-u-1)
                          ))

;; Sticky Windows
;; prevent dedicated windows from deleted
(require 'sticky-windows)
(global-set-key [(control x) (?0)] 'sticky-window-delete-window)
(global-set-key [(control x) (?1)] 'sticky-window-delete-other-windows)
(global-set-key [(control x) (?9)] 'sticky-window-keep-window-visible)

;; Lingr
(require 'lingr)
(require 'private)
