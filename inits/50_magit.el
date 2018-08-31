;;
(require 'magit)

;;[C-q G]
(define-key my-key-map "G" 'magit-status)

(add-to-list 'process-coding-system-alist '("git" utf-8 . utf-8))
(add-hook 'git-commit-mode-hook
          '(lambda ()
             (set-buffer-file-coding-system 'utf-8)))

;; diff 色付け
(custom-set-faces
  '(magit-diff-added ((t (:background "black" :foreground "green"))))
  '(magit-diff-added-highlight ((t (:background "dark slate gray" :foreground "green"))))
  '(magit-diff-removed ((t (:background "black" :foreground "cornflower blue"))))
  '(magit-diff-removed-highlight ((t (:background "navy" :foreground "deep sky blue"))))
  '(magit-hash ((t (:foreground "red"))))
  '(magit-diff-context-highlight ((t (:foreground "gray110" :background "gray9"))))
)
