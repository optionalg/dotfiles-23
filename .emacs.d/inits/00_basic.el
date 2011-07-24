;; -*- Coding: utf-8 -*-

;;=============================
;; global settings
;;=============================
(setq initial-major-mode 'lisp-interaction-mode)
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
(setq auto-save-default nil)
(global-font-lock-mode t)
(line-number-mode t)
(column-number-mode t)
(unless window-system
    (menu-bar-mode -1))
(if window-system
    (progn
      (setq initial-frame-alist
            (append (list
                     '(width . 124) ;; ウィンドウ幅
                     '(height . 48) ;; ウィンドウの高さ
                     )))
      (toggle-scroll-bar nil)))

;; Key Mapping
;; (global-set-key "\C-h" 'delete-backward-char)
(keyboard-translate ?\C-h ?\C-?)
;(global-set-key "\C-[" 'ESC) ;cause "M-x is undefined"
(global-set-key "\C-m" 'newline-and-indent)
(global-set-key "\C-z" 'undo)
; move between window
(global-set-key [M-left] 'windmove-left)          ; move to left windnow
(global-set-key [M-right] 'windmove-right)        ; move to right window
(global-set-key [M-up] 'windmove-up)              ; move to upper window
(global-set-key [M-down] 'windmove-down)          ; move to downer window
(global-set-key "\C-xm" 'browse-url-at-point)
(global-set-key "\C-x." 'find-file-at-point)
(global-set-key [C-tab] 'other-window)

;; Edit
(show-paren-mode 1)
(which-function-mode 1)
(global-auto-revert-mode 1) ;auto-reload the changed file
; Scroll
(setq scroll-conservatively 35
      scroll-margin 0
      scroll-step 1)
(setq comint-scroll-show-maximum-output t) ;for exec in shell
; Region
(setq transient-mark-mode t) ;highlight region
(setq highlight-nonselected-windows t)
; Auto BR
(add-hook 'text-mode-hook
          '(lambda ()
             (refill-mode 1)
             ))
; fold always
(setq truncate-lines nil)
(setq truncate-partial-width-windows nil)

;; require key inputs when C-x C-c
;; from: http://d.hatena.ne.jp/Ubuntu/20090417/1239934416
(defun confirm-save-buffers-kill-emacs ()
  (interactive)
  (if (yes-or-no-p "quit emacs? ")
    (save-buffers-kill-emacs)))
(global-set-key "\C-x\C-c" 'confirm-save-buffers-kill-emacs)

;; Beeps
(setq ring-bell-function 'ignore) ; No Beeps

;; Menu
(recentf-mode 1) ;enable recent file menu
;(setq recentf-keep '(file-remote-p file-readable-p)) ;dont work for recentf in menu bar
(setq recentf-exclude '("^/[^/:]+:")) ;without this, tramp goes to remote host at every startup sequences.

;; make directory when find-file with non-exist directory
(defun make-directory-unless-directory-exists ()
  (let ((d (file-name-directory buffer-file-name)))
    (unless (file-directory-p d)
      (when (y-or-n-p "No such directory: make directory?")
        (make-directory d t))))
  nil)
(add-hook 'find-file-not-found-hooks
          'make-directory-unless-directory-exists)

;; Backup
; save backups to ~/bak with filename "#path#to#file"
; from: http://fun.poosan.net/sawa/index.php?UID=1176631703
(setq backup-by-copying t)
(defadvice make-backup-file-name
  (around modify-file-name activate)
  (let ((backup-dir "~/bak/emacs")) ; dir to save
    (setq backup-dir (expand-file-name backup-dir))
    (unless (file-exists-p backup-dir)
      (make-directory-internal backup-dir))
    (if (file-directory-p backup-dir)
        (let*
            ((file-path (expand-file-name file))
             (chars-alist '((?/ . (?#))(?# . (?# ?#))(?: . (?\;))(?\; . (?\; ?\;))))
             (mapchars(lambda (c) (or (cdr (assq c chars-alist)) (list c)))))
          (setq ad-return-value
                (concat backup-dir "/" (mapconcat 'char-to-string
                                                  (apply 'append
                                                         (mapcar mapchars file-path)) ""))))
      ad-do-it)))

;; original commands
(defun my-get-date-gen (form) (insert (format-time-string form)))
(defun my-get-date () (interactive) (my-get-date-gen "%Y-%m-%d"))
(defun my-get-time () (interactive) (my-get-date-gen "%H:%M"))
(defun my-get-dtime () (interactive) (my-get-date-gen "%Y-%m-%d %H:%M"))
(global-set-key "\C-c\C-t" 'my-get-time)
(global-set-key "\C-c\C-d" 'my-get-date)
(global-set-key "\C-c\ed" 'my-get-dtime)
(global-set-key "\C-xt" (term "/usr/bin/zsh"))

;; start server
(require 'server)
(unless (server-running-p)
  (server-start))

;; path
;; より下に記述した物が PATH の先頭に追加されます
(dolist (dir (list
              "/sbin"
              "/usr/sbin"
              "/bin"
              "/usr/bin"
              "/opt/local/bin"
              "/sw/bin"
              "/usr/local/bin"
              (expand-file-name "~/bin")
              (expand-file-name "~/.emacs.d/bin")
              (expand-file-name "~/.nave/installed/0.4.9/bin")
              ))
 ;; PATH と exec-path に同じ物を追加します
 (when (and (file-exists-p dir) (not (member dir exec-path)))
   (setenv "PATH" (concat dir ":" (getenv "PATH")))
   (setq exec-path (append (list dir) exec-path))))

;; fonts
(when (and
       (>= emacs-major-version 23)
       window-system
       (eq system-type 'darwin))
  (set-face-attribute 'default nil
                      :family "monaco"
                      :height 120)
  (set-fontset-font
   (frame-parameter nil 'font)
   'japanese-jisx0208
   '("Hiragino Maru Gothic Pro" . "iso10646-1"))
  (set-fontset-font
   (frame-parameter nil 'font)
   'japanese-jisx0212
   '("Hiragino Maru Gothic Pro" . "iso10646-1"))
  (set-fontset-font
   (frame-parameter nil 'font)
   'mule-unicode-0100-24ff
   '("monaco" . "iso10646-1"))
  (setq face-font-rescale-alist
        '(("^-apple-hiragino.*" . 1.1)
          (".*osaka-bold.*" . 1.2)
          (".*osaka-medium.*" . 1.2)
          (".*courier-bold-.*-mac-roman" . 1.0)
          (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
          (".*monaco-bold-.*-mac-roman" . 0.9)
          ("-cdac$" . 1.3))))
