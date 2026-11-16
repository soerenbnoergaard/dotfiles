;; Machine-specific settings
(defconst sbn-vhdl--indent
  (if (string= (system-name) "sbn-0540-u") 3 4))

(add-hook 'vhdl-mode-hook (lambda () (setq vhdl-basic-offset sbn-vhdl--indent)))
