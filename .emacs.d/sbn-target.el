(defvar sbn-target-name "")
(defvar sbn-target-map (make-hash-table :test #'equal))

(defun sbn-target-register (name compile-cb execute-cb)
  ;; Register a new target
  (puthash name (list :compile compile-cb :execute execute-cb) sbn-target-map))

(defun sbn-target-compile ()
  ;; Run "compile" command for target
  (interactive)
  (funcall (plist-get (gethash sbn-target-name sbn-target-map) :compile)))

(defun sbn-target-execute ()
  (interactive)
  ;; Run "execute" function for target
  (funcall (plist-get (gethash sbn-target-name sbn-target-map) :execute)))

(defun sbn-target-set (name)
  ;; Set the current active target
  (interactive
   (let (names)
     (maphash (lambda (key _value) (push key names)) sbn-target-map)
     (setq sbn-target-name (completing-read "Target: " names nil t)))))
