(defun sbn-cpp-cppcheck-file ()
  (interactive)
  (compile (concat "cppcheck --enable=warning,style,performance,portability --inconclusive --check-level=exhaustive --library=posix --std=c++17 --language=c++ --template=gcc " (buffer-file-name))))

(defun sbn-cpp-clang-format-region (beg end)
  (interactive "r")
  (shell-command-on-region beg end "clang-format" nil t))

;; Machine-specific settings
(defconst sbn-cpp--indent
  (if (string= (system-name) "sbn-0540-u") 3 4))

;; C++ style
(require 'cc-mode)
(defconst sbn-cpp--style
  `((c-basic-offset . ,sbn-cpp--indent)
    (indent-tabs-mode . nil)
    (c-offsets-alist . ((innamespace . 0)
                        (inlambda . 0)
                        (access-label . -)
                        (label . 0)
                        (case-label . 0)
                        (statement-case-intro . +)
                        (statement-case-open . +)
                        (arglist-intro . c-lineup-arglist)
                        (arglist-cont . c-lineup-arglist)
                        (arglist-cont-nonempty . c-lineup-arglist)
                        (arglist-close . c-lineup-arglist)
                        (brace-list-open . 0)
                        (inline-open . 0)
                        (substatement-open . 0)
                        (statement-cont . c-lineup-math)
                        (template-args-cont . +)))
    (c-hanging-braces-alist . ((defun-open after)
                               (class-open after)
                               (inline-open after)
                               (block-open after)
                               (brace-list-open after)
                               (namespace-open after)
                               (substatement-open after)))
    (c-hanging-colons-alist . ((case-label after)
                               (label after)
                               (access-label after)
                               (member-init-intro before)))
    (c-cleanup-list brace-else-brace
                    brace-elseif-brace
                    empty-defun-braces
                    scope-operator))
  "CC-mode indentation tweaks.")

(defun sbn-cpp--style-enable ()
  "Activate nbiot gh5g style plus auxiliary buffer-local settings."
  (c-add-style "sbn-cpp--style" sbn-cpp--style t)
  (setq-local fill-column 120)
  (setq-local comment-fill-column 120)
  (setq-local c-syntactic-indentation t)
  (setq-local c-block-comment-prefix " ")
  (setq-local c-ignore-auto-fill nil)
  ;; (semantic-mode t)
  )

(add-hook 'c-mode-hook #'sbn-cpp--style-enable)
(add-hook 'c++-mode-hook #'sbn-cpp--style-enable)
