;; package for emacs24

(require 'package)

;;(add-to-list 'package-archives
;;             '("melpa" . "https://melpa.org/packages/"))
;;
;;(add-to-list 'package-archives
;;             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

; package-archives‚É’Ç‰Á
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))


; ;; MELPA‚ğ’Ç‰Á
; (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
;  
; ;; MELPA-stable‚ğ’Ç‰Á
; (add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
;  
; ;; Marmalade‚ğ’Ç‰Á
; (add-to-list 'package-archives  '("marmalade" . "http://marmalade-repo.org/packages/") t)
;  
; ;; Org‚ğ’Ç‰Á
; (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
 
;; ‰Šú‰»
(package-initialize)
