;; fonts
;; Mac
(when (and
       (>= emacs-major-version 23)
       window-system
       (eq system-type 'darwin))
  (set-face-attribute 'default nil
                      ;; :family "monaco"
                      :family "menlo"
                      :height 120)
  (set-fontset-font
   (frame-parameter nil 'font)
   'japanese-jisx0208
   '("Hiragino Maru Gothic Pro" . "iso10646-1"))
  (set-fontset-font
   (frame-parameter nil 'font)
   'japanese-jisx0212
   '("Hiragino Maru Gothic Pro" . "iso10646-1"))
  (set-fontset-font
   (frame-parameter nil 'font)
   'mule-unicode-0100-24ff
   '("monaco" . "iso10646-1"))
  (setq face-font-rescale-alist
        '(("^-apple-hiragino.*" . 1.1)
          (".*osaka-bold.*" . 1.2)
          (".*osaka-medium.*" . 1.2)
          (".*courier-bold-.*-mac-roman" . 1.0)
          (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
          (".*monaco-bold-.*-mac-roman" . 0.9)
          ("-cdac$" . 1.3))))

;; Ubuntu
(when (and
       (>= emacs-major-version 23)
       window-system
       (string= system-name 'ubuntu))
  (set-face-attribute 'default nil
                      :family "ricty"
                      :height 110)
  ;; (set-default-font "ricty-11:spacing=1")
  ;; (set-face-font 'variable-pitch "ricty-11:spacing=1")
  (set-fontset-font (frame-parameter nil 'font)
                    'japanese-jisx0208
                    '("ricty" . "unicode-bmp")))
