;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                            ;;
;;   ---==| T E M P O R A R Y   O R   I N C O M P L E T E   W O R K |==----   ;;
;;                                                                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                            ;;
;;          ---==| C L O J U R E / C L O J U R E S C R I P T |==----          ;;
;;                                                                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;
;; Figwheel REPL startup
;;
(defun cider-figwheel-repl ()
  (interactive)
  (with-current-buffer (cider-current-repl-buffer)
    (goto-char (point-max))
    (insert "(require 'figwheel-sidecar.repl-api)
             (figwheel-sidecar.repl-api/start-figwheel!) ; idempotent
             (figwheel-sidecar.repl-api/cljs-repl)")
    (cider-repl-return)))



;;
;; Incanter eval and display chart
;;

(require 'cider)
(setq incanter-temp-chart-file "/tmp/chart.png")
(setq incanter-wait-time 500)


(defun incanter-display-image-inline (buffer-name file-name)
  "Use `BUFFER-NAME' to display the image in `FILE-NAME'.
  Checks weather `BUFFER-NAME' already exists, and if not create
  as needed."
  (save-excursion
    (switch-to-buffer-other-window buffer-name)
    (iimage-mode t)
    (read-only-mode -1)
    (kill-region (point-min) (point-max))
    ;; unless we clear the cache, the same cached image will
    ;; always get re-displayed.
    (clear-image-cache nil)
    (insert-image (create-image file-name))
    (read-only-mode t)))


(defun incanter-eval-and-display-chart ()
  "Evaluate the expression preceding point
   and display the chart into a popup buffer"
  (interactive)
  (save-excursion
    (condition-case nil
        (delete-file incanter-temp-chart-file)
      (error nil))
    (cider-eval-last-sexp)
    (sleep-for 0 incanter-wait-time)
    (incanter-display-image-inline "*incanter-chart*" incanter-temp-chart-file)))

(define-key cider-mode-map
  (kbd "C-c C-i") #'incanter-eval-and-display-chart)


;;
;; CIDER repl evaluation with output in comment
;;

;; (require 'cider-interaction)
;; (defun cider-eval-print-handler (&optional buffer)
;;   "Make a handler for evaluating and printing result in BUFFER."
;;   (nrepl-make-response-handler (or buffer (current-buffer))
;;                                (lambda (buffer value)
;;                                  (with-current-buffer buffer
;;                                    (insert
;;                                     (if (derived-mode-p 'cider-clojure-interaction-mode)
;;                                         (format "\n%s\n" value)
;;                                       (format ";;=> %s" value)))))
;;                                (lambda (_buffer out)
;;                                  (cider-emit-interactive-eval-output out))
;;                                (lambda (_buffer err)
;;                                  (cider-emit-interactive-eval-err-output err))
;;                                '()))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                            ;;
;;            ---==| W I N D O W S   R E S I Z E   M O D E |==----            ;;
;;                                                                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;
;; Minor mode to resize windows
;;
(defvar iresize-mode-map
  (let ((m (make-sparse-keymap)))
    (define-key m (kbd "V")       'enlarge-window)
    (define-key m (kbd "<down>")  'enlarge-window)
    (define-key m (kbd "^")       'shrink-window)
    (define-key m (kbd "<up>")    'shrink-window)
    (define-key m (kbd ">")       'enlarge-window-horizontally)
    (define-key m (kbd "<right>") 'enlarge-window-horizontally)
    (define-key m (kbd "<")       'shrink-window-horizontally)
    (define-key m (kbd "<left>")  'shrink-window-horizontally)
    (define-key m (kbd "C-g")     'iresize-mode)
    m))

(define-minor-mode iresize-mode
  :initial-value nil
  :lighter " IResize"
  :keymap iresize-mode-map
  :group 'iresize)

(provide 'iresize)
(key-chord-define-global "WR" 'iresize-mode)
