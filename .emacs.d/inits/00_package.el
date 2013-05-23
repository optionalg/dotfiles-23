(if (<= emacs-major-version 23)
    (add-to-load-path "vendor/elisps"))

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

;; speedbar
(reqpac 'sr-speedbar)
(custom-set-variables
 '(speedbar-show-unknown-files t)
 ;; '(speedbar-directory-unshown-regexp "^\\(\\.[^\\.].*\\)\\'")
 '(sr-speedbar-width-x 80)
 '(sr-speedbar-max-width 120)
 '(sr-speedbar-right-side nil)
 )
(global-set-key [f2] 'sr-speedbar-toggle)
