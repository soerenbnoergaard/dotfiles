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

(load "~/.emacs.d/sbn-target.el")

(sbn-target-register
 ""
 (lambda () (message "(no target selected)"))
 (lambda () (message "(no target selected)")))
		     
(sbn-target-register
 "make"
 (lambda () (compile "make -C ."))
 (lambda () (message "(no execute function registered)")))

(sbn-target-register
 "python"
 (lambda () (interactive) (save-buffer) (compile (concat "~/venv/bin/python " (buffer-name))))
 (lambda () (message "(no execute function registered)")))

(global-set-key (kbd "<f5>") 'sbn-target-compile)
(global-set-key (kbd "<f6>") 'sbn-target-execute)
(global-set-key (kbd "<f7>") 'sbn-target-set)
