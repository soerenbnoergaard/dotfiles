(defvar sbn-target-name "")
(defvar sbn-target-map (make-hash-table :test #'equal))

(defvar sbn-target-name-by-mode nil
  "alist mapping major-mode to a target name")

(defun sbn-target--get-name ()
  "If a by-mode name is registered, this takes precedence"
  (or (alist-get major-mode sbn-target-name-by-mode)
      sbn-target-name))

(defun sbn-target-register (name compile-cb execute-cb)
  "Register a new target"
  (puthash name (list :compile compile-cb :execute execute-cb) sbn-target-map))

(defun sbn-target-register-mode (mode name)
  "Override the command to use for a given major mode"
  (setf (alist-get mode sbn-target-name-by-mode) name))

(defun sbn-target-compile ()
  "Run compile command for target"
  (interactive)
  (funcall (plist-get (gethash (sbn-target--get-name) sbn-target-map) :compile)))

(defun sbn-target-execute ()
  (interactive)
  "Run execute function for target"
  (funcall (plist-get (gethash (sbn-target--get-name) sbn-target-map) :execute)))

(defun sbn-target-set ()
  "Set the current active target"
  (interactive)
  (let (names)
    (maphash (lambda (key _value) (push key names)) sbn-target-map)
    (setq sbn-target-name (completing-read "Target: " names nil t))))

(defun sbn-target-none ()
  (message "(no action)"))

(defun sbn-target-compile-from-project-root (command)
  (save-excursion
    (let ((default-directory (project-root (project-current))))
      (compile command))))

(defun sbn-target-shell-from-project-root (command)
  (save-excursion
    (let ((default-directory (project-root (project-current))))
      (shell-command command))))

;; Register a default target
(sbn-target-register
 ""
 #'sbn-target-none
 #'sbn-target-none)
