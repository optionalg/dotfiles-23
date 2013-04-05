(reqpack 'helm)
(require 'helm-config)

;; See: https://github.com/emacs-helm/helm/issues/30
(require 'helm-buffers)
(require 'helm-files)

(defun my-helm ()
  (interactive)
  (helm-other-buffer
   '(
     helm-c-source-buffers-list
     helm-c-source-bookmarks
     helm-c-source-recentf
     helm-c-source-files-in-current-dir
     ;; helm-c-source-imenu
     )
  "*helm*"))

(define-key global-map [(super a)] 'my-helm)
(define-key global-map [(super i)] 'helm-imenu)

(setq helm-idle-delay 0.3) ; 候補を作って描写するまでのタイムラグ。デフォルトで 0.3
(setq helm-input-idle-delay 0.2) ; 文字列を入力しから検索するまでのタイムラグ。デフォルトで 0
(setq helm-candidate-number-limit 50)

;; keybinding
;; from: http://www.emacswiki.org/emacs/RubikitchAnythingConfiguration
;; (define-key anything-map "\C-k" (lambda () (interactive) (delete-minibuffer-contents)))
;; (setq anything-map-C-j-binding 'anything-select-3rd-action)
;; (define-key anything-map "\C-j" anything-map-C-j-binding)
;; (define-key anything-map "\C-e" 'anything-select-2nd-action-or-end-of-line)
;; (define-key anything-map "\M-N" 'anything-next-source)
;; (define-key anything-map "\M-P" 'anything-previous-source)
; (define-key anything-map "\C-\M-n" 'anything-next-source)
; (define-key anything-map "\C-\M-p" 'anything-previous-source)
;; (define-key helm-map)
;; (define-key helm-map "\C-s" 'helm-isearch)
;; (define-key helm-map (kbd "C-p") 'helm-previous-line)
;; (define-key helm-map (kbd "C-n") 'helm-next-line)
;; (define-key helm-map "\C-v" 'helm-next-page)
;; (define-key helm-map "\M-v" 'helm-previous-page)
;; (define-key helm-map "\C-z" 'helm-execute-persistent-action)
;; (define-key helm-map "\C-i" 'helm-select-action)
;; (define-key helm-map "B" 'helm-insert-buffer-name)
;; (define-key helm-map "R" 'helm-show/rubyref)
;; (define-key helm-map "C" 'helm-show/create)
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

;; (define-key anything-map "\C-a" 'beginning-of-line)

;; other than defaults
;; (add-to-list 'load-path "~/.emacs.d/vendor/anything-elisps")

;; (require 'anything-project)
;; (global-set-key (kbd "C-x a p") 'anything-project)
;; ;;; rails
;; (ap:add-project
;;  :name 'rails
;;  :look-for '("Gemfile" "Rakefile")
;;  :grep-extensions '("\\.rb" "\\.erb" "\\.js" "\\.coffee" "\\.html" "\\.css"))
