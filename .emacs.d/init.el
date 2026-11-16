;; User-specific settings
(setq custom-file "~/.emacs.d/sbn-custom.el")
(add-to-list 'custom-theme-load-path "~/.emacs.d/package/theme")
(add-to-list 'load-path "~/.emacs.d/package/")

(setq inhibit-startup-screen t)
(ido-mode t)
(ido-everywhere 1)
;; (fido-mode t)
(setq make-backup-files nil)
(setq-default truncate-lines t)
(setq-default indent-tabs-mode nil)
(setq-default show-trailing-whitespace t)
(setq-default auto-revert-check-vc-info t)

(tool-bar-mode 0)
(menu-bar-mode 1)
(global-auto-revert-mode 1)
(column-number-mode 1)
(global-display-line-numbers-mode 1)
(setq display-line-numbers-grow-only t)
(which-function-mode 1)

(add-hook 'compilation-filter-hook 'ansi-color-compilation-filter)
(setq-default compilation-scroll-output t)

(load "~/.emacs.d/sbn-target.el")
(load "~/.emacs.d/sbn-custom.el")
(load "~/.emacs.d/sbn-python.el")
(load "~/.emacs.d/sbn-octave.el")
(load "~/.emacs.d/sbn-make.el")
(load "~/.emacs.d/sbn-cpp.el")
(load "~/.emacs.d/sbn-vhdl.el")
(load "~/.emacs.d/sbn-keymap.el")
(load "~/.emacs.d/sbn-packages.el")

;; Work-specific settings
(let ((file "~/.emacs-work.el"))
  (when (file-exists-p file)
    (load file nil t)))

;; GUI settings
(when (display-graphic-p)
  ;; (load-theme 'leuven)
  ;; (load-theme 'modus-vivendi)
  (load-theme 'gruber-darker)
  ;; (load-theme 'modus-operandi)
  ;; (load-theme 'tango)

  (set-frame-font "Jetbrains Mono Medium 11" t t)
  ;; (set-frame-font "DejaVu Sans Mono 11" t t)
  ;; (set-frame-font "Terminus Medium 12" t t)

  ;; (set-frame-font "Spleen 8x16" t t)
  ;; (set-face-attribute 'default nil :family "Spleen 8x16" :height 120)

  ;; (set-frame-font "Spleen 6x12" t t)
  ;; (set-face-attribute 'default nil :family "Spleen 6x12" :height 90)

  ;; Disable bold fonts
  ;; (mapc (lambda (face) (set-face-attribute face nil :weight 'normal)) (face-list))
  )
