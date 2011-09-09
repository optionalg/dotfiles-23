(setq gnus-use-mailcrypt nil) ;; mailcrypt は使わない
(setq gnus-use-sc nil) ;; super-cite も使わない
(load "gnus-setup") ;; 必須
(setq mail-user-agent 'gnus-user-agent)

;; gnus のディレクトリやファイルを設定
;; デフォルトで問題なければ以下 5 行の設定は必要ない
(setq nnshimbun-directory (expand-file-name "~/News/shimbun/"))
(setq gnus-home-directory (expand-file-name "~/"))
(setq gnus-directory (expand-file-name "~/News/"))
(setq message-directory (expand-file-name "~/News/"))
(setq nnmail-message-id-cache-file (expand-file-name "~/News/.nnmail-cache"))

;;日本語の添付ファイル名を正しく表示
;;これがないと化けます．
;; (defvar my-mime-filename-coding-system-for-decode
;;   '(iso-2022-jp japanese-shift-jis japanese-iso-8bit))
;; (defun my-mime-decode-filename (filename)
;;   (let ((rest (eword-decode-string filename)))
;;     (or (when (and my-mime-filename-coding-system-for-decode
;;                    (string= rest filename))
;;           (let ((dcs (mapcar (function coding-system-base)
;;                              (detect-coding-string filename))))
;;             (unless (memq 'emacs-mule dcs)
;;               (let ((pcs my-mime-filename-coding-system-for-decode))
;;                 (while pcs
;;                   (if (memq (coding-system-base (car pcs)) dcs)
;;                       (setq rest (decode-coding-string filename (car pcs))
;;                             pcs nil)
;;                     (setq pcs (cdr pcs))))))))
;;         rest)))
;; (eval-after-load "mime"
;;   '(defadvice mime-entity-filename (after eword-decode-for-broken-MUA activate)
;;      "Decode encoded file name for BROKEN MUA."
;;      (when (stringp ad-return-value)
;;        (setq ad-return-value (my-mime-decode-filename ad-return-value)))))

;;html メールを読まないなら以下を設定 (コメントをはずす)
;;ただし
;; w3 か w3m がインストールされていない時には nil にします
;;(setq mime-setup-enable-inline-html nil)
;; plain/text が附属していない時のみ
;;(eval-after-load "semi-setup"
;;   '(progn
;;      (set-alist 'mime-view-type-subtype-score-alist '(text . plain) 10)
;;      ))

;; html メールは w3m (11.4 テキストブラウザ - w3m) で読む
;; w3m がインストールされている時のみコメントをはずす
;;(eval-after-load "mime-view"
;;   '(progn
;;      (autoload 'mime-w3m-preview-text/html "mime-w3m")
;;      (ctree-set-calist-strictly
;;       'mime-preview-condition
;;       '((type . text)
;;         (subtype . html)
;;         (body . visible)
;;         (body-presentation-method . mime-w3m-preview-text/html)))
;;      (set-alist 'mime-view-type-subtype-score-alist
;;                 '(text . html) 3)))

;;オフラインでもメール/ ニュースを読み書きしたいので以下を設定
;;設定ファイルは別のフォルダへ．デフォルトは ~/.gnus-offline.el
;; (setq gnus-offline-setting-file "~/data/.gnus-offline.el") ;; なくてもよい
;; (load "gnus-ofsetup-setup-for-offline)
;; (load gnus-offline-setting-file)
