(add-to-list 'load-path "~/.emacs.d/vendor/anything-config")
;;(require 'anything-startup)

(require 'anything-config)
(add-to-list 'anything-sources 'anything-c-source-emacs-commands)

(define-key global-map [(super a)] 'anything)

(setq anything-idle-delay 0.4) ; 候補を作って描写するまでのタイムラグ。デフォルトで 0.3
(setq anything-input-idle-delay 0.3) ; 文字列を入力してから検索するまでのタイムラグ。デフォルトで 0
(setq anything-candidate-number-limit 100) ; 表示する最大候補数。デフォルトで 50

;; keybindings
;; from: http://www.emacswiki.org/emacs/RubikitchAnythingConfiguration
;; (define-key anything-map "\C-k" (lambda () (interactive) (delete-minibuffer-contents)))
;; (setq anything-map-C-j-binding 'anything-select-3rd-action)
;; (define-key anything-map "\C-j" anything-map-C-j-binding)
;; (define-key anything-map "\C-e" 'anything-select-2nd-action-or-end-of-line)
;; (define-key anything-map "\M-N" 'anything-next-source)
;; (define-key anything-map "\M-P" 'anything-previous-source)
(define-key anything-map "\C-\M-n" 'anything-next-source)
(define-key anything-map "\C-\M-p" 'anything-previous-source)
(define-key anything-map "\C-s" 'anything-isearch)
(define-key anything-map (kbd "C-p") 'anything-previous-line)
(define-key anything-map (kbd "C-n") 'anything-next-line)
(define-key anything-map "\C-v" 'anything-next-page)
(define-key anything-map "\M-v" 'anything-previous-page)
(define-key anything-map "\C-z" 'anything-execute-persistent-action)
(define-key anything-map "\C-i" 'anything-select-action)
(define-key anything-map "B" 'anything-insert-buffer-name)
(define-key anything-map "R" 'anything-show/rubyref)
(define-key anything-map "C" 'anything-show/create)
;;(define-key anything-map "\C-k" 'anything-show/create)
;; (define-key anything-map "\C-b" 'anything-backward-char-or-insert-buffer-name)
;; (define-key anything-map "\C-o" 'anything-next-source)
;; (define-key anything-map "\C-\M-v" 'anything-scroll-other-window)
;; (define-key anything-map "\C-\M-y" 'anything-scroll-other-window-down)
;; ;; [2008/04/02]
;; (define-key anything-map [end] 'anything-scroll-other-window)
;; (define-key anything-map [home] 'anything-scroll-other-window-down)
;; (define-key anything-map [next] 'anything-next-page)
;; (define-key anything-map [prior] 'anything-previous-page)
;; (define-key anything-map [delete] 'anything-execute-persistent-action)
;; ;; [2008/08/22]
;; (define-key anything-map (kbd "C-:") 'anything-for-create-from-anything)

;; ;; (@> " frequently used commands - keymap")

;; (define-key anything-isearch-map "\C-m"  'anything-isearch-default-action)

;; (setq anything-enable-digit-shortcuts nil)
;; (define-key anything-map (kbd "M-1") 'anything-select-with-digit-shortcut)
;; (define-key anything-map (kbd "M-2") 'anything-select-with-digit-shortcut)
;; (define-key anything-map (kbd "M-3") 'anything-select-with-digit-shortcut)
;; (define-key anything-map (kbd "M-4") 'anything-select-with-digit-shortcut)
;; (define-key anything-map (kbd "M-5") 'anything-select-with-digit-shortcut)
;; (define-key anything-map (kbd "M-6") 'anything-select-with-digit-shortcut)
;; (define-key anything-map (kbd "M-7") 'anything-select-with-digit-shortcut)
;; (define-key anything-map (kbd "M-8") 'anything-select-with-digit-shortcut)
;; (define-key anything-map (kbd "M-9") 'anything-select-with-digit-shortcut)

;; (define-key anything-map "N" 'anything-next-visible-mark)
;; (define-key anything-map "P" 'anything-prev-visible-mark)
;; (define-key anything-map (kbd "C-SPC") 'anything-toggle-visible-mark)
;; (define-key anything-map "M" 'anything-toggle-visible-mark)
;; (define-key anything-map "Y" 'anything-yank-selection)
;; (define-key anything-map "\M-[" 'anything-prev-visible-mark)
;; (define-key anything-map "\M-]" 'anything-next-visible-mark)

(define-key anything-map "\C-a" 'beginning-of-line)
