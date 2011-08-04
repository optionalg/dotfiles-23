;; 設定されてないように見える・・ → autoload が失敗
(setq load-path (cons (expand-file-name "~/.emacs.d/vendor/elisps") load-path))

(require 'auto-save-buffers)
(run-with-idle-timer 5 t 'auto-save-buffers)

(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)
(setq anything-samewindow nil)
(push '("*anything*" :height 20) popwin:special-display-config)

(require 'recentf)
(setq recentf-max-saved-items 1000)
(recentf-mode 1)

(autoload 'ac-mode "~/.emacs.d/vendor/elisps/ac-mode" "Minor mode for advanced completion." t nil)
(ac-mode) ;; enable

(autoload 'term-toggle "~/.emacs.d/vendor/elisps/term-toggle"
  "Toggles between the *terminal* buffer and whatever buffer you are editing." t)
(autoload 'term-toggle-cd "~/.emacs.d/vendor/elisps/term-toggle"
  "Pops up a shell-buffer and insert a \"cd <file-dir>\" command." t)
(global-set-key [M-f1] 'term-toggle)
(global-set-key (kbd "C-x t") 'term-toggle-cd)
