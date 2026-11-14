(setq-default inhibit-startup-screen t)
(setq-default truncate-lines t)
(indent-tabs-mode nil)
(tool-bar-mode 0)
(menu-bar-mode 1)
(setq make-backup-files nil)
(when (display-graphic-p)
  ;; (load-theme 'leuven)
  (load-theme 'modus-vivendi)
  (set-frame-font "Jetbrains Mono Medium 11"))
(ido-mode t)
(ido-everywhere 1)
;; (fido-vertical-mode t)

(global-set-key (kbd "<f1>") 'compile)
(global-set-key (kbd "<f2>") 'rgrep)

(defun sbn-python-mode-hook ()
  (interactive)
  (local-set-key [f5] (lambda () (interactive) (save-buffer) (compile (concat "/home/sbn/venv/bin/python " (buffer-name))))))

(add-hook 'python-mode-hook 'sbn-python-mode-hook)


