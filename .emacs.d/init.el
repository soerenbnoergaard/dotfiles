;; User specific settings 
;;{{{

(setq ebib-preload-bib-files (quote ("/home/soren/svn/project4/rap/bib/kilder.bib")))

;;}}}

;; Load folders 
;;{{{
(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/single_files/")
(add-to-list 'load-path "~/.emacs.d/colorthemes/")
;;}}}

;; Autoload and extra packages 
;;{{{

(require 'yasnippet-bundle)
(require 'tex-site)

(setq auto-mode-alist 
      (append '(
                ("\\.php\\'"                 . php-mode)
                ("\\.\\(frm\\|bas\\|cls\\)$" . visual-basic-mode)
                ("\\.m\\'"                   . octave-mode)
                ("\\.cs\\'"                  . csharp-mode)
                ("\\.ino\\'"                 . c-mode)
                ("\\.gp$"                    . gnuplot-mode)
                ("\\.nxc\\'"                 . c-mode)
                ) auto-mode-alist))
(autoload 'visual-basic-mode "visual-basic-mode" "Visual Basic mode." t)
(autoload 'php-mode          "php-mode"          "PHP mode"           t)
(autoload 'csharp-mode       "csharp-mode"       "C Sharp Mode"       t)
(autoload 'c-mode            "cc-mode"           "CC mode"            t)
(autoload 'ebib              "ebib"              "Ebib"               t)

;;}}}

;; Custom functions 
;;{{{
;;}}}

;; Editor settings 
;;{{{
(setq column-number-mode t)                          ;; Show column numbers

                                        ;------------ Startup
(setq inhibit-startup-screen t)                      ;; No startup screen
(setq initial-scratch-message nil)                   ;; No scratch message

                                        ;------------ Behavior
(global-auto-revert-mode t)                          ;; Auto revert mode
(show-paren-mode 1)                                  ;; Show matching parenthesies
(setq show-paren-style 'parenthesis)
(setq show-paren-ring-bell-on-mismatch t)
(global-set-key (kbd "C-x C-b") 'ibuffer)            ;; Ibuffer as buffer manager
(setq x-select-enable-clipboard t)                   ;; Use system clipboard
(setq make-backup-files nil)                         ;; Don't make backup files
(delete-selection-mode t)                            ;; Delete region with backslash/delete
(setq delete-by-moving-to-trash t)                   ;; If deleted in folder view, move to trash
(setq browse-url-browser-function 'browse-url-generic 
      browse-url-generic-program "xdg-open")         ;; Set browser

                                        ;------------ Tabs
(setq-default tab-width 4)                           ;; Use 4 spaces
(setq-default c-basic-offset 4)                      ;; Use 4 spaces in C
(setq-default indent-tabs-mode nil)                  ;; Use spaces
;;}}}

;; Added functionality 
;;{{{
(setq ispell-program-name "hunspell")  
(setq ispell-local-dictionary-alist
      '(
        (nil       "[A-Za-zçéêèóôòæøåÇÉÊÈÓÔÒÆØÅ]" "[^A-Za-zçéêèóôòæøåÇÉÊÈÓÔÒÆØÅ]" "" nil ("-d" "da_DK") nil utf-8)
        ("english" "[A-Za-zçéêèóôòæøåÇÉÊÈÓÔÒÆØÅ]" "[^A-Za-zçéêèóôòæøåÇÉÊÈÓÔÒÆØÅ]" "" nil ("-d" "da_DK") nil utf-8)))

(load "folding" 'nomessage 'noerror)
(folding-mode-add-find-file-hook)

;; (setq                                                ;; Scroll one line at a time
;;  scroll-margin 0                  
;;  scroll-conservatively 100000
;;  scroll-preserve-screen-position 1)
;;}}}

;; GUI 
;;{{{

(when window-system 
  (require 'color-theme)
  (require 'color-theme-gruber-darker)
  (color-theme-gruber-darker)
  (set-default-font "DejaVu Sans Mono-11")
  (modify-frame-parameters nil '((wait-for-wm . nil))) ;; Ignore WM geometry change
  )
;;}}}

;; Hooks 
;;{{{
(add-hook 'c-mode-common-hook 
          (lambda()
            (local-set-key (kbd "C-c C-<right>") 'hs-show-block)    ;; Fold with these keys
            (local-set-key (kbd "C-c C-<left>")  'hs-hide-block)
            (local-set-key (kbd "C-c C-<up>")    'hs-hide-all)
            (local-set-key (kbd "C-c C-<down>")  'hs-show-all)
            (hs-minor-mode t)
            ))

(add-hook 'octave-mode-hook 
          (lambda()
            (local-set-key (kbd "<S-return>")  'octave-send-line)
            (local-set-key (kbd "<C-return>")  'octave-send-region)
            ))

(add-hook 'org-mode-hook
          (lambda ()
            (org-indent-mode t)
            (visual-line-mode t)
            (defun yas/org-very-safe-expand ()                          ;; Solve tab problem
              (let ((yas/fallback-behavior 'return-nil)) (yas/expand)))
            (make-variable-buffer-local 'yas/trigger-key)
            (setq yas/trigger-key [tab])
            (add-to-list 'org-tab-first-hook 'yas/org-very-safe-expand)
            (define-key yas/keymap [tab] 'yas/next-field)
            t))

(add-hook 'LaTeX-mode-hook 
          (lambda ()
            (visual-line-mode t)
            (load "preview-latex.el" nil t t)
            (outline-minor-mode t)
            (reftex-mode t)
            (setq reftex-plug-into-AUCTeX t)
            (tex-fold-mode t)
            (load "auctex.el" nil t t)
            (tex-pdf-mode t)
            ))
(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (folding-mode t)
            (local-set-key (kbd "C-c C-<right>") 'folding-show-current-entry) ;; Fold with these keys
            (local-set-key (kbd "C-c C-<left>")  'folding-hide-current-entry)
            (local-set-key (kbd "C-c C-<up>")  'folding-whole-buffer)
            (local-set-key (kbd "C-c C-<down>")  'folding-open-buffer)
            ))
;;}}}

;; Keymapping 
;;{{{
(global-set-key [f12] 'flyspell-buffer)         ;; Spellcheck buffer
(global-set-key [f9] 'ispell-word)          ;; Spellcheck word
;;}}}
