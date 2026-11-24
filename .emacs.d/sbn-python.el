(defvar sbn-python--file "")

(defun sbn-python-set-file-manual ()
  (interactive)
  (setq sbn-python--file (read-string "Python file: ")))

(defun sbn-python-set-file-this ()
  (interactive)
  (setq sbn-python--file buffer-file-name))

(defun sbn-python-compile ()
  (interactive)
  (compile
   (concat
    "/home/sbn/venv/bin/python \""
    (if (string= "" sbn-python--file)
        buffer-file-name
      sbn-python--file)
    "\"")))

(sbn-target-register
 "python"
 #'sbn-python-compile
 #'sbn-target-none)

(sbn-target-register-mode 'python-mode "python")
