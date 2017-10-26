(defun nshuffle (seq)
  (loop for rem = (length seq) then (1- rem)
        for fp = 0 then (1+ fp)
        while (> rem 1)
        do (rotatef (elt seq (+ fp (random rem))) (elt seq fp))
        finally (return seq)))

(defparameter *zones* '())

(defmacro defzone (name &optional (initial ()))
  `(setq *zones* (acons ,name ,initial *zones*)))

(defzone 'hand)
(defzone 'deck)
(defzone 'discard)
(defzone 'play)
(defzone 'trash)

(defun add-to-zone (seq zone-name)
  (dolist (i seq)
    (push i (cdr (assoc zone-name *zones*)))))

(add-to-zone '(a b c d) 'deck)
(add-to-zone '(e) 'deck)

(setf (cdr (assoc 'deck *zones*)) (nshuffle (cdr (assoc 'deck *zones*))))
(add-to-zone '(f) 'deck)
(setf (cdr (assoc 'deck *zones*)) (nshuffle (cdr (assoc 'deck *zones*))))
