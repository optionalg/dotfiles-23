;;; utilities ;;;
(defun exec-shell-command-sync (command &rest args)
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

