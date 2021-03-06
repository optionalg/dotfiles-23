;; ibus
(when (equal system-name "ubuntu")
  (add-to-list 'load-path "/usr/share/emacs23/site-lisp/ibus-el")
  (require 'ibus)
  (add-hook 'after-init-hook 'ibus-mode-on)

  ;; C-SPC は Set Mark に使う
  (ibus-define-common-key ?\C-\s nil)
  ;; C-/ は Undo に使う
  (ibus-define-common-key ?\C-/ nil)
  (ibus-define-common-key ?\C-p nil)
  (ibus-define-common-key ?\C-n nil)
  ;; IBusの状態によってカーソル色を変化させる
  (setq ibus-cursor-color '("yellow" "limegreen" "limegreen"))
  ;; C-; で半角英数モードをトグルする(iBus 側の設定も必要）
  (ibus-define-common-key (kbd "C-;") t)
  ;; すべてのバッファで入力状態を共有
  ;; (setq ibus-mode-local nil)
  ;; isearch-mode 検索中にカーソル形状が変わるように
  (setq ibus-isearch-cursor-type 'hollow)
  ;; カーソル位置で予測候補ウィンドウを表示
  (setq ibus-prediction-window-position t)
  )

;; Mac
;; Disable cause its unstable
;; (when (equal system-type 'darwin)
;;   ;;(setq default-input-method "MacOSX")
;;   ;; Override default language settings for utf-8
;;   (set-language-info-alist
;;    "UTF-8" `((coding-system utf-8)
;;              (coding-priority utf-8)
;;              (charset unicode-bmp unicode)
;;              (input-method . "MacOSX") ; maybe not the best choice
;;              (documentation . "\
;; This language environment is a generic one for the Unicode character set
;; encoded in UTF-8."))
;;    nil)
;;   (mac-set-input-method-parameter "com.google.inputmethod.Japanese.base" 'title "あ")
;;   ;; (mac-set-input-method-parameter "com.google.inputmethod.Japanese.base" 'cursor-type 'hbar)
;;   (mac-set-input-method-parameter "com.google.inputmethod.Japanese.base" 'cursor-color "limegreen")
;;   (add-hook 'minibuffer-setup-hook 'mac-change-language-to-us)
;;   ) 
