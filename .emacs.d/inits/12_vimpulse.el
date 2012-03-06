(add-to-list 'load-path "~/.emacs.d/vendor/vimpulse")
(add-to-list 'load-path "~/.emacs.d/vendor/elisps")
(setq viper-toggle-key [?\C-']
      vimpulse-want-quit-like-Vim nil
      viper-auto-indent t
      )

(require 'vimpulse)
(add-to-list 'viper-vi-state-mode-list 'dired-mode)
(add-to-list 'viper-emacs-state-mode-list 'term-mode)

;; (define-key global-map "\C-z" nil) ;;for elscreen
;; (define-key global-map "\C-x\C-z" 'toggle-viper-mode)

;; 物理行移動を基本にする
;; For use with Dvorak key map
(vimpulse-map "h" 'next-line)
(vimpulse-map "t" 'previous-line)
(vimpulse-map "d" 'viper-backward-char)
(vimpulse-map "n" 'viper-forward-char)
(vimpulse-map "k" 'vimpulse-delete)
(vimpulse-map [?\C-n] 'viper-next-line)
(vimpulse-map [?\C-p] 'viper-previous-line)
(vimpulse-map (kbd "C-w o") nil)

;; (vimpulse-map ";" 'viper-ex)
;; (vimpulse-map ":" 'anything-M-x)
;; (vimpulse-map "?" 'describe-bindings)
;; (vimpulse-map "l" 'forward-char)
;; (vimpulse-map "h" 'backward-char)
;; (vimpulse-map "F" 'find-file)
;; (vimpulse-map "f" 'jaunte)
;; (vimpulse-map "m" 'hs-toggle-hiding)
;; (vimpulse-map "M" 'my-toggle-hideshow-all)
;; (vimpulse-map " " 'anything)
;; (vimpulse-map "\C-r" 'anything-recentf)
;; (vimpulse-map "\C-y" 'yas/insert-snippet)
;; (vimpulse-map "\C-j" 'yafastnav-jump-to-forward)
;; (vimpulse-map "b" '(lambda ()
;;                      (interactive)
;;                      (anything 'anything-c-source-elscreen)
;;                      ))

;; (vimpulse-map "!" '(lambda ()
;;                      (interactive)
;;                      (anything 'anything-c-source-shell-command)
;;                      ))

;; (vimpulse-map "\C-s" 'anything-c-moccur-occur-by-moccur) ;バッファ内検索
;; (vimpulse-map "td" 'elscreen-kill)
;; (vimpulse-map "tt" '(lambda ()
;;                       (interactive)
;;                       (elscreen-create)
;;                       (anything-recentf)
;;                       ))
;; (vimpulse-map "H" 'elscreen-previous)
;; (vimpulse-map "L" 'elscreen-next)
;; (define-key viper-minibuffer-map "\C-g" 'keyboard-escape-quit)
;; (define-key viper-insert-global-user-map "\C-g" 'viper-exit-insert-state)
;; (define-key viper-insert-global-user-map "\C-h" 'delete-backward-char)
;; (define-key viper-insert-global-user-map "\C-b" 'backward-char)
;; (define-key viper-insert-global-user-map "\C-f" 'forward-char)
;; (define-key viper-insert-global-user-map "\C-n" 'next-line)
;; (define-key viper-insert-global-user-map "\C-p" 'previous-line)
;; (define-key viper-insert-global-user-map "\C-a" 'move-beginning-of-line)
;; (define-key viper-insert-global-user-map "\C-e" 'end-of-line)
;; (define-key viper-insert-global-user-map "\C-h" 'delete-backward-char)
;; (define-key viper-insert-global-user-map "\C-i" 'yas/expand)
;; (define-key viper-insert-global-user-map "\C-y" 'yas/insert-snippet)
;; (define-key vimpulse-visual-basic-map "v" 'end-of-line)
;; (define-key vimpulse-visual-basic-map ";" 'comment-dwim)

;; h l は行頭/行末を超えられるようにする
;; (vimpulse-map "h" 'backward-char)
;; (vimpulse-map "l" 'forward-char)

;; deleteと backspaceキーは文字削除
(vimpulse-map [delete] 'vimpulse-delete)
(vimpulse-map [backspace] 'backward-delete-char-untabify)


;; supress delay on ESC
;; set "maptimeout" 0 to screenrc using with screen
(setq viper-fast-keyseq-timeout 0)

(setq vimpulse-cjk-want-japanese-phrase-as-word t)
(require 'vimpulse-cjk)

(defun vimpulse-set-mode-line-face ()
  (unless (minibufferp (current-buffer))
    (set-face-background 'mode-line
                         (cdr (assq viper-current-state
                                    '(
                                      (vi-state       . "Gray")
                                      (insert-state   . "Yellow")
                                      (emacs-state    . "Wheat")
                                      (operator-state . "Green")
                                      (visual-state   . "Blue")))))))
(add-hook 'viper-vi-state-hook          'vimpulse-set-mode-line-face)
(add-hook 'viper-insert-state-hook      'vimpulse-set-mode-line-face)
(add-hook 'viper-emacs-state-hook       'vimpulse-set-mode-line-face)
(add-hook 'vimpulse-operator-state-hook 'vimpulse-set-mode-line-face)
(add-hook 'vimpulse-visual-state-hook   'vimpulse-set-mode-line-face)
(defadvice set-buffer (after vimpulse-mode-line-face activate)
  (vimpulse-set-mode-line-face))
(defadvice find-file (after vimpulse-mode-line-face activate)
  (vimpulse-set-mode-line-face))
(defadvice kill-buffer (after vimpulse-mode-line-face activate)
  (vimpulse-set-mode-line-face))
(defadvice switch-to-buffer (after vimpulse-mode-line-face activate)
  (vimpulse-set-mode-line-face))
(defadvice select-window (after vimpulse-mode-line-face activate)
  (vimpulse-set-mode-line-face))
(defadvice delete-window (after vimpulse-mode-line-face activate)
  (vimpulse-set-mode-line-face))

;; use with anythig
(defvar my-minibuffer-minor-mode nil)
(defun my-minibuffer-minor-mode ()
  (when (fboundp my-minibuffer-minor-mode)
    (funcall (symbol-function my-minibuffer-minor-mode))))
(add-hook 'minibuffer-setup-hook 'my-minibuffer-minor-mode)
;;(add-hook 'minibuffer-exit-hook 'my-minibuffer-minor-mode)
(defadvice anything (around set-major-mode activate)
  (let ((my-minibuffer-minor-mode 'my-anything-minibuffer-mode))
    ad-do-it))
(easy-mmode-define-minor-mode
 my-anything-minibuffer-mode
 "Anything MiniBuffer Mode"
 nil
 " Anything MiniBuffer"
 '())

(vimpulse-define-key 'my-anything-minibuffer-mode 'insert-state "\C-\M-n" 'anything-next-source)
(vimpulse-define-key 'my-anything-minibuffer-mode 'insert-state "\C-\M-p" 'anything-previous-source)
(vimpulse-define-key 'my-anything-minibuffer-mode 'insert-state "\C-n" 'anything-next-line)
(vimpulse-define-key 'my-anything-minibuffer-mode 'insert-state "\C-p" 'anything-previous-line)
(vimpulse-define-key 'my-anything-minibuffer-mode 'insert-state "\C-f" 'anything-next-page)
(vimpulse-define-key 'my-anything-minibuffer-mode 'insert-state "\C-b" 'anything-previous-page)
(vimpulse-define-key 'my-anything-minibuffer-mode 'insert-state "\C-l" 'anything-force-update)
(vimpulse-define-key 'my-anything-minibuffer-mode 'vi-state "o" 'anything-follow-mode)
(vimpulse-define-key 'my-anything-minibuffer-mode 'vi-state "j" 'anything-next-line)
(vimpulse-define-key 'my-anything-minibuffer-mode 'vi-state "k" 'anything-previous-line)
(vimpulse-define-key 'my-anything-minibuffer-mode 'vi-state "\C-f" 'anything-next-page)
(vimpulse-define-key 'my-anything-minibuffer-mode 'vi-state "\C-b" 'anything-previous-page)
(vimpulse-define-key 'my-anything-minibuffer-mode 'vi-state "\C-l" 'anything-force-update)
(vimpulse-define-key 'my-anything-minibuffer-mode 'vi-state "}" 'anything-next-source)
(vimpulse-define-key 'my-anything-minibuffer-mode 'vi-state "{" 'anything-previous-source)
(vimpulse-define-key 'my-anything-minibuffer-mode 'vi-state "gg" 'anything-beginning-of-buffer)
(vimpulse-define-key 'my-anything-minibuffer-mode 'vi-state "G" 'anything-end-of-buffer)
(vimpulse-define-key 'my-anything-minibuffer-mode 'vi-state "/" 'anything-isearch)


