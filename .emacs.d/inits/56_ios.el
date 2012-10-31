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

;; auto-complete-mode
(setq ac-modes (append ac-modes '(objc-mode)))
(add-to-load-path "vendor/auto-complete-clang")
(setq ac-clang-flags (list "-D__IPHONE_OS_VERSION_MIN_REQUIRED=30200" "-x" "objective-c" "-std=gnu99" "-isysroot" xcode:sdk "-I." "-F.." "-fblocks"))
(require 'auto-complete-clang)
;; (setq ac-clang-prefix-header "stdafx.pch")
;; (setq ac-clang-flags '("-w" "-ferror-limit" "1"))
;(setq clang-completion-flags (list "-Wall" "-Wextra" "-fsyntax-only" "-ObjC" "-std=c99" "-isysroot" "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator6.0.sdk" "-I." "-F.." "-D__IPHONE_OS_VERSION_MIN_REQUIRED=30200"))
(add-hook 'objc-mode-hook
          (lambda () (setq ac-sources (append '(ac-source-clang
                                                ac-source-yasnippet
                                                ac-source-gtags)
                                              ac-sources))))


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

;; Documentation Search
(defun xcode:searchdoc ()
  (interactive)
  (let ((term (region-string-or-currnet-word)))
    (do-applescript
     (format
      (concat
       "tell application \"System Events\" \r"
       "  tell process \"Xcode\" \r"
                                        ; -- Activate Xcode if necessary
       "    set frontmost to true \r"
                                        ;    -- Open the Organizer
       "    keystroke \"2\" using {shift down, command down} \r"
       "    set organizer to window 1 \r"
                                        ;    -- Select the Documentation panel if it's not already selected
       "    if the title of organizer is not \"Organizer - Documentation\" then \r"
       "      click button \"Documentation\" of tool bar 1 of organizer \r"
       "      delay 0.1 \r"
       "      set organizer to window 1 \r"
       "    end if \r"
                                        ;    -- Move focus to the search field
       "    set searchField to text field 1 of splitter group 1 of organizer \r"
       "    set searchField's focused to true \r"
       "    set value of searchField to \"" term "\" \r"
       "  end tell \r"
       "end tell \r"
       )))))

(defun objc-mode-customizations ()
  (define-key objc-mode-map (kbd "C-c t") 'objc-jump-between-header-source)
  (define-key objc-mode-map (kbd "C-c r") 'xcode:searchdoc))
(add-hook 'objc-mode-hook 'objc-mode-customizations)

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
