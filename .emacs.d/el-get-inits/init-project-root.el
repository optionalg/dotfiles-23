(setq project-roots
      `(
        ("Django project"
         :root-contains-files ("manage.py")
         :filename-regex ,(regexify-ext-list '(py html css js sh))
         :exclude-paths '("contrib"))
        ("Ruby Project"
         :root-contains-files ("Gemfile")
         :filename-regex ,(regexify-ext-list '(rb js coffee css sass 
                                                  erb slim haml
                                                  sh
                                                  ))
         )
        ("Emacs Settings"
         :root-contains-files ("init.el")
         :filename-regex ,(regexify-ext-list '(el sh))
         )
        ("Git Repositry"
         :root-contains-files (".git")
         )
        ))

(defmacro with-project-root-or-default (&rest body)
  `(if (project-root-buffer-in-project (current-buffer))
       (with-project-root ,@body)
     ,@body
  ))
