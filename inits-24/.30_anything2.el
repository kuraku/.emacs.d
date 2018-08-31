;; -*- emacs-lisp -*-
;; @ anything.el
;; Time-stamp: <2012-10-15 17:42:30 akira.masuda>

;; 2nd ver

;(require 'anything-startup)
(require 'anything-config)
;(require 'recentf)
;;(require 'anything-etags)
;;(require 'anything-grep)
;;(require 'anything-ipa)
(recentf-mode 1)
(global-set-key "\C-x\C-a" 'anything)
(global-set-key [?\C-/] 'my-anything)
;;(global-set-key [f12] 'anything)
(define-key anything-map "\en" 'anything-next-source)
(define-key anything-map "\ep" 'anything-previous-source)

;;Setting `anything-sources' directly is not good because
;;`anything' is not for one command.  For now, interactive use of
;;`anything' (M-x anything) is only for demonstration purpose.
;;So you should define commands calling `anything'.
;;I help you to migrate to the new way.
;;
;;The code below is automatically generated from current
;;`anything-sources' value. You can use the `my-anything' command
;;now!
;;
;;Copy and paste it to your .emacs. Then substitute `my-anything'
;;for `anything' bindings in all `define-key', `local-set-key' and
;;`global-set-key' calls.

(defun my-anything ()
  "Anything command for you.

It is automatically generated by `anything-migrate-sources'."
  (interactive)
  (anything-other-buffer
    '(((name . "Buffers") (init lambda nil (setq anything-c-buffers-cache (anything-c-buffer-list))) (candidates . anything-c-buffers-cache) (type . buffer) (match anything-c-buffer-match-major-mode) (diff-action . anything-buffer-toggle-diff) (revert-action . anything-buffer-revert-and-update) (save-action . anything-buffer-save-and-update) (candidate-transformer anything-c-skip-current-buffer anything-c-skip-boring-buffers anything-c-highlight-buffers) (persistent-action . anything-c-buffers+-persistent-action) (mode-line . anything-buffer-mode-line-string) (persistent-help . "Show this buffer / C-u \\[anything-execute-persistent-action]: Kill this buffer"))
	  ((name . "Recentf") (init lambda nil (require (quote recentf)) (or recentf-mode (recentf-mode 1)) (when (and (numberp recentf-max-saved-items) (<= recentf-max-saved-items 20)) (setq recentf-max-saved-items 500))) (candidates . recentf-list) (match anything-c-match-on-file-name anything-c-match-on-directory-name) (type . file)) 
	  ((name . "File Name History") (candidates . file-name-history) (match anything-c-match-on-file-name anything-c-match-on-directory-name) (type . file)) 
	  ((name . "Emacs Commands") (candidates lambda nil (let (commands) (mapatoms (lambda (a) (if (commandp a) (push (symbol-name a) commands)))) (sort commands (quote string-lessp)))) (type . command) (requires-pattern . 2)) 
	  ((name . "Create buffer") (dummy) (type . buffer)) 
	  ((name . "Occur") (init . anything-c-occur-init) (candidates-in-buffer) (migemo) (get-line . anything-c-occur-get-line) (type . line) (recenter) (requires-pattern . 1) (delayed) (volatile)) 
	  ((name . "Bookmarks") (init lambda nil (require (quote bookmark))) (candidates . bookmark-all-names) (type . bookmark)) 
	  ((name . "Info Pages") (candidates lambda nil (if anything-c-info-pages anything-c-info-pages (setq anything-c-info-pages (save-window-excursion (save-excursion (require (quote info)) (Info-find-node "dir" "top") (goto-char (point-min)) (let ((info-topic-regexp "\\* +\\([^:]+: ([^)]+)[^.]*\\)\\.") topics) (while (re-search-forward info-topic-regexp nil t) (add-to-list (quote topics) (match-string-no-properties 1))) (goto-char (point-min)) (Info-exit) topics)))))) (action ("Show with Info" lambda (node-str) (info (replace-regexp-in-string "^[^:]+: " "" node-str)))) (requires-pattern . 2))
	  ((name . "Semantic Tags") (init lambda nil (setq anything-semantic-candidates (ignore-errors (anything-semantic-construct-candidates (semantic-fetch-tags) 0)))) (candidates lambda nil (if anything-semantic-candidates (mapcar (quote car) anything-semantic-candidates))) (persistent-action lambda (elm) (anything-semantic-default-action elm) (anything-match-line-color-current-line)) (persistent-help . "Show this entry") (action . anything-semantic-default-action) "Needs semantic in CEDET.

http://cedet.sourceforge.net/semantic.shtml
http://cedet.sourceforge.net/")
	  ((name . "Global Bookmarks") (init . anything-c-bm-global-init) (candidates-in-buffer) (type . file-line))
	  ((name . "W3m Bookmarks") (init lambda nil (setq anything-c-w3m-bookmarks-alist (anything-html-bookmarks-to-alist w3m-bookmark-file anything-w3m-bookmark-url-regexp anything-w3m-bookmarks-regexp))) (candidates lambda nil (mapcar (function car) anything-c-w3m-bookmarks-alist)) (filtered-candidate-transformer anything-c-adaptive-sort anything-c-highlight-w3m-bookmarks) (action ("Browse Url" lambda (candidate) (anything-c-w3m-browse-bookmark candidate)) ("Copy Url" lambda (elm) (kill-new (anything-c-w3m-bookmarks-get-value elm))) ("Browse Url Firefox" lambda (candidate) (anything-c-w3m-browse-bookmark candidate t)) ("Delete Bookmark" lambda (candidate) (anything-c-w3m-delete-bookmark candidate)) ("Rename Bookmark" lambda (candidate) (anything-c-w3m-rename-bookmark candidate))) (persistent-action lambda (candidate) (if current-prefix-arg (anything-c-w3m-browse-bookmark candidate t) (anything-c-w3m-browse-bookmark candidate nil t))) (persistent-help . "Open URL with emacs-w3m in new tab / C-u \\[anything-execute-persistent-action]: Open URL with Firefox"))
	  ((name . "Kill Ring") (init lambda nil (anything-attrset (quote last-command) last-command)) (candidates . anything-c-kill-ring-candidates) (action . anything-c-kill-ring-action) (last-command . anything-exit-minibuffer) (migemo) (multiline)))
    "*my-anything*"))

;;
(defun anything-c-bm-global-init ()
  "Init function for `anything-c-source-bm-global'."
  (when (require 'bm nil t)
    (with-no-warnings
      (let ((files bm-repository)
            (buf (anything-candidate-buffer 'global)))
        (dolist (file files)            ;ブックマークされてるファイルリストから，1つ取り出す
          (dolist (bookmark (cdr (assoc 'bookmarks (cdr file)))) ;1つのファイルに対して複数のブックマークがあるので
            (let ((position (cdr (assoc 'position bookmark))) ;position
                  (annotation (cdr (assoc 'annotation bookmark))) ;annotation
                  (file (car file))                               ;file名を取り出す
                  line
                  str)
              (setq str (with-current-buffer (find-file-noselect file) ;anything用の文字列にformat
                               (goto-char position)
                               (beginning-of-line)
                               (unless annotation
                                   (setq annotation ""))
                               (if (string= "" line)
                                   (setq line  "<EMPTY LINE>")
                                 (setq line (car (split-string (thing-at-point 'line) "[\n\r]"))))
                               (format "%s:%d: [%s]: %s\n" file (line-number-at-pos) annotation line)))
              (with-current-buffer buf (insert str)))))))))

;; Color
(eval-after-load "anything"
  '(progn
	 (set-face-bold-p 'anything-header t)
	 (set-face-foreground 'anything-header "white")
	 (set-face-background 'anything-header "DarkSeaGreen4")
	 (set-face-foreground 'anything-isearch-match "white")
	 (set-face-background 'anything-isearch-match "IndianRed")

	 (set-face-bold-p 'anything-dir-heading nil)
	 (set-face-foreground 'anything-dir-heading "DodgerBlue")
	 (set-face-background 'anything-dir-heading nil)

	 (set-face-bold-p 'anything-dir-priv nil)
	 (set-face-foreground 'anything-dir-priv "DodgerBlue")
	 (set-face-background 'anything-dir-priv nil) ))

;; 10.10.21(thu)-10:49
(require 'descbinds-anything)
(descbinds-anything-install)

;; 10.11.05(fri)-14:14
(require 'anything-c-moccur)
(global-set-key (kbd "M-o") 'anything-c-moccur-occur-by-moccur)
(global-set-key (kbd "C-M-o") 'anything-c-moccur-dmoccur)
(global-set-key (kbd "C-x C-/") 'anything-call-source)

;; 11.03.01(tue)-10:30
;;(require 'anything-esh)

;; END anythin setup