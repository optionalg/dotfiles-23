;;
;; el-get

(setq el-get-dir "~/.emacs.d/el-get/")
(setq el-get-user-package-directory "~/.emacs.d/el-get-inits")

;; Define Custom Sources
(setq el-get-sources
      '(
        (:name project-root
               :website "http://solovyov.net/project-root/"
               :type hg
               :description "Project handling solution for Emacs"
               :url "http://hg.piranha.org.ua/project-root"
               )
        ))

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(el-get 'sync)

;; Force install packages listed on el-get-sources
(setq my/el-get-source-names
      (mapcar #'(lambda (lst)
                  (plist-get lst :name))
              el-get-sources))

(el-get 'sync my/el-get-source-names)
