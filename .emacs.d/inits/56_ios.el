(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@implementation" . objc-mode))
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@interface" . objc-mode))
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@protocol" . objc-mode))

(setq ff-other-file-alist
     '(("\\.mm?$" (".h"))
       ("\\.cc$"  (".hh" ".h"))
       ("\\.hh$"  (".cc" ".C"))

       ("\\.c$"   (".h"))
       ("\\.h$"   (".c" ".cc" ".C" ".CC" ".cxx" ".cpp" ".m" ".mm"))

       ("\\.C$"   (".H"  ".hh" ".h"))
       ("\\.H$"   (".C"  ".CC"))

       ("\\.CC$"  (".HH" ".H"  ".hh" ".h"))
       ("\\.HH$"  (".CC"))

       ("\\.cxx$" (".hh" ".h"))
       ("\\.cpp$" (".hpp" ".hh" ".h"))

       ("\\.hpp$" (".cpp" ".c"))))
(add-hook 'objc-mode-hook
         (lambda ()
           (define-key c-mode-base-map (kbd "C-c o") 'ff-find-other-file)
         ))

;; 補完 auto-complete-mode 使用
(add-to-list 'load-path "~/.emacs.d/vendor/elisps")
(require 'ac-company)
;; ac-company で company-xcode を有効にする
(ac-company-define-source ac-source-company-xcode company-xcode)
;; objc-mode で補完候補を設定
(setq ac-modes (append ac-modes '(objc-mode)))
;; hook
(add-hook 'objc-mode-hook
         (lambda ()
           (define-key objc-mode-map (kbd "\t") 'ac-complete)
           ;; XCode を利用した補完を有効にする
           (push 'ac-source-company-xcode ac-sources)
           ;; C++ のキーワード補完をする Objective-C++ を利用する人だけ設定してください
           ;;(push 'ac-source-c++-keywords ac-sources)
         ))


;; flymake
;; (require 'flymake)
;; (defvar xcode:sdkver "5.1")
;; (defvar xcode:sdkpath "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer")
;; (defvar xcode:sdk (concat xcode:sdkpath "/SDKs/iPhoneSimulator" xcode:sdkver ".sdk"))
;; (defvar flymake-objc-compiler (concat xcode:sdkpath "/usr/bin/gcc"))
;; ;;(defvar flymake-objc-compiler (concat xcode:sdkpath "/usr/bin/clang"))
;; ;;(defvar flymake-objc-compile-default-options (list "-Wall" "-Wextra" "-fsyntax-only" "-x" "objective-c" "-std=c99"))
;; (defvar flymake-objc-compile-default-options (list "-Wall" "-Wextra" "-fsyntax-only" "-ObjC" "-std=c99" "-isysroot" xcode:sdk))
;; (defvar flymake-last-position nil)
;; (defcustom flymake-objc-compile-options '("-I." "-F../")
;;   "Compile option for objc check."
;;   :group 'flymake
;;   :type '(repeat (string)))

;; (defun flymake-objc-init ()
;;  (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                     'flymake-create-temp-inplace))
;;         (local-file (file-relative-name
;;                      temp-file
;;                      (file-name-directory buffer-file-name))))
;;    (list flymake-objc-compiler (append flymake-objc-compile-default-options flymake-objc-compile-options (list local-file)))))

;; (add-hook 'objc-mode-hook
;;          (lambda ()
;;            ;; 拡張子 m と h に対して flymake を有効にする設定 flymake-mode t の前に書く必要があります
;;            (push '("\\.m$" flymake-objc-init) flymake-allowed-file-name-masks)
;;            (push '("\\.h$" flymake-objc-init) flymake-allowed-file-name-masks)
;;            ;; 存在するファイルかつ書き込み可能ファイル時のみ flymake-mode を有効にします
;;            (if (and (not (null buffer-file-name)) (file-writable-p buffer-file-name))
;;                (flymake-mode t))))

;; Use Makefile
;; もともとのパターンにマッチしなかったので追加
;; (setq flymake-err-line-patterns
;;       (cons
;;        '("\\(.+\\):\\([0-9]+\\):\\([0-9]+\\): \\(.+\\)" 1 2 3 4)
;;        flymake-err-line-patterns))

;; (add-hook 'objc-mode-hook
;;           (lambda ()
;;             (push '("\\.m$" flymake-simple-make-init) flymake-allowed-file-name-masks)
;;             (push '("\\.h$" flymake-simple-make-init) flymake-allowed-file-name-masks)
;;             (flymake-mode t)))

; Makefile for iOS
;; CLANG	    = /usr/bin/clang
;; ARCH	    = -arch armv7
;; SDK	    = -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator5.1.sdk
;; OS_VER_MIN  = -miphoneos-version-min=4.3
;; OPTIONS     = -fsyntax-only -x objective-c -std=gnu99
;; WARNINGS    = -Wreturn-type -Wparentheses -Wswitch -Wno-unused-parameter -Wunused-variable -Wunused-value
;; INCLUDES    = -I.
;; FRAMEWORKS  = -F../

;; check-syntax:
;; 	$(CLANG) $(OPTIONS) $(ARCH) $(WARNINGS) $(SDK) $(OS_VER_MIN) $(INCLUDES) $(FRAMEWORKS) ${CHK_SOURCES}
