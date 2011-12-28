(if (string= system-name "ubuntu")
    (progn
      (add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mew")
      (autoload 'mew "mew" nil t)
      (autoload 'mew-send "mew" nil t)
      (define-key global-map [(super m)] 'mew)
      (define-key global-map [(super n)] 'mew-send)

      ;; Optional setup (Read Mail menu for Emacs 21):
      (if (boundp 'read-mail-command)
          (setq read-mail-command 'mew))

      ;; Optional setup (e.g. C-xm for sending a message):
      (autoload 'mew-user-agent-compose "mew" nil t)
      (if (boundp 'mail-user-agent)
          (setq mail-user-agent 'mew-user-agent)
          (setq mew-use-header-veil nil))
      (if (fboundp 'define-mail-user-agent)
          (define-mail-user-agent
            'mew-user-agent
            'mew-user-agent-compose
            'mew-draft-send-message
            'mew-draft-kill
            'mew-send-hook))
      )
  )
