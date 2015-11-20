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
(load-theme 'solarized-dark t)
(setq prelude-theme 'solarized-dark)
;; change default font size
(set-face-attribute 'default nil :height 140)
;; hightlight modeline of active buffer
(set-face-foreground 'mode-line "black")
(set-face-background 'mode-line "green4")
(set-face-background 'modeline-inactive "grey20")
(set-face-foreground 'mode-line-buffer-id "white")

;; disable scroll bars
(if (display-graphic-p)
    (progn
      (tool-bar-mode -1)
      (scroll-bar-mode -1)))


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
(setq magit-last-seen-setup-instructions "2.1.0")
(setq magit-push-always-verify nil)


;;
;; ERC - irc
;;
(setq erc-hide-list '("JOIN" "PART" "QUIT"))


;;
;; Getting rid of annoying key chords
;;
(prelude-require-package 'key-chord)
(require 'key-chord)
;; disabling lowercase chords
(key-chord-define-global "jj" nil)
(key-chord-define-global "jl" nil)
(key-chord-define-global "jk" nil)
(key-chord-define-global "uu" nil)
(key-chord-define-global "xx" nil)
(key-chord-define-global "yy" nil)

;; remapping chords
(key-chord-define-global "JL" 'avy-goto-line)
(key-chord-define-global "JK" 'avy-goto-char)
(key-chord-define-global "JJ" 'prelude-switch-to-previous-buffer)
(key-chord-define-global "UU" 'undo-tree-visualize)
(key-chord-define-global "XX" 'execute-extended-command)
(key-chord-define-global "YY" 'browse-kill-ring)
(key-chord-define-global "YY" 'browse-kill-ring)

;; custom chords
(key-chord-define-global "WS" 'frameset-to-register)
(key-chord-define-global "WL" 'jump-to-register)

(defun window-toggle-zoom ()
  (interactive)
  (if (= 1 (length (window-list)))
      (jump-to-register 'ZZ 't)
    (progn
      (frameset-to-register 'ZZ)
      (delete-other-windows))))

(key-chord-define-global "ZZ" 'window-toggle-zoom)


;;
;; Installing paradox package manager
;;
(prelude-require-package 'paradox)
