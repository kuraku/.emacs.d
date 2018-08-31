;;(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))

;; 2016-11-14 mon 12:51
(add-to-list 'auto-mode-alist '("\\.tpl$" . php-mode))

(add-hook 'php-mode-hook (flymake-mode t))
