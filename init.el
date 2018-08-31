;;; -*- emacs-lisp -*-
;;     Time-stamp: <2018-04-05 15:23 masuda>
;; updated 12.10.17(wed)-11:31 in posren Emacs24
;; moved .emacs.el -> .emacs.d/init.el

;;2014-05-16 fri 16:08
;(server-start)

;; @ CD home

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(cd "~")

;; Version var
(defvar is_emacs23 (equal emacs-major-version 23))
(defvar is_emacs24 (equal emacs-major-version 24))
(defvar is_emacs25 (equal emacs-major-version 25))
(defvar is_window-sys (not (eq (symbol-value 'window-system) nil)))
(defvar is_mac (or (eq window-system 'mac) (featurep 'ns)))
;;(defvar is_carbon (and is_mac is_emacs22 is_window-sys))
;;(defvar is_cocoa (and is_mac is_emacs23 is_window-sys))
(defvar is_inline-patch (eq (boundp 'mac-input-method-parameters) t))
(defvar is_darwin (eq system-type 'darwin))
(defvar is_cygwin (eq system-type 'cygwin))

(defvar ma:emacs-version
  (concat (int-to-string emacs-major-version)
		  "." (int-to-string emacs-minor-version)))

(defvar emacs-version-XX.X
  (concat (int-to-string emacs-major-version)
		  "." (int-to-string emacs-minor-version)))

;; old path
;; load-path
;;(setq auto-install-directory (expand-file-name "~/.emacs.d/auto-install/"))
;;(add-to-list 'load-path auto-install-directory)

;; elisp directory
(let ((dir (expand-file-name "~/.emacs.d/elisp")))
    (if (member dir load-path) nil
	  ;;(setq load-path (cons dir load-path))
	  (add-to-list 'load-path dir)
	  (let ((default-directory dir))
		(load (expand-file-name "subdirs.el") t t t))))

;; elpa dir
(let ((dir (expand-file-name "~/.emacs.d/elpa")))
    (if (member dir load-path) nil
	  (add-to-list 'load-path dir)
	  (let ((default-directory dir))
		(load (expand-file-name "subdirs.el") t t t))))

;; init-loader
(when (locate-library "init-loader")
  (let ((init-dir "~/.emacs.d/inits"))
 	(require 'init-loader)
 	(if (and (featurep 'init-loader) (file-exists-p init-dir))
	    (init-loader-load init-dir))))

;; @ load init file
(setq my-emacs-init "ntemacs.el")

;; .ntemacsXX.el
(cond ((and is_emacs23 is_window-sys) (setq my-emacs-init "~/.emacs.d/ntemacs23.el"))
      ((and is_emacs24 is_window-sys) (setq my-emacs-init "~/.emacs.d/ntemacs24.el"))
      ((and is_emacs25 is_window-sys) (setq my-emacs-init "~/.emacs.d/ntemacs25.el")) ;; emacs25
      ((and is_emacs24 is_cygwin) (setq my-emacs-init "~/.emacs.d/cygwin-emacs24.el")) )

;; elc check
;;(setq my-init-el "~/.ntemacs23.el")
(if (file-exists-p (concat my-emacs-init "c"))
	(progn
	  (if (file-newer-than-file-p my-emacs-init (concat my-emacs-init "c"))
		  (warn (concat my-emacs-init "c is OLD!!!!!")))))

;; load ntemacsXX.el or .elc
(if (file-exists-p my-emacs-init)
	(load (file-name-sans-extension my-emacs-init)))

;; @ auto set
(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(when (memq window-system '(mac ns))
  (global-set-key [s-mouse-1] 'browse-url-at-mouse)
  (let* ((size 14)
	 (jpfont "Hiragino Maru Gothic ProN")
	 (asciifont "Monaco")
	 (h (* size 10)))
    (set-face-attribute 'default nil :family asciifont :height h)
    (set-fontset-font t 'katakana-jisx0201 jpfont)
    (set-fontset-font t 'japanese-jisx0208 jpfont)
    (set-fontset-font t 'japanese-jisx0212 jpfont)
    (set-fontset-font t 'japanese-jisx0213-1 jpfont)
    (set-fontset-font t 'japanese-jisx0213-2 jpfont)
    (set-fontset-font t '(#x0080 . #x024F) asciifont))
  (setq face-font-rescale-alist
	'(("^-apple-hiragino.*" . 1.2)
	  (".*-Hiragino Maru Gothic ProN-.*" . 1.2)
	  (".*osaka-bold.*" . 1.2)
	  (".*osaka-medium.*" . 1.2)
	  (".*courier-bold-.*-mac-roman" . 1.0)
	  (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
	  (".*monaco-bold-.*-mac-roman" . 0.9)
	  ("-cdac$" . 1.3)))

;; end of file


;;
;; @@ wrote by emacs
;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(custom-enabled-themes (quote (tsdh-dark)))
 '(helm-command-prefix-key "C-;")
 '(initial-frame-alist
   (quote
	((width . 100)
	 (height . 54)
	 (top . 10)
	 (left . 20)
	 (cursor-color . "LimeGreen")
	 (background-color . "black")
	 (foreground-color . "white")
	 (vertical-scroll-bars))))
 '(package-selected-packages
   (quote
	(flycheck flymake-php ssh mastodon zoom-window sequential-command dirtree e2wm magit-popup sr-speedbar magit helm helm-core helm-descbinds helm-package async popwin php-mode w3m vimrc-mode use-package twittering-mode tabbar-ruler smex s psvn org-toodledo org init-loader google-translate git-rebase-mode git-commit-mode elscreen dsvn direx ddskk color-theme-solarized color-moccur bm auto-complete auto-compile all))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "gray20" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 98 :width normal :foundry "outline" :family "M+2VM+IPAG circle"))))
 '(font-lock-comment-face ((t (:foreground "tomato"))))
 '(font-lock-constant-face ((t (:foreground "DodgerBlue1"))))
 '(font-lock-type-face ((t (:foreground "MediumOrchid1"))))
 '(helm-bookmark-directory ((t (:foreground "red"))))
 '(helm-buffer-directory ((t (:foreground "deep pink"))))
 '(helm-ff-directory ((t (:foreground "red"))))
 '(helm-selection ((t (:background "gray20" :underline t))))
 '(helm-selection-line ((t (:background "gray10" :underline "deep pink"))))
 '(magit-diff-added ((t (:background "black" :foreground "green"))))
 '(magit-diff-added-highlight ((t (:background "dark slate gray" :foreground "green"))))
 '(magit-diff-context-highlight ((t (:foreground "gray110" :background "gray9"))))
 '(magit-diff-removed ((t (:background "black" :foreground "cornflower blue"))))
 '(magit-diff-removed-highlight ((t (:background "navy" :foreground "deep sky blue"))))
 '(magit-hash ((t (:foreground "red"))))
 '(mode-line ((t (:background "aquamarine4" :foreground "white" :weight normal :box nil)))))
