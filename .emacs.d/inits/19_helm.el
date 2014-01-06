(setq helm-idle-delay 0.3) ; 候補を作って描写するまでのタイムラグ。デフォルトで 0.3
(setq helm-input-idle-delay 0.2) ; 文字列を入力しから検索するまでのタイムラグ。デフォルトで 0
(setq helm-candidate-number-limit 50)
;; Configure window display
;; (setq helm-split-window-in-side-p t)
;; (setq helm-split-window-default-side 'left)
;; (setq helm-always-two-windows nil)

(reqpac 'helm)
(require 'helm-config)

;; See: https://github.com/emacs-helm/helm/issues/30
(require 'helm-buffers)
(require 'helm-files)


(defun my-helm ()
  (interactive)
  (helm-other-buffer
   '(
     helm-source-buffers-list
     helm-source-bookmarks
     helm-source-files-in-current-dir
     helm-source-recentf
     ;; helm-c-source-imenu
     )
  "*helm*"))

(define-key global-map [(super a)] 'my-helm)
(define-key global-map [(super i)] 'helm-imenu)
(define-key global-map [(super .)] 'helm-show-kill-ring)


;; List files in git repos
(defun helm-c-sources-git-project-for (pwd)
  (loop for elt in
        '(("Modified files" . "--modified")
          ("Untracked files" . "--others --exclude-standard")
          ("All controlled files in this project" . nil))
        for title  = (format "%s (%s)" (car elt) pwd)
        for option = (cdr elt)
        for cmd    = (format "git ls-files %s" (or option ""))
        collect
        `((name . ,title)
          (init . (lambda ()
                    (unless (and (not ,option) (helm-candidate-buffer))
                      (with-current-buffer (helm-candidate-buffer 'global)
                        (call-process-shell-command ,cmd nil t nil)))))
          (candidates-in-buffer)
          (type . file))))

(defun helm-git-project-topdir ()
  (file-name-as-directory
   (replace-regexp-in-string
    "\n" ""
    (shell-command-to-string "git rev-parse --show-toplevel"))))

(defun helm-git-project ()
  (interactive)
  (let ((topdir (helm-git-project-topdir)))
    (unless (file-directory-p topdir)
      (error "I'm not in Git Repository!!"))
    (let* ((default-directory topdir)
           (sources (helm-c-sources-git-project-for default-directory)))
      (helm-other-buffer sources
                         (format "*helm git project in %s*" default-directory)))))

(define-key global-map [(super \,)] 'helm-git-project)


;; helm ag
(setq helm-ag-base-command "ag --nocolor --nogroup --ignore-case")
(setq helm-ag-command-option "--all-text")
(setq helm-ag-thing-at-point 'symbol)
(require 'helm-ag)
(global-set-key (kbd "M-g .") 'helm-ag)
(global-set-key (kbd "M-g ,") 'helm-ag-pop-stack)
(global-set-key (kbd "C-M-s") 'helm-ag-this-file)
