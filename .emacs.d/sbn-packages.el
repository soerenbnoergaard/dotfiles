;; External packages
(autoload 'markdown-mode "markdown-mode" "Major mode for Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(autoload 'dockerfile-mode "dockerfile-mode" "Major mode for Dockerfile" t)
(add-to-list 'auto-mode-alist '("\\Dockerfile\\'" . dockerfile-mode))

(require 'cmake-mode)
