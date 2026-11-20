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

(global-set-key (kbd "C-x C-b") 'ibuffer)
