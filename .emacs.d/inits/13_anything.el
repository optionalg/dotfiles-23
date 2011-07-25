(add-to-list 'load-path "~/.emacs.d/vendor/anything-config")
(require 'anything-startup)

(require 'anything-config)
(add-to-list 'anything-sources 'anything-c-source-emacs-commands)

(define-key global-map [(super a)] 'anything)

(setq anything-idle-delay 0.4) ; 候補を作って描写するまでのタイムラグ。デフォルトで 0.3
(setq anything-input-idle-delay 0.3) ; 文字列を入力してから検索するまでのタイムラグ。デフォルトで 0
(setq anything-candidate-number-limit 100) ; 表示する最大候補数。デフォルトで 50
