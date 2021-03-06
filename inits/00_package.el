;; package for emacs24

(require 'package)

;;(add-to-list 'package-archives
;;             '("melpa" . "https://melpa.org/packages/"))
;;
;;(add-to-list 'package-archives
;;             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

; package-archivesに追加
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))


; ;; MELPAを追加
; (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
;  
; ;; MELPA-stableを追加
; (add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
;  
; ;; Marmaladeを追加
; (add-to-list 'package-archives  '("marmalade" . "http://marmalade-repo.org/packages/") t)
;  
; ;; Orgを追加
; (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
 
;; 初期化
(package-initialize)
