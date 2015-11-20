;;
;; restclient installtion
;;
(prelude-require-package 'restclient)
(require 'restclient)

;;
;; restclient company--auto-completion
;;
(prelude-require-package 'company-restclient)
(require 'company-restclient)
(add-to-list 'company-backends 'company-restclient)
