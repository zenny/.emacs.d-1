;;; window config

(use-package winum
  :ensure t
  ;; :config
  ;; (defun winum-assign-9-to-calculator-8-to-flycheck-errors ()
  ;;   (cond
  ;;    ((equal (buffer-name) "*Calculator*") 9)
  ;;    ((equal (buffer-name) "*Flycheck errors*") 8)))

  ;; (defun winum-assign-0-to-neotree ()
  ;;   (when (string-match-p (buffer-name) ".*\\*NeoTree\\*.*") 10))

  ;; (add-to-list 'winum-assign-functions #'winum-assign-9-to-calculator-8-to-flycheck-errors)
  ;; (add-to-list 'winum-assign-functions #'winum-assign-0-to-neotree)

  ;; (set-face-attribute 'winum-face nil :weight 'bold)

  ;; (setq window-numbering-scope            'global
  ;; 	winum-reverse-frame-list          nil
  ;; 	winum-auto-assign-0-to-minibuffer t
  ;; 	winum-assign-func                 'my-winum-assign-func
  ;; 	winum-auto-setup-mode-line        t
  ;; 	winum-format                      " %s "
  ;; 	winum-mode-line-position          1
  ;; 	winum-ignored-buffers             '(" *which-key*"))

  :config
  (winum-mode))

(use-package ace-window
  :ensure t
  :defer t
  :bind (("M-o" . ace-window))
  :config
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)))

(use-package popwin
  :ensure t
  :config (popwin-mode 1))

(use-package neotree
  :ensure t
  :defer 5
  :bind (("<f8>" . neotree-toggle))
  :config
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow)))

;; (use-package elscreen
;;   :ensure t)

(provide 'init-window)
