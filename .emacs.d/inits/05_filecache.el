;; ここで設定したディレクトリやファイルはパスを最初から指定しなくても補完できる。
(require 'filecache)
(file-cache-add-directory-list
 ;; ディレクトリを追加
 (list "~" "~/proj/"))
;; (file-cache-add-file-list
;;  ;; ファイルを追加
;;  (list "~/memo/memo.txt"))
(define-key minibuffer-local-completion-map "\C-c\C-i"
  'file-cache-minibuffer-complete)
