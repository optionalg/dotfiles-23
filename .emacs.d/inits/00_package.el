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


(defun reqpack (name)
  (progn (unless (package-installed-p name)
           (package-install name))
         (require name)))

;; just require (no settings)
(reqpack 'scala-mode2)
(reqpack 'git-gutter)
(reqpack 'yaml-mode)
