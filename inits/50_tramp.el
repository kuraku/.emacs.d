;; TRAMP

(require 'tramp)

;;auto-save をいいかんじに
(setq tramp-auto-save-directory temporary-file-directory)

;; for reuse test server
;; /reusetest-m:masuda@210.148.51.147:~/
(add-to-list 'tramp-methods 
			 `("reusetest-m" 
			   (tramp-login-program "plink") 
			   (tramp-copy-program "pscp") 
			   (tramp-remote-sh "/bin/sh") 
			   (tramp-login-args
				(("-l" "%u")
				 ("-P" "%p")
				 ("-ssh")
				 ("-t")
				 ("%h")
				 ("-i",(expand-file-name "~/.ssh/reuse_test_masuda_20170227.ppk"))
				 ("\"")
				 ("env 'TERM=dumb' 'PROMPT_COMMAND=' 'PS1=#$ '")
				 ("/bin/sh")
				 ("\"")))
			   (tramp-remote-shell "/bin/sh")
			   (tramp-remote-shell-login ("-l"))
			   (tramp-remote-shell-args ("-c"))
			   (tramp-default-port 22))
			 )

;; for reuse test server
;; /reusetest-c:cybird@210.148.51.147:~/
;; /reusetest-c::~/
(add-to-list 'tramp-methods 
			 `("reusetest-c" 
			   (tramp-login-program "plink") 
			   (tramp-copy-program "pscp") 
			   (tramp-remote-sh "/bin/sh") 
			   (tramp-login-args
				(("-l" "%u")
				 ("-P" "%p")
				 ("-ssh")
				 ("-t")
				 ("%h")
				 ("-i",(expand-file-name "~/.ssh/id_rsa_cybird_conv.ppk"))
				 ("\"")
				 ("env 'TERM=dumb' 'PROMPT_COMMAND=' 'PS1=#$ '")
				 ("/bin/sh")
				 ("\"")))
			   (tramp-remote-shell "/bin/sh")
			   (tramp-remote-shell-login ("-l"))
			   (tramp-remote-shell-args ("-c"))
			   (tramp-default-port 22))
			 )

;; for reuse real server
;; /reusereal:masuda@210.148.51.144:~/
(add-to-list 'tramp-methods 
			 `("reusereal" 
			   (tramp-login-program "plink") 
			   (tramp-copy-program "pscp") 
			   (tramp-remote-sh "/bin/sh") 
			   (tramp-login-args
				(("-l" "%u")
				 ("-P" "%p")
				 ("-ssh")
				 ("-t")
				 ("%h")
				 ("-i",(expand-file-name "~/.ssh/geoappli_201412.ppk"))
				 ("\"")
				 ("env 'TERM=dumb' 'PROMPT_COMMAND=' 'PS1=#$ '")
				 ("/bin/sh")
				 ("\"")))
			   (tramp-remote-shell "/bin/sh")
			   (tramp-remote-shell-login ("-l"))
			   (tramp-remote-shell-args ("-c"))
			   (tramp-default-port 22))
			 )

; *.devに接続するにはgw2を経由する。gw2にはuser: dev001でログインする。
;; reuse tool-server
;; /ssh:10.71.3.61:~/
(add-to-list 'tramp-default-proxies-alist
             '("10.71.3.61" nil "/reusereal:cybird@210.148.51.144:"))

;; /ssh:dev06.posren-new:~/
(add-to-list 'tramp-default-proxies-alist
             '("dev06\\..*" nil "/plink:masuda@zero.posren.com:"))
;; /ssh:dev07.posren-new:~/
(add-to-list 'tramp-default-proxies-alist
             '("dev07\\..*" nil "/plink:masuda@zero.posren.com:"))
;; /ssh:dev08.posren-new:~/
(add-to-list 'tramp-default-proxies-alist
             '("dev08\\..*" nil "/plink:masuda@zero.posren.com:"))


; ;; 08.06.23(mon)-12:34
; ;;(setq tramp-shell-prompt-pattern "^.*[#$%>] *")
; (require 'tramp)
; ;(setq tramp-default-method "plink")
; 
; ;;(setq tramp-default-method "pscp") ;;???
; (modify-coding-system-alist 'process "plink" 'euc-japan-unix)
; ;(modify-coding-system-alist 'process "plink" 'utf-8-unix)
; 
; ;; 11.03.01(tue)-11:31
; (setq-default tramp-debug-buffer t)
; 
; ;;cd /masuda@dev.posren.com:~/ で入れたけどなんか動かない
; 
; (setq vc-ignore-dir-regexp
;       (format "\\(%s\\)\\|\\(%s\\)"
; 			  vc-ignore-dir-regexp
; 			  tramp-file-name-regexp))
; 
; ;; proxy zero
; ;; /ssh:masuda@dev06.posren-new:/home/masuda
; ;; /sudo:dev06.posren-new:/usr/local/
; (add-to-list 'tramp-default-proxies-alist
;              '("^dev.*" nil "/plink:masuda@zero.posren.com:"))
;              ;;'(nil nil "/plink:masuda@zero.posren.com:"))
; 
; ;; /plink:masuda@192.168.1.56:
; ;; /sudo:root@192.168.1.56:
; (add-to-list 'tramp-default-proxies-alist
;              '(nil "\\`root\\'" "/plink:masuda@192.168.1.56:"))
; 
; ;(add-to-list 'tramp-default-proxies-alist '("localhost\\'" "\\`root\\'" nil))
