;; -*- emacs-list -*-
;; @@ 
;; Time-stamp: <2017-05-23 17:57 akira.masuda>

(add-hook 'python-mode-hook
		  '(lambda()
			 (setq indent-tabs-mode nil)
			 (setq indent-level 4)
			 (setq python-indent 4)
			 (setq tab-width 4)))
