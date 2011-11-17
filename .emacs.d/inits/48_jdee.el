(add-to-list 'load-path (expand-file-name "~/.emacs.d/lib/elib-1.0"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/jdee-2.4.0.1/lisp"))

(autoload 'jde-mode "jde" "Java Development Environment for Emacs." t)
(setq auto-mode-alist (cons '("\.java$" . jde-mode) auto-mode-alist))

(setq
 jde-sourcepath '("~/proj/jdee")
 ;; jde-db-option-connect-socket '(nil "28380")
 jde-jdk-registry (quote (
                          ;; ("1.6" . "/usr/lib/jvm/java-6-sun/")
                          ("1.6" . "~/lib/jdk1.7.0/")
                          )
                         )
 jde-jdk `("1.6")
 )
(setq jde-jdk-doc-url "http://download.oracle.com/javase/7/docs/api/")
(setq jde-help-docsets '(("JDK API" "http://download.oracle.com/javase/7/docs/api/" nil)))
(defun my-jde-mode-hook ()
  "Hook for jde-mode"
  (c-set-offset 'substatement-open 0)
  (c-set-offset 'statement-case-open 0)
  (c-set-offset 'case-label '+)
  (add-to-list 'ac-sources 'ac-source-semantic)
  ;; (wisent-java-default-setup)
  ;; (flymake-mode)
  (setq
   indent-tabs-mode nil
   tab-width 4
   c-basic-offset 4
   tempo-interactive t
   )
  ;;; key bindings
  (define-key jde-mode-map [\C-f1] 'jde-help-class)
  (define-key jde-mode-map [f6] 'jde-epn-toggle-main-test)
  (define-key jde-mode-map [\S-f8] 'jde-junit-run)
  (define-key jde-mode-map [f7] 'jde-find)
  (define-key jde-mode-map [f8] 'jde-build)
  (define-key jde-mode-map [f11] 'jde-epn-list-class-methods)
  (define-key jde-mode-map [\S-f5] 'jde-epn-refresh)
  (define-key jde-mode-map [?\M-?] 'jde-complete-in-line)
  (define-key jde-mode-map [?\C-\M-/] 'jde-complete-minibuf)
  (define-key jde-mode-map [?\C-c ?\C-v ?\C-i] 'jde-epn-organize-imports)
  (define-key jde-mode-map [?\M-.] 'jde-epn-open-class-source)
  (define-key jde-run-mode-map [?\M-.] 'jde-epn-open-class-source)
  (define-key compilation-mode-map [?\M-.] 'jde-epn-open-class-source)
  )

(add-hook 'jde-mode-hook 'my-jde-mode-hook)

