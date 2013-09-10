;; -*- Coding: utf-8 -*-

;;=============================
;; global settings
;;=============================

;; start server
(require 'server)
(unless (server-running-p)
  (server-start))

(savehist-mode 1)
(setq initial-major-mode 'lisp-interaction-mode)
(setq inhibit-startup-screen t)
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
(setq auto-save-default nil)
(global-font-lock-mode t)
(line-number-mode t)
(column-number-mode t)
(tool-bar-mode -1)
(custom-set-variables
 '(split-width-threshold 70)
)
(setq vc-follow-symlinks t)
;; Avoid re-building of display buffer
(setq gc-cons-threshold 40960000)        ; 40M(default: 400K)
(setq frame-title-format
      '("emacs@" system-name ":"
        (:eval (or (buffer-file-name)
                   default-directory))
        ))
(if window-system
    (progn
      (setq initial-frame-alist
            (append
             (if (eq system-type 'darwin)
                 (list '(width . 164) '(height . 48))
               (list '(width . 80) '(height . 48))
               )))
      (toggle-scroll-bar nil)))
(if (eq system-type 'darwin)
    (progn
      (menu-bar-mode t)
      ;; Drag file to open that file in new buffer.
      (define-key global-map [ns-drag-file] 'ns-find-file)
      ;; prevent many frames to be opened
      (setq ns-pop-up-frames nil))
  (menu-bar-mode -1))


;; Key
(when (eq system-type 'darwin)         ; もし、システムが Mac のとき
  (setq mac-command-key-is-meta nil)   ; コマンドキーをメタにしない
  (setq mac-option-modifier 'meta)     ; オプションキーをメタに
  (setq mac-command-modifier 'super)   ; コマンドキーを Super に
  (setq mac-pass-control-to-system t)) ; コントロールキーを Mac ではなく Emacs に渡す

(if (equal system-name "ubuntu")
    (progn
      (setq x-meta-keysym 'super
            x-super-keysym 'meta
            ;browse-url-browser-function 'browse-url-with-chrome
      )))


;; Utilities
(defun toggle-fullscreen (&optional f)
  "toggle full screen or normal window"
  (interactive)
  (let ((current-value (frame-parameter nil 'fullscreen)))
    (set-frame-parameter nil 'fullscreen
                         (if (equal 'fullboth current-value)
                             (if (boundp 'old-fullscreen) old-fullscreen nil)
                           (progn (setq old-fullscreen current-value)
                                  'fullboth)))))

(if (eq system-type 'darwin)
    (progn
      (global-set-key [C-f11] 'ns-toggle-fullscreen)
      )
  (progn
    ;; Make new frames fullscreen by default. Note: this hook doesn't do
    ;; anything to the initial frame if it's in your .emacs, since that file is
    ;; read _after_ the initial frame is created.
    ;; (add-hook 'after-make-frame-functions 'toggle-fullscreen)
    (global-set-key [f11] 'toggle-fullscreen)
    )
  )

(global-set-key [(super f1)] 'other-frame)

(defun browse-url-with-chrome (url &rest args)
  (interactive)
  (let ((proc
    (start-process-shell-command "chrome" nil
                                 ;(concat "/usr/bin/chromium-browser " url))))
                                 (concat "/usr/bin/google-chrome " url))))
    (set-process-query-on-exit-flag proc nil)
    (set-process-sentinel proc '(lambda (proc, status) ()))
    (set-process-filter proc '(lambda (proc, data) ()))))

(defun search-google ()
  (interactive)
  (browse-url (format "http://google.com/search?q=%s"
                      (region-string-or-currnet-word))))
(global-set-key (kbd "C-x w") 'search-google)

(defun search-dict ()
  (interactive)
  (browse-url (format "dict:///%s"
                      (region-string-or-currnet-word))))
(global-set-key (kbd "C-x p") 'search-dict)


;; display EOF
(setq-default indicate-empty-lines t)

;; Key Mapping
;; (global-set-key "\C-h" 'delete-backward-char)
(keyboard-translate ?\C-h ?\C-?)
;(global-set-key "\C-[" 'ESC) ;cause "M-x is undefined"
(global-set-key "\C-m" 'newline-and-indent)
(global-set-key "\C-z" 'undo)
; move between window
(global-set-key [C-M-n] 'windmove-right)  ; move to left windnow
(global-set-key [C-M-d] 'windmove-left)   ; move to right window
(global-set-key [C-M-t] 'windmove-up)     ; move to upper window
(global-set-key [C-M-h] 'windmove-down)   ; move to downer window
(global-set-key "\C-xm" 'browse-url-at-point)
(global-set-key "\C-x." 'find-file-at-point)
(global-set-key [C-tab] 'other-window)
(global-set-key [(super p)] nil)
;(global-set-key "\M-\C-f" 'ns-toggle-fullscreen)
(global-set-key [(super n)] 'make-frame)
(global-set-key [(super d)] 'dired)
(global-set-key [(super f)] 'find-file)
;; Copy & Paste for Dvorak
;; (global-set-key [(super j)] 'ns-copy-including-secondary)
;; (global-set-key [(super k)] 'yank)
;; (global-set-key [(super q)] 'kill-region)

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
;; its so annoying..
;; (add-hook 'text-mode-hook
;;           '(lambda ()
;;              (refill-mode 1)
;;              ))
; fold always
(setq truncate-lines nil)
(setq truncate-partial-width-windows nil)

(setq ffap-c-path
      '("/usr/include" "/usr/local/include"))
(setq ffap-kpathsea-depth 5)

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
             (chars-alist '((?/ . (?#))(?# . (?# ?#))(?: . (?\;))(?\; . (?\; ?\;)))) (mapchars(lambda (c) (or (cdr (assq c chars-alist)) (list c))))) (setq ad-return-value
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

;; insert day with calender
(eval-after-load "calendar"
  '(progn
     (define-key calendar-mode-map
       "\C-m" 'my-insert-day)
     (defun my-insert-day ()
       (interactive)
       (let ((day nil)
             (calendar-date-display-form
         '("[" year "-" (format "%02d" (string-to-int month))
           "-" (format "%02d" (string-to-int day)) "]")))
         (setq day (calendar-date-string
                    (calendar-cursor-to-date t)))
         (exit-calendar)
         (insert day)))))


;; shell-command extension
(defadvice erase-buffer (around erase-buffer-noop)
  "make erase-buffer do nothing")

(defadvice shell-command (around shell-command-unique-buffer activate compile)
  (if (or current-prefix-arg
          (not (string-match "[ \t]*&[ \t]*\\'" command)) ;; background
          (bufferp output-buffer)
          (stringp output-buffer))
      ad-do-it ;; no behavior change

    ;; else we need to set up buffer
    (let* ((command-buffer-name
            (format "*background: %s*"
                    (substring command 0 (match-beginning 0))))
           (command-buffer (get-buffer command-buffer-name)))

      (when command-buffer
        ;; if the buffer exists, reuse it, or rename it if it's still in use
        (cond ((get-buffer-process command-buffer)
               (set-buffer command-buffer)
               (rename-uniquely))
              ('t
               (kill-buffer command-buffer))))
      (setq output-buffer command-buffer-name)

      ;; insert command at top of buffer
      (switch-to-buffer-other-window output-buffer)
      (insert "Running command: " command
              "\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n")

      ;; temporarily blow away erase-buffer while doing it, to avoid
      ;; erasing the above
      (ad-activate-regexp "erase-buffer-noop")
      ad-do-it
      (ad-deactivate-regexp "erase-buffer-noop"))))


;; open file with App set by OS
(defun open ()
  (interactive)
  (let ((path (or buffer-file-name default-directory)))
    (cond
     ((eq system-type 'darwin) (shell-command (concat "open " path)))
     (t (error "Can't specify open command for system type: %s" system-type))
     )))


;; Buffer
; ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)
; Ensure ibuffer opens with point at the current buffer's entry.
(defadvice ibuffer
  (around ibuffer-point-to-most-recent) ()
  "Open ibuffer with cursor pointed to most recent buffer name."
  (let ((recent-buffer-name (buffer-name)))
    ad-do-it
    (ibuffer-jump-to-buffer recent-buffer-name)))
(ad-activate 'ibuffer)

; kill other buffers
(defun kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (let* ((no-kill-buffer-names
          (list (buffer-name (current-buffer))
                "*Messages*" "*Compile-Log*" "*Help*"
                "*init log*" "*Ibuffer*" "*scratch*"
                "*MULTI-TERM-DEDICATED*"))
         (interested-buffers (my/filter
                              '(lambda (buffer)
                                 (and
                                  ; dont kill hidden buffers (hidden buffers' name starts with SPACE)
                                  (not (string-match "^ " (buffer-name buffer)))
                                  ; dont kill buffers who have running processes
                                  (let ((proc (get-buffer-process buffer)))
                                    (if proc
                                        (equal 'exit
                                               (process-status
                                                (get-buffer-process buffer)))
                                      t))))
                              (buffer-list)))
         (buffers-to-kill (set-difference interested-buffers
                                          (mapcar '(lambda (buffer-name)
                                                     (get-buffer buffer-name))
                                                  no-kill-buffer-names))))
    (mapc 'kill-buffer buffers-to-kill)))
(global-set-key (kbd "C-c C-b C-b") 'kill-other-buffers)
