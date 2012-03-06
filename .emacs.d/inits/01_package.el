(add-to-load-path "vendor/elisps")

(require 'package)

;;リポジトリにMarmaladeを追加
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))

;;インストールするディレクトリを指定
(setq package-user-dir (concat user-emacs-directory "vendor/elpa"))

;;インストールしたパッケージにロードパスを通してロードする
(package-initialize)

;; Setup Marmalade
(load "marmalade.el")
(setq marmalade-server "http://marmalade-repo.org/")
