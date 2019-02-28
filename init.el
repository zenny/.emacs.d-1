;; Added export PATH="/path/to/code/cask/bin:$PATH" by Package.el.
;; This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("gnu" . "http://elpa.emacs-china.org/gnu/"))
(add-to-list 'package-archives
	     '("melpa" . "http://elpa.emacs-china.org/melpa/"))
(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
	(package-refresh-contents)
	(package-install 'use-package))

(read-only-mode 1)
(org-babel-load-file (expand-file-name "~/.emacs.d/myconfig.org"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#424242" "#d54e53" "#b9ca4a" "#e7c547" "#7aa6da" "#c397d8" "#70c0b1" "#eaeaea"))
 '(beacon-color "#cc6666")
 '(custom-enabled-themes (quote (leuven)))
 '(custom-safe-themes
   (quote
    ("43c1a8090ed19ab3c0b1490ce412f78f157d69a29828aa977dae941b994b4147" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "9a155066ec746201156bb39f7518c1828a73d67742e11271e4f24b7b178c4710" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" default)))
 '(dashboard-image-banner-max-height 20)
 '(dashboard-image-banner-max-width 20)
 '(evil-leader/leader ";")
 '(fancy-splash-image "~/.emacs.d/img/ying.jpg")
 '(fci-rule-color "#373b41")
 '(flycheck-color-mode-line-face-to-color (quote mode-line-buffer-id))
 '(frame-background-mode (quote dark))
 '(hl-sexp-background-color "#efebe9")
 '(menu-bar-mode nil)
 '(mode-line-format
   (quote
    ("%e"
     (:eval
      (window-numbering-get-number-string))
     mode-line-front-space mode-line-mule-info mode-line-client mode-line-modified mode-line-remote mode-line-frame-identification mode-line-buffer-identification "   " mode-line-position
     (vc-mode vc-mode)
     "  " mode-line-modes mode-line-misc-info mode-line-end-spaces)))
 '(org-agenda-files
   (quote
    ("~/program_org/BuJo-2019.org" "/Users/kinney/org/diary.org" "/Users/kinney/org/entry.org" "/Users/kinney/org/gtd.org" "/Users/kinney/org/new_words.org")))
 '(org-agenda-window-setup (quote current-window))
 '(org-journal-dir "~/org/entries")
 '(org-pomodoro-ask-upon-killing nil)
 '(package-selected-packages
   (quote
    (dashboard-hackernews magit smex vue-mode vue-html-mode cnfonts chinese-fonts-setup org-journal pdf-tools youdao-dictionary dashboard elfeed-goodies elfeed hackernews python-django django-mode alert async auto-complete auto-yasnippet ccls color-theme-sanityinc-tomorrow company counsel dash epl evil evil-leader evil-nerd-commenter exec-path-from-shell expand-region flycheck helm helm-ag helm-core hungry-delete iedit ivy js2-mode js2-refactor leuven-theme nodejs-repl org-pomodoro org-projectile org-bullets package-build pkg-info popup popwin reveal-in-osx-finder ruby-hash-syntax shell-pop smartparens swiper use-package web-mode which-key window-numbering yasnippet sr-speedbar)))
 '(popwin-mode t)
 '(popwin:adjust-other-windows nil)
 '(show-paren-mode t)
 '(speedbar-default-position (quote right))
 '(speedbar-show-unknown-files t)
 '(sr-speedbar-auto-refresh nil)
 '(sr-speedbar-default-width 20)
 '(sr-speedbar-max-width 20)
 '(sr-speedbar-right-side nil)
 '(tool-bar-mode nil)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#cc6666")
     (40 . "#de935f")
     (60 . "#f0c674")
     (80 . "#b5bd68")
     (100 . "#8abeb7")
     (120 . "#81a2be")
     (140 . "#b294bb")
     (160 . "#cc6666")
     (180 . "#de935f")
     (200 . "#f0c674")
     (220 . "#b5bd68")
     (240 . "#8abeb7")
     (260 . "#81a2be")
     (280 . "#b294bb")
     (300 . "#cc6666")
     (320 . "#de935f")
     (340 . "#f0c674")
     (360 . "#b5bd68"))))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(dashboard-banner-logo-title-face ((t (:inherit default :foreground "#65C4EB"))))
 '(dashboard-heading-face ((t (:inherit default :foreground "#65C4EB"))))
 '(magit-blame-highlight ((t (:background "grey52"))))
 '(magit-diff-context-highlight ((t (:background "grey70" :foreground "grey70"))))
 '(magit-section-highlight ((t (:background "#0086ce"))))
 '(org-block ((t (:inherit shadow :background "#FFFFE0" :foreground "default")))))
