;; Functions
(defun sbn-theme-next ()
  (interactive)
  (let* ((current (car custom-enabled-themes))
         (next (pcase (symbol-name current)
                 ("gruber-darker" 'tango)
                 ("tango" 'leuven)
                 ("leuven" 'gruber-darker))))
    (disable-theme current)
    (load-theme next)
    (message (concat "Switching from " (symbol-name current) " to " (symbol-name next)))))

;; Key-bindings
(keymap-global-set "<f2>" 'isearch-forward-symbol-at-point)
(keymap-global-set "<f7>" 'project-find-file)
(keymap-global-set "<f8>" 'rgrep)
(keymap-global-set "<f12>" 'sbn-theme-next)
(keymap-global-set "<f5>" 'sbn-target-compile)
(keymap-global-set "<f6>" 'sbn-target-execute)
(keymap-global-set "<f7>" 'sbn-target-set)

(sbn-target-register
 "make"
 #'sbn-make-compile
 #'sbn-target-none)

;; (defun sbn-cpp-c--key-hook ()
;;   (local-set-key (kbd "<f1>") #'sbn-cpp-cppcheck-file)
;;   (local-set-key (kbd "<f5>") #'sbn-cpp-compile)
;;   (local-set-key (kbd "<f6>") #'sbn-cpp-execute)
;;   (local-set-key (kbd "M-<f5>") #'sbn-cpp-compile-variation)
;;   (local-set-key (kbd "M-<f6>") #'sbn-cpp-execute-variation))

;; (add-hook 'c-mode-hook #'sbn-cpp-c--key-hook)
;; (add-hook 'c++-mode-hook #'sbn-cpp-c--key-hook)
