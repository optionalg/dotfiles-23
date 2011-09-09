;; manual: http://www.morishima.net/~naoto/elscreen-ja/
(add-to-list 'load-path "~/.emacs.d/vendor/elscreen")
;; (setq elscreen-prefix-key "\C-q")
(load "elscreen" "ElScreen" t)

;; from: http://d.hatena.ne.jp/nishikawasasaki/20110313/1300031344
(global-set-key (kbd "C-z C-k") 'elscreen-kill-screen-and-buffers) ; スクリーンとバッファをkill
(global-set-key [(C-tab)] 'elscreen-next) ; ブラウザみたいに
(global-set-key [(C-S-tab)] 'elscreen-previous) ; ブラウザみたいに その2

;; add-ons
(require 'elscreen-gf)
(require 'elscreen-dired)
(require 'elscreen-server)
(require 'elscreen-dnd)
(require 'elscreen-howm)
(require 'elscreen-color-theme)
