(defvar sbn-make--dir ".")

(defun sbn-make-set-dir-manual ()
  (interactive)
  (setq sbn-make--dir (read-string "Make directory: ")))

(defun sbn-make-set-dir-this ()
  (interactive)
  (setq sbn-make--dir (file-name-directory buffer-file-name)))

(defun sbn-make-compile ()
  (interactive)
  (compile
   (concat "make -C " sbn-make--dir)))

(sbn-target-register
 "make"
 #'sbn-make-compile
 #'sbn-target-none)
