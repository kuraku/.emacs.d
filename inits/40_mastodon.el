;; -*- emacs-list -*-
;; @@ mastodon
;; Time-stamp: <2017-11-17 14:22 akira.masuda>

(require 'mastodon)

;;自分のインスタンスのurlを読み込ませる
(setq mastodon-instance-url "https://mstdn-workers.com")
;;(setq mastodon-instance-url "https://mstdn.jp")


(defun mastodon-tl--timeline (toots)
  "Display each toot in TOOTS."
  (mapc 'mastodon-tl--toot toots)
  (goto-char (point-min))
  (while (search-forward "\n\n\n | " nil t)
    (replace-match " | "))
  ;;  (replace-match "\n | "))
  ;;(mastodon-media--inline-images)) ;; 画像をつぶす
  )

