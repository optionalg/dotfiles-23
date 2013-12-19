(require 'package)

;;リポジトリにMarmaladeを追加
(add-to-list 'package-archives
             '("ELPA" . "http://tromey.com/elpa/"))
(add-to-list 'package-archives
             '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
;;リポジトリにMelpaを追加
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

;;インストールするディレクトリを指定
(setq package-user-dir (concat user-emacs-directory "vendor/elpa"))

;;インストールしたパッケージにロードパスを通してロードする
(package-initialize)

(defun reqpac (name)
  (progn (unless (package-installed-p name)
           (package-install name))
         (require name)))

;; no setting file
(reqpac 'scala-mode2)
(reqpac 'git-gutter)
(reqpac 'yaml-mode)
(reqpac 'rainbow-mode)
(dolist (hook '(css-mode-hook stylus-mode-hook sass-mode-hook))
  (add-hook hook 'rainbow-mode))

;; autopair
(reqpac 'autopair)
(autopair-global-mode)
(dolist (hook '(term-mode-hook ruby-mode-hook))
  (add-hook hook
            #'(lambda () 
                (setq autopair-dont-activate t) ;; for emacsen < 24
                (autopair-mode -1))             ;; for emacsen >= 24
            ))

;; ag
(reqpac 'ag)
(require 'project-root)
(custom-set-variables
 '(ag-highlight-search t)
 '(ag-reuse-window 'nil)
 '(ag-reuse-buffers 'nil))
(reqpac 'wgrep-ag)
(autoload 'wgrep-ag-setup "wgrep-ag")
(add-hook 'ag-mode-hook 'wgrep-ag-setup)
(define-key ag-mode-map (kbd "r") 'wgrep-change-to-wgrep-mode)
(global-set-key [(super m)]
                #'(lambda ()
                    (interactive)
                    (with-project-root-or-default
                        (call-interactively 'ag)
                        (select-window ; select ag buffer
                         (car (my/get-buffer-window-list-regexp "^\\*ag "))))))
