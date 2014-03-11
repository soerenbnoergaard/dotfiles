;; User specific settings 
;;{{{

(setq ebib-preload-bib-files (quote ("/home/soren/svn/project6/rep/bib/sources.bib")))

;;}}}

;; Load folders 
;;{{{
(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/single_files/")
(add-to-list 'load-path "~/.emacs.d/colorthemes/")
(add-to-list 'load-path "~/.emacs.d/matlab-emacs/")
;;}}}

;; Autoload and extra packages 
;;{{{

(require 'yasnippet-bundle)
(require 'tex-site)

(setq auto-mode-alist 
      (append '(
                ("\\.php\\'"                 . php-mode)
                ("\\.\\(frm\\|bas\\|cls\\)$" . visual-basic-mode)
                ("\\.m\\'"                   . matlab-mode)
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
(load-library "matlab-load")

;;}}}

;; Custom functions 
;;{{{
;;}}}

;; Editor settings 
;;{{{
(setq column-number-mode t)                          ;; Show column numbers
(tool-bar-mode nil)
(menu-bar-mode nil)

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
(recentf-mode t)                                     ;; Most recent files

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

(setq                                                ;; Scroll one line at a time
 scroll-margin 0                  
 scroll-conservatively 100000
 scroll-preserve-screen-position 1)
;;}}}

;; GUI 
;;{{{

(when window-system 
  ;; (require 'color-theme)
  ;; (require 'color-theme-gruber-darker)
  ;; (color-theme-gruber-darker)
  ;; (load-theme 'deeper-blue)
  (load "~/.emacs.d/colorthemes/color-theme-molokai.el")
  (color-theme-molokai)

  ;; (set-default-font "DejaVu Sans Mono-11")
  ;; (set-default-font "Monaco-11")
  (set-default-font "Source Code Pro-11")
  (modify-frame-parameters nil '((wait-for-wm . nil))) ;; Ignore WM geometry change
  )

(unless window-system
  (menu-bar-mode nil)
  )
;;}}}

;; Hooks 
;;{{{

(add-hook 'c-mode-common-hook 
          (lambda()
            (setq tab-width 4)
            (setq c-basic-offset 4)
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
            ;; (folding-mode t)
            ;; (local-set-key (kbd "C-c C-<right>") 'folding-show-current-entry) ;; Fold with these keys
            ;; (local-set-key (kbd "C-c C-<left>")  'folding-hide-current-entry)
            ;; (local-set-key (kbd "C-c C-<up>")  'folding-whole-buffer)
            ;; (local-set-key (kbd "C-c C-<down>")  'folding-open-buffer)
            ))

;;}}}

;; Keymapping 
;;{{{
(global-set-key [f12] 'flyspell-buffer)
(global-set-key [f9] 'ispell-word)
(global-set-key (kbd "M-p") 'backward-paragraph)
(global-set-key (kbd "M-n") 'forward-paragraph)

;;}}}

;; Tmux collaborative editing 
;;{{{
;; (require 'server)
;; some systems don't auto-detect the socket dir, so specify it here and for the client:
;; (setq server-socket-dir "/tmp/emacs-shared")
;; (server-start)

;; highlight-changes-mode is very handy when collaborating:
;; (global-highlight-changes-mode t)
;; Keys for moving back and forth between changes, set these to what
;; you prefer:
;; (global-set-key (kbd "<f5>") 'highlight-changes-previous-change)
;; (global-set-key (kbd "<f6>") 'highlight-changes-next-change)
;; (global-set-key (kbd "<f7>") 'highlight-changes-rotate-faces)
;; (global-set-key (kbd "<f8>") 'highlight-changes-remove-highlight)

;; The following has to be done
;; for this to work:
;;     mkdir /tmp/tmux-shared
;;     chgrp users /tmp/tmux-shared
;;     chmod g+ws  /tmp/tmux-shared

;; Start the host:
;;     tmux -S /tmp/tmux-shared/myshare
;;     emacs

;; Connect to host:
;;    tmux -S /tmp/tmux-shared/myshare
;;    emacsclient --tty --socket-name /tmp/emacs-shared/server
;;}}}
