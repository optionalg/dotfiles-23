;; (setq-default c-basic-offset 2)

;; (when (load "js2" t)
;;   (setq js2-cleanup-whitespace nil
;;         js2-mirror-mode nil
;;         js2-mode-show-strict-warnings nil
;;         js2-bounce-indent-flag nil
;;         js2-auto-indent-p t
;;         )

;;   (defun indent-and-back-to-indentation ()
;;     (interactive)
;;     (indent-for-tab-command)
;;     (let ((point-of-indentation
;;            (save-excursion
;;              (back-to-indentation)
;;              (point))))
;;       (skip-chars-forward "\s " point-of-indentation)))
;;   (define-key js2-mode-map "\C-i" 'indent-and-back-to-indentation)

;;   (define-key js2-mode-map "\C-m" nil))

;; (add-hook 'js2-mode-hook
;;           '(lambda ()
;;              (setq js2-cleanup-whitespace nil
;;                    js2-mirror-mode nil
;;                    js2-bounce-indent-flag nil
;;                    js2-mode-show-parse-errors nil
;;                    js2-mode-escape-quotes nil
;;                    js2-mode-show-strict-warnings nil
;;                    ;; js2-strict-missing-semi-warning nil
;;                    ;; js2-strict-inconsistent-return-warning nil
;;                    ;; js2-strict-trailing-comma-warning nil
;;                    ;; js2-strict-cond-assign-warning nil
;;                    ;; js2-strict-var-redeclaration-warning nil
;;                    ;; js2-strict-var-hides-function-arg-warning nil
;;                    ; js2-skip-preprocessor-directives t
;;                    ;; js2-include-browser-externs t
;;                    ;; js2-highlight-external-variables nil
;;                    ;; js2-idle-timer-delay 0.4
;;                    ;; js2-dynamic-idle-timer-adjust t
;;                    )
;;              (defun indent-and-back-to-indentation ()
;;                (interactive)
;;                (indent-for-tab-command)
;;                (let ((point-of-indentation
;;                       (save-excursion
;;                         (back-to-indentation)
;;                         (point))))
;;                  (skip-chars-forward "\s " point-of-indentation)))
;;              (define-key js2-mode-map "\C-i" 'indent-and-back-to-indentation)
;;              (define-key js2-mode-map "\C-m" nil)))

;; (autoload 'js2-mode "js2" nil t)

;; (add-to-list 'auto-mode-alist '("\\.\\(js\\|json\\)$" . js2-mode))

(add-hook 'js-mode-hook
          '(lambda ()
             (setq js-indent-level 2)))

;; flymake for javascript using jshint
(defun flymake-js-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
         (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "jshint" (list local-file "--config" (file-truename "~/.jshint-config.json")))))
(defun flymake-js-load ()
  (interactive)
  (defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
    (setq flymake-check-was-interrupted t))
  (ad-activate 'flymake-post-syntax-check)
  (setq flymake-err-line-patterns
        (cons '("^\\([^:]+\\): *line *\\([[:digit:]]+\\), *col *\\([[:digit:]]+\\), *\\(.*\\)"
                1 2 3 4)
              flymake-err-line-patterns))
  (flymake-mode t))

(add-to-list 'flymake-allowed-file-name-masks '("\\.\\(js\\|json\\)\\'" flymake-js-init))
;; (add-hook 'js-mode-hook '(lambda () (flymake-js-load)))
;; (add-hook 'js-mode-hook '(lambda () (my-flymake-minor-mode))) ;; keybindings for flymake
;; go along with multi-web-mode
(add-hook 'find-file-hook '(lambda ()
                             (when (equal (file-name-extension (buffer-file-name)) "js")
                               (flymake-js-load)
                               (my-flymake-minor-mode))))

;; for imenu
;; from: http://dev.ariel-networks.com/Members/matsuyama/imenu/
;; 識別子の正規表現
(defvar javascript-identifier-regexp "[a-zA-Z0-9.$_]+")

;; } までの class のメソッドを列挙する関数
(defun javascript-imenu-create-method-index-1 (class bound)
  (let (result)
    (while (re-search-forward (format "^ +\\(\%s\\): *function" javascript-identifier-regexp) bound t)
      (push (cons (format "%s.%s" class (match-string 1)) (match-beginning 1)) result))
    (nreverse result)))

;; メソッドのインデックスを作成する関数
(defun javascript-imenu-create-method-index ()
  (cons "Methods"
        (let (result)
          ;; $name = Class.create
          ;; $name = Object.extend
          ;; Object.extend($name,
          ;; $name = {
          ;; をクラスあるいはオブジェクトとする
          (dolist (pattern (list (format "\\b\\(%s\\) *= *Class\.create" javascript-identifier-regexp)
                                 (format "\\b\\([A-Z]%s\\) *= *Object.extend(%s"
                                         javascript-identifier-regexp
                                         javascript-identifier-regexp)
                                 (format "^ *Object.extend(\\([A-Z]%s\\)" javascript-identifier-regexp)
                                 (format "\\b\\([A-Z]%s\\) *= *{" javascript-identifier-regexp)))
            (goto-char (point-min))
            (while (re-search-forward pattern (point-max) t)
              (save-excursion
                (condition-case nil
                    ;; { を探す
                    (let ((class (replace-regexp-in-string "\.prototype$" "" (match-string 1))) ;; .prototype はとっておく
                          (try 3))
                      (if (eq (char-after) ?\()
                          (down-list))
                      (if (eq (char-before) ?{)
                          (backward-up-list))
                      (forward-list)
                      (while (and (> try 0) (not (eq (char-before) ?})))
                        (forward-list)
                        (decf try))
                      (if (eq (char-before) ?}) ;; } を見つけたら
                          (let ((bound (point)))
                            (backward-list)
                            ;; メソッドを抽出してインデックスに追加
                            (setq result (append result (javascript-imenu-create-method-index-1 class bound))))))
                  (error nil)))))
          ;; 重複を削除しておく
          (delete-duplicates result :test (lambda (a b) (= (cdr a) (cdr b)))))))

(defun javascript-imenu-create-function-index ()
  (cons "Functions"
         (let (result)
           (dolist (pattern (list
                             (format "\\b\\(%s\\) *= *function" javascript-identifier-regexp)
                             (format "function \\(%s\\)" javascript-identifier-regexp)))
             (goto-char (point-min))
             (while (re-search-forward pattern (point-max) t)
               (push (cons (match-string 1) (match-beginning 1)) result)))
           (nreverse result))))

(defun javascript-imenu-create-index ()
  (list
   (javascript-imenu-create-function-index)
   (javascript-imenu-create-method-index)))

;; donot use semantic one
(add-hook 'js-mode-hook
          (lambda ()
            (setq imenu-create-index-function 'javascript-imenu-create-index)
            (imenu-add-menubar-index)
            ))

