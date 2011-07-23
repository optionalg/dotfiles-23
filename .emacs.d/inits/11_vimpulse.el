(add-to-list 'load-path "~/.emacs.d/vendor/vimpulse")
(require 'vimpulse)

;; 物理行移動を基本にする
(vimpulse-map "j" 'next-line)
(vimpulse-map "k" 'previous-line)
(vimpulse-map [?\C-n] 'viper-next-line)
(vimpulse-map [?\C-p] 'viper-previous-line)

;; h l は行頭/行末を超えられるようにする
(vimpulse-map "h" 'backward-char)
(vimpulse-map "l" 'forward-char)

;; deleteと backspaceキーは文字削除
(vimpulse-map [delete] 'vimpulse-delete)
(vimpulse-map [backspace] 'backward-delete-char-untabify)
