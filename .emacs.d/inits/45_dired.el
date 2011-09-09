(load "dired-x")

;; (define-key dired-mode-map "v" 'dired-x-find-file)
;; (define-key dired-mode-map "V" 'dired-view-file)
;; (define-key dired-mode-map "j" 'dired-next-line)
;; (define-key dired-mode-map "J" 'dired-goto-file)
;; (define-key dired-mode-map "k" 'dired-previous-line)
;; (define-key dired-mode-map "K" 'dired-do-kill-lines)
(define-key dired-mode-map "e" 'wdired-change-to-wdired-mode)

;; A way to activate and deactivate vi-state when toggling the wdired-mode
(eval-after-load "wdired"
  '(progn
     (eval-after-load "viper"
       '(progn
          (defadvice wdired-change-to-wdired-mode (after viper activate)
            (unless (eq viper-current-state 'emacs-state)
              (viper-change-state 'vi-state)))
          (defadvice wdired-finish-edit (after viper activate)
            (unless (eq viper-current-state 'emacs-state)
              (viper-change-state-to-vi)) ; back to normal state
            (viper-modify-major-mode    ; back to dired map
             'dired-mode 'vi-state dired-mode-map))))))
