;;; platforms ;;;
(setq darwin-p  (eq system-type 'darwin)
      ns-p      (eq window-system 'ns)
      linux-p   (eq system-type 'gnu/linux))


;;; utilities ;;;
(defun add-to-load-path (path-from-emacs-directory)
  "Add path to load-path.
\"path\" will be interpreted as an entry in user-emacs-directory."
  (setq load-path
        (cons (concat user-emacs-directory path-from-emacs-directory)
              load-path)))

(defun exec-shell-command-sync (command &rest args)
  "Execute command in the shell, wait command to exit,
return output of the command in string format."
  (let (ret
         (process
          (apply 'start-process-shell-command "exec" nil command args)))
    (set-process-filter
     process
     '(lambda (process output)
        (setq ret (cons output ret))
        ))
    (while (not (equalp (process-status process) 'exit))
      (sleep-for 0 10))
    (car ret)))

(defun region-string-or-currnet-word ()
  "Get region string if region is set, else get current word."
  (if mark-active
      (buffer-substring (region-beginning) (region-end))
    (current-word)))

(defun join (lst &optional delim)
  (mapconcat 'identity lst
             (if (null delim) "" delim)))

(defun my/filter (condp lst)
  (delq nil
        (mapcar (lambda (x) (and (funcall condp x) x)) lst)))
