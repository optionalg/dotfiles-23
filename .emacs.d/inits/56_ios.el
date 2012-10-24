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

(defvar xcode:sdkver "6.0")
(defvar xcode:sdkpath "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer")
(defvar xcode:sdk (concat xcode:sdkpath "/SDKs/iPhoneSimulator" xcode:sdkver ".sdk"))

;; ;; 補完 auto-complete-mode 使用
;; (add-to-list 'load-path "~/.emacs.d/vendor/elisps")
;; (require 'ac-company)
;; ;; ac-company で company-xcode を有効にする
;; (ac-company-define-source ac-source-company-xcode company-xcode)
;; ;; objc-mode で補完候補を設定
;; (setq ac-modes (append ac-modes '(objc-mode)))
;; ;; hook
;; (add-hook 'objc-mode-hook
;;          (lambda ()
;;            ;(define-key objc-mode-map (kbd "\t") 'ac-complete)
;;            ;; XCode を利用した補完を有効にする
;;            ;(push 'ac-source-company-xcode ac-sources)
;;            (setq ac-sources '(ac-source-company-xcode))
;;            ;; C++ のキーワード補完をする Objective-C++ を利用する人だけ設定してください
;;            ;;(push 'ac-source-c++-keywords ac-sources)
;;          ))


;; auto-complete-mode
(setq ac-modes (append ac-modes '(objc-mode)))
(add-to-load-path "vendor/auto-complete-clang")
(setq ac-clang-flags (list "-D__IPHONE_OS_VERSION_MIN_REQUIRED=30200" "-x" "objective-c" "-std=gnu99" "-isysroot" xcode:sdkpath "-I." "-F.." "-fblocks"))
(require 'auto-complete-clang)
;; (setq ac-clang-prefix-header "stdafx.pch")
;; (setq ac-clang-flags '("-w" "-ferror-limit" "1"))
;(setq clang-completion-flags (list "-Wall" "-Wextra" "-fsyntax-only" "-ObjC" "-std=c99" "-isysroot" "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator6.0.sdk" "-I." "-F.." "-D__IPHONE_OS_VERSION_MIN_REQUIRED=30200"))
(add-hook 'objc-mode-hook
          (lambda () (setq ac-sources (append '(ac-source-clang
                                                ac-source-yasnippet
                                                ac-source-gtags)
                                              ac-sources))))
;; (add-hook 'objc-mode-hook
;;          (lambda ()
;;            ;(define-key objc-mode-map (kbd "\t") 'ac-complete)
;;            ;; XCode を利用した補完を有効にする
;;            ;(push 'ac-source-company-xcode ac-sources)
;;            (setq ac-sources '(ac-source-clang))
;;            ;; C++ のキーワード補完をする Objective-C++ を利用する人だけ設定してください
;;            ;;(push 'ac-source-c++-keywords ac-sources)
;;          ))

;; --- Obj-C switch between header and source ---

(defun objc-in-header-file ()
  (let* ((filename (buffer-file-name))
         (extension (car (last (split-string filename "\\.")))))
    (string= "h" extension)))

(defun objc-jump-to-extension (extension)
  (let* ((filename (buffer-file-name))
         (file-components (append (butlast (split-string filename
                                                         "\\."))
                                  (list extension))))
    (find-file (mapconcat 'identity file-components "."))))

;;; Assumes that Header and Source file are in same directory
(defun objc-jump-between-header-source ()
  (interactive)
  (if (objc-in-header-file)
      (objc-jump-to-extension "m")
    (objc-jump-to-extension "h")))

(defun objc-mode-customizations ()
  (define-key objc-mode-map (kbd "C-c t") 'objc-jump-between-header-source))

(add-hook 'objc-mode-hook 'objc-mode-customizations)

;; Build
(defun xcode:buildandrun ()
 (interactive)
 (do-applescript
  (format
   (concat
    "tell application \"Xcode\"\r"
    "    activate \r"
    "    tell application \"System Events\" \r"
    "        key code 35 using {command down} \r"
    "    end tell \r"
    "end tell \r"
    ))))

;; flymake エラー表示は参考程度に・・・
(require 'flymake)
;(defvar flymake-objc-compiler (concat xcode:sdkpath "/usr/bin/gcc"))
(defvar flymake-objc-compiler (executable-find "clang"))
;;(defvar flymake-objc-compile-default-options (list "-Wall" "-Wextra" "-fsyntax-only" "-x" "objective-c" "-std=c99"))
(defvar flymake-objc-compile-default-options (list "-D__IPHONE_OS_VERSION_MIN_REQUIRED=30200" "-fsyntax-only" "-fno-color-diagnostics" "-fobjc-arc" "-fblocks" "-Wreturn-type" "-Wparentheses" "-Wswitch" "-Wno-unused-parameter" "-Wunused-variable" "-Wunused-value" "-isysroot" xcode:sdk))
(defvar flymake-last-position nil)
(defcustom flymake-objc-compile-options '("-I.")
  "Compile option for objc check."
  :group 'flymake
  :type '(repeat (string)))

(defun flymake-objc-init ()
 (let* ((temp-file (flymake-init-create-temp-buffer-copy
                    'flymake-create-temp-inplace))
        (local-file (file-relative-name
                     temp-file
                     (file-name-directory buffer-file-name))))
   (list flymake-objc-compiler (append flymake-objc-compile-default-options flymake-objc-compile-options (list local-file)))))

(setq flymake-err-line-patterns
      (cons
       '("\\(.+\\):\\([0-9]+\\):\\([0-9]+\\): \\(.+\\)" 1 2 3 4)
       flymake-err-line-patterns))

(defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
  ;(setq flymake-check-was-interrupted t)
  ;; dirty hack.... clang command always exit with status code 1
  (setq exit-status 0))

(add-hook 'objc-mode-hook
         (lambda ()
           (ad-activate 'flymake-post-syntax-check)
           ;; 拡張子 m と h に対して flymake を有効にする設定 flymake-mode t の前に書く必要があります
           (push '("\\.m$" flymake-objc-init) flymake-allowed-file-name-masks)
           (push '("\\.h$" flymake-objc-init) flymake-allowed-file-name-masks)
           ;; 存在するファイルかつ書き込み可能ファイル時のみ flymake-mode を有効にします
           (if (and (not (null buffer-file-name)) (file-writable-p buffer-file-name))
               (flymake-mode t))))

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
