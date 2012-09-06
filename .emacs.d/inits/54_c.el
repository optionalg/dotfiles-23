;; Flymake
(defun flymake-c-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
         (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "gcc" (list "-Wall" "-Wextra" "-fsyntax-only" local-file))))
(push '("\\.c$" flymake-c-init) flymake-allowed-file-name-masks)

(add-hook 'c-mode-hook
          '(lambda ()
             (progn
               (flymake-mode t)
               (my-flymake-minor-mode))))

(defun flymake-cc-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
         (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "g++" (list "-Wall" "-Wextra" "-fsyntax-only" local-file))))
(push '("\\.cc$" flymake-cc-init) flymake-allowed-file-name-masks)

(add-hook 'c++-mode-hook
          '(lambda ()
             (progn
               (flymake-mode t)
               (my-flymake-minor-mode))))
