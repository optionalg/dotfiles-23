;; php-mode
(require 'php-mode)

(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(setq php-manual-path "~/.emacs.d/vendor/php-mode-1.5.0/php-manual/")
(setq php-manual-url "http://www.php.net/manual/ja/")

(setq php-mode-force-pear t)
