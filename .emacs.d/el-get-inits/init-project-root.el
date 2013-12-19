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
        ))
