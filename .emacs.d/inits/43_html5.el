;; this is html5 settings for nxml-mode

(eval-after-load "rng-loc"
  '(add-to-list 'rng-schema-locating-files "~/.emacs.d/vendor/html5-el/schemas.xml"))

(require 'whattf-dt)
