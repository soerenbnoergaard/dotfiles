(defun sbn-octave-compile ()
  (interactive)
  (compile
   (concat "octave \"" buffer-file-name "\"")))

(add-to-list 'auto-mode-alist '("\\.m\\'" . octave-mode))

(add-hook 'octave-mode-hook (lambda () (setq comment-start "% ")))

(sbn-target-register
 "octave"
 #'sbn-octave-compile
 #'sbn-target-none)

(sbn-target-register-mode 'octave-mode "octave")
