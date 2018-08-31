;;; tid-mode.el --- tid-mode is an Emacs major mode for editing TiddlyWiki .tid files.

;;; Commentary:
;; Hosted at https://github.com/mwfogleman/tid-mode.

;;; Code:

;;; init/51_tid-mode.el が新しい

(defun tid-p ()
  "Check whether or not a buffer's file is a .tid file."
  (and
   (> (length (buffer-file-name)) 4)
   (string-equal (substring (buffer-file-name) -4) ".tid")))

(defun tid-time ()
  "Update .tid metadata to reflect the modification time."
  (when (tid-p)
	(save-excursion
	  (goto-char (point-min))
	  (search-forward "modified: ")
	  (beginning-of-line)
	  (kill-line)
	  (insert (format-time-string "modified: %Y%m%d%H%M%S%3N\n")))))

(defun tid-save ()
  "Allow `tid-mode' to run the function `tid-time' when contents are written."
  (add-hook 'write-contents-hooks 'tid-time))

;;(setq orgstruct-heading-prefix-regexp "\\(!\\|\\*\\)")
;;(setq orgstruct-heading-prefix-regexp "!\\|\\\\\*")

(define-derived-mode tid-mode text-mode "Tid"
  "A major mode for editing TiddlyWiki5 (.tid) files."
  (setq tid-mode-hook nil)
  (add-hook 'tid-mode-hook 'turn-on-orgstruct++)
  ;;(add-hook 'tid-mode-hook 'turn-on-orgstruct)
  ;;(add-hook 'tid-mode-hook 'subword-mode)
  (add-hook 'tid-mode-hook 'tid-save)
  (add-hook 'tid-mode-hook
		  '(lambda ()
			 (hi-lock-set-pattern "^created:" 'org-document-title)
			 (hi-lock-set-pattern "^creator:" 'org-document-title)
			 (hi-lock-set-pattern "^modified:" 'org-document-title)
			 (hi-lock-set-pattern "^modifier:" 'org-document-title)
			 (hi-lock-set-pattern "^tags:" 'org-document-title)
			 (hi-lock-set-pattern "^title:" 'org-warning)
			 (hi-lock-set-pattern "^type:" 'org-document-title)
			 ;;
			 (hi-lock-set-pattern "^.*\\(?:^![^!]\\).*$" 'org-level-1)
			 (hi-lock-set-pattern "^.*\\(?:^!![^!]\\).*$" 'org-level-2)
			 (hi-lock-set-pattern "^.*\\(?:^!!![^!]\\).*$" 'org-level-5)
			 (hi-lock-set-pattern "^.*\\(?:^>\\).*$" 'org-macro)
			 (hi-lock-set-pattern "^.*\\(?:^\*\\).*$" 'org-scheduled)
			 (hi-lock-set-pattern "^.*\\(?:^```$\\)" 'org-level-6)
	 		 (hi-lock-set-pattern "^.*\\(?:^\<\<\<$\\)" 'org-level-6)
	 		 (hi-lock-set-pattern "^.*\\(?:^\"\"\"$\\)" 'org-level-6)
	 		 (hi-lock-set-pattern "^;.*$" 'org-document-title)
			 ))
  )

;; hi-lock
(global-hi-lock-mode 1)

;;(add-hook 'tid-mode-hook
;;		  '(lambda
;;			 (hi-lock-set-pattern "^title:" 'hi-green-b)
;;			 (hi-lock-set-pattern "^.*\\(?:^!\\).*$" 'hi-yellow)
;;			 ))

(add-to-list 'auto-mode-alist '("\\.tid\\'" . tid-mode))

(provide 'tid-mode)

;;;

(setq tid-dir "m:/tw/tid/")
(setq owner "masuda")

;; %s: created, modified, title
(setq journal-text "created: %s
creator: %s
modified: %s
modifier: %s
tags: Journal tid
title: %s
type: application/x-tiddler

!本日の予定
\"\"\"

\"\"\"
")

(defun tid-journal ()
  (interactive)
  (setq title (format-time-string "%Y.%m.%d_tid"))
  (setq tid-file (concat tid-dir title ".tid"))
  (find-file tid-file)
  (end-of-buffer)

  ;; template set
  (when (not (file-exists-p tid-file))
	(let* ((cdate (format-time-string "%Y%m%d%H%M%S%3N"))
		  (j-t (format journal-text cdate owner cdate owner title)))
	  (insert j-t) (backward-char 4)
	  (set-buffer-file-coding-system (intern "utf-8-dos")))) )

(defalias 'ma:tid-journal 'tid-journal)
(define-key my-key-map "J" 'ma:tid-journal)


;; new tiddler
(setq new-text "created: %s
creator: %s
modified: %s
modifier: %s
tags: tid
title: %s
type: application/x-tiddler

!%s
")

(defun tid-new (title)
  (interactive "sTiddler title:")
  (setq tid-file (concat tid-dir title ".tid"))
  (find-file tid-file)
  (end-of-buffer)

  ;; template set
  (when (not (file-exists-p tid-file))
	(let* ((cdate (format-time-string "%Y%m%d%H%M%S%3N"))
		  (j-t (format new-text cdate owner cdate owner title title)))
	  (insert j-t)
	  (set-buffer-file-coding-system (intern "utf-8-dos")))) )

(defalias 'ma:tid-new 'tid-new)

;;; tid-mode.el ends here
