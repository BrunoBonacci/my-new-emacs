;;;; General emacs configuration

;; use Shift+arrow_keys to move cursor around split panes
;; same but with [Cmd]+[alt]+[->]
(global-set-key [M-s-left]  'windmove-left)
(global-set-key [M-s-right] 'windmove-right)
(global-set-key [M-s-up]    'windmove-up)
(global-set-key [M-s-down]  'windmove-down)
(setq windmove-wrap-around t )

;;
;; Disable guru warnings
;;
(setq prelude-guru nil)

;;
;; Install solarized theme
;;
;; this necessary for the first time to install missing packages if
;; you change things here remember to apply them to
;; `personal/preload/theme.el` as well
(prelude-require-packages '(color-theme-sanityinc-solarized solarized-theme))
(setq prelude-theme 'sanityinc-solarized-dark)
;; change default font size
(set-face-attribute 'default nil :height 140)
;; hightlight modeline of active buffer
(set-face-foreground 'mode-line "black")
(set-face-background 'mode-line "green4")
(set-face-background 'modeline-inactive "grey20")
(set-face-foreground 'mode-line-buffer-id "white")

;;
;; Global revert
;;
;; reload buffers from disk
(global-auto-revert-mode t)


;;
;; Dired config
;;
;; Enable Dired to copy between buffers in a split-screen
(setq dired-dwim-target t)
;; allow dired to be able to delete or copy a whole dir.
(setq dired-recursive-copies (quote always)) ; “always” means no asking
(setq dired-recursive-deletes (quote top)) ; “top” means ask once
(require 'dired-x)
(global-set-key (kbd "C-x C-/")  'dired-jump) ;; jump to dired currentfile



;;
;; Custom YAS snippets
;;
;; load custom yas snippets
(prelude-require-packages '(yasnippet clojure-snippets datomic-snippets
                                      java-snippets pig-snippets))
(setq yas-snippet-dirs
      (list  (or (concat (file-name-directory load-file-name) "yas")
                 "~/.yas")))
(require 'yasnippet)
(yas-global-mode 1)

;; Disable YAS autocompletion for Terminal Mode
(add-hook 'term-mode-hook (lambda()
                            (setq yas-dont-activate t)))



;;
;; .TODO.org
;;
;; automatically open .TODO.org scripts at startup
(setq default-message
      "
* org-mode is a great tool, use it for your own notes
** org-mode key-bindings http://orgmode.org/orgcard.txt
** Documentation: http://orgmode.org/
** Video tutorials:
  - https://www.youtube.com/watch?v=6W82EdwQhxU
  - https://www.youtube.com/watch?v=fgizHHd7nOo
  - https://www.youtube.com/watch?v=bzZ09dAbLEE
")

;; if not exists create one
(if (not (file-exists-p "~/.TODO.org"))
    (append-to-file default-message nil "~/.TODO.org"))
;; open all existing ones
(mapcar 'find-file  (directory-files "~/" t "^.TODO.*.org"))


;;
;; Disable tabs and uses sapces instead
;;
(setq-default indent-tabs-mode nil)


;;
;; installing cua-mode for rectangle selection C-RET
;;
;;enable cua-mode for rectangular selections
(require 'cua-base)
(require 'cua-gmrk)
(require 'cua-rect)
(cua-mode 1)
(setq cua-enable-cua-keys nil)



;;
;; delete space but one like emacs-live
;;
(defun live-delete-whitespace-except-one ()
  (interactive)
  (just-one-space -1))
(global-set-key (kbd "M-SPC ") 'live-delete-whitespace-except-one)



;;
;; magit warning
;;
(setq magit-last-seen-setup-instructions "1.4.0")
