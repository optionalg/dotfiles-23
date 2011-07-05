;; -*- Coding: utf-8 -*-

;;=============================
;; global settings
;;=============================
;; Basic settings
(setq initial-major-mode 'lisp-interaction-mode)
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(global-font-lock-mode t)
(line-number-mode t)
(column-number-mode t)
;; (add-to-list 'load-path "~/.emacs.d")
;; (add-to-list 'load-path "~/.emacs.d/elisp/")

;; Key Mapping
(global-set-key "\C-h" 'delete-backward-char)
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
(global-auto-revert-mode 1)		;auto-reload the changed file
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
						  (apply 'append (mapcar mapchars file-path)) "")))) ad-do-it)))
 	
;; original commands
(defun my-get-date-gen (form) (insert (format-time-string form)))
(defun my-get-date () (interactive) (my-get-date-gen "%Y-%m-%d"))
(defun my-get-time () (interactive) (my-get-date-gen "%H:%M"))
(defun my-get-dtime () (interactive) (my-get-date-gen "%Y-%m-%d %H:%M"))
(global-set-key "\C-c\C-d" 'my-get-date)
(global-set-key "\C-c\C-t" 'my-get-time)
(global-set-key "\C-c\ed" 'my-get-dtime)

