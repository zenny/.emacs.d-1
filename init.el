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
   ["#0a0814" "#f2241f" "#67b11d" "#b1951d" "#4f97d7" "#a31db1" "#28def0" "#b2b2b2"])
 '(beacon-color "#cc6666")
 '(custom-enabled-themes (quote (spacemacs-dark)))
 '(custom-safe-themes
   (quote
    ("6b2636879127bf6124ce541b1b2824800afc49c6ccd65439d6eb987dbf200c36" "4697a2d4afca3f5ed4fdf5f715e36a6cac5c6154e105f3596b44a4874ae52c45" "1c082c9b84449e54af757bcae23617d11f563fc9f33a832a8a2813c4d7dfb652" "8aca557e9a17174d8f847fb02870cb2bb67f3b6e808e46c0e54a44e3e18e1020" "d1b4990bd599f5e2186c3f75769a2c5334063e9e541e37514942c27975700370" "b54826e5d9978d59f9e0a169bbd4739dd927eead3ef65f56786621b53c031a7c" "100e7c5956d7bb3fd0eebff57fde6de8f3b9fafa056a2519f169f85199cc1c96" "a3fa4abaf08cc169b61dea8f6df1bbe4123ec1d2afeb01c17e11fdc31fc66379" "7e78a1030293619094ea6ae80a7579a562068087080e01c2b8b503b27900165c" "d2e9c7e31e574bf38f4b0fb927aaff20c1e5f92f72001102758005e53d77b8c9" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "43c1a8090ed19ab3c0b1490ce412f78f157d69a29828aa977dae941b994b4147" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "9a155066ec746201156bb39f7518c1828a73d67742e11271e4f24b7b178c4710" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" default)))
 '(dashboard-image-banner-max-height 250)
 '(dashboard-image-banner-max-width 250)
 '(evil-leader/leader ";")
 '(fancy-splash-image "~/.emacs.d/img/ying.jpg")
 '(fci-rule-color "#373b41")
 '(flycheck-color-mode-line-face-to-color (quote mode-line-buffer-id))
 '(frame-background-mode (quote dark))
 '(hl-paren-colors (quote ("Cyan" "Gold" "Red")))
 '(hl-sexp-background-color "#efebe9")
 '(hl-todo-keyword-faces
   (quote
    (("TODO" . "#dc752f")
     ("NEXT" . "#dc752f")
     ("THEM" . "#2d9574")
     ("PROG" . "#4f97d7")
     ("OKAY" . "#4f97d7")
     ("DONT" . "#f2241f")
     ("FAIL" . "#f2241f")
     ("DONE" . "#86dc2f")
     ("NOTE" . "#b1951d")
     ("KLUDGE" . "#b1951d")
     ("HACK" . "#b1951d")
     ("TEMP" . "#b1951d")
     ("FIXME" . "#dc752f")
     ("XXX" . "#dc752f")
     ("XXXX" . "#dc752f")
     ("???" . "#dc752f"))))
 '(imaxima-bg-color "black")
 '(imaxima-equation-color "Green3")
 '(imaxima-fg-color "DarkGreen")
 '(imaxima-fnt-size "Large")
 '(imaxima-label-color "slategrey")
 '(imaxima-max-scale 0.85)
 '(imaxima-pt-size 12)
 '(jdee-db-active-breakpoint-face-colors (cons "#0d0f11" "#7FC1CA"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#0d0f11" "#A8CE93"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#0d0f11" "#899BA6"))
 '(menu-bar-mode nil)
 '(mode-line-format
   (quote
    ("%e"
     (:eval
      (window-numbering-get-number-string))
     mode-line-front-space mode-line-mule-info mode-line-client mode-line-modified mode-line-remote mode-line-frame-identification mode-line-buffer-identification "   " mode-line-position
     (vc-mode vc-mode)
     "  " mode-line-modes mode-line-misc-info mode-line-end-spaces)))
 '(neo-cwd-line-style (quote button))
 '(neo-show-slash-for-folder nil)
 '(neo-theme (quote icons))
 '(neo-window-fixed-size nil)
 '(neo-window-width 25)
 '(org-agenda-files
   (quote
    ("~/program_org/BuJo-2019.org" "/Users/kinney/org/diary.org" "/Users/kinney/org/entry.org" "/Users/kinney/org/gtd.org" "/Users/kinney/org/new_words.org")))
 '(org-agenda-window-setup (quote current-window))
 '(org-journal-dir "~/org/entries")
 '(org-pomodoro-ask-upon-killing nil)
 '(package-selected-packages
   (quote
    (treemacs-magit treemacs-icons-dired treemacs-projectile treemacs-evil search-web guess-word emmet-mode neotree all-the-icons-dired doom-modeline spacemacs-theme magit smex vue-mode vue-html-mode cnfonts chinese-fonts-setup org-journal pdf-tools youdao-dictionary dashboard elfeed-goodies elfeed python-django django-mode alert async auto-complete auto-yasnippet ccls color-theme-sanityinc-tomorrow company counsel dash epl flycheck hungry-delete iedit ivy js2-mode js2-refactor nodejs-repl org-pomodoro org-projectile org-bullets package-build pkg-info popup popwin reveal-in-osx-finder ruby-hash-syntax shell-pop smartparens swiper use-package web-mode which-key window-numbering yasnippet sr-speedbar)))
 '(pdf-view-midnight-colors (quote ("#b2b2b2" . "#292b2e")))
 '(popwin-mode t)
 '(popwin:adjust-other-windows nil)
 '(pyim-page-length 8)
 '(search-web-default-browser (quote browse-url-default-macosx-browser))
 '(search-web-engines
   (quote
    (("github" "https://github.com/search?q=%s" nil)
     ("baidu" "https://www.baidu.com/s?ie=UTF-8&wd=%s" nil)
     ("google" "http://www.google.com/search?q=%s" nil)
     ("youtube" "http://www.youtube.com/results?search_type=&search_query=%s&aq=f" nil))))
 '(search-web-external-browser (quote browse-url-default-macosx-browser))
 '(show-paren-mode t)
 '(smiley-style (quote medium))
 '(speedbar-default-position (quote right))
 '(speedbar-show-unknown-files t)
 '(sr-speedbar-auto-refresh t)
 '(sr-speedbar-default-width 20)
 '(sr-speedbar-max-width 20)
 '(sr-speedbar-right-side t)
 '(sr-speedbar-skip-other-window-p nil)
 '(term-default-bg-color "#000000")
 '(term-default-fg-color "#dddd00")
 '(tool-bar-mode nil)
 '(tramp-verbose 0 nil (tramp))
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
 '(ac-candidate-face ((t (:background "#191919" :foreground "#878787"))))
 '(ac-clang-candidate-face ((t (:background "#191919" :foreground "#878787"))))
 '(ac-clang-selection-face ((t (:background "darkred" :foreground "grey"))))
 '(ac-gtags-candidate-face ((t (:background "#191919" :foreground "#878787"))))
 '(ac-gtags-selection-face ((t (:background "orangered4" :foreground "grey"))))
 '(ac-menu-face ((t (:background "Grey10" :foreground "Grey40"))))
 '(ac-selection-face ((t (:background "darkred" :foreground "grey"))))
 '(ac-yasnippet-candidate-face ((t (:background "#191919" :foreground "#878787"))))
 '(ac-yasnippet-menu-face ((t (:background "Grey10" :foreground "Grey40"))))
 '(ac-yasnippet-selection-face ((t (:background "darkgreen" :foreground "Grey"))))
 '(ace-jump-face-foreground ((t (:background "darkorange" :foreground "black" :box (:line-width 1 :color "#333333") :weight ultra-bold))))
 '(ascii-ascii-face ((((class color) (background dark)) (:background "Black" :foreground "Grey"))))
 '(ascii-non-ascii-face ((((class color) (background dark)) (:background "Black" :foreground "Gold"))))
 '(button ((t (:foreground "deepskyblue3" :underline t))))
 '(cal-china-x-priority1-holiday-face ((((class color) (background dark)) (:background "DarkRed" :foreground "White"))))
 '(cal-china-x-priority2-holiday-face ((((class color) (background dark)) (:background "Khaki" :foreground "Black"))))
 '(col-highlight ((t (:background "Grey5"))))
 '(comint-highlight-input ((t (:background "black" :foreground "gold3" :weight bold))))
 '(comint-highlight-prompt ((((min-colors 88) (background dark)) (:foreground "Green"))))
 '(company-tooltip-annotation-selection ((t (:foreground "white"))))
 '(completion-dynamic-face ((((class color) (background dark)) (:background "DarkOrange" :foreground "black"))))
 '(completion-tooltip-face ((t (:inherit tooltip :background "grey5" :foreground "khaki1"))))
 '(completions-common-part ((t (:foreground "Green3"))))
 '(completions-first-difference ((t (:foreground "Grey60"))))
 '(custom-comment ((((class grayscale color) (background dark)) (:background "grey5" :foreground "green"))))
 '(custom-group-tag ((t (:inherit variable-pitch :foreground "DodgerBlue" :underline t :weight bold :height 1.2))))
 '(custom-variable-tag ((t (:foreground "gold" :underline t :weight bold))))
 '(dashboard-banner-logo-title-face ((t (:inherit default :foreground "#65C4EB"))))
 '(dashboard-heading-face ((t (:inherit default :foreground "#65C4EB"))))
 '(diredp-date-time ((t (:foreground "Grey60"))))
 '(diredp-deletion ((t (:background "Black" :foreground "red"))))
 '(diredp-deletion-file-name ((t (:foreground "red"))))
 '(diredp-dir-heading ((t (:background "Black" :foreground "Gold"))))
 '(diredp-dir-priv ((t (:background "Black" :foreground "DodgerBlue"))))
 '(diredp-display-msg ((t (:foreground "Gold"))))
 '(diredp-exec-priv ((t (:background "Black" :foreground "DeepSkyBlue3"))))
 '(diredp-file-name ((t (:foreground "Green3"))))
 '(diredp-file-suffix ((t (:foreground "Green4"))))
 '(diredp-flag-mark ((t (:background "Black" :foreground "Cyan"))))
 '(diredp-flag-mark-line ((t (:background "Black" :foreground "Cyan"))))
 '(diredp-ignored-file-name ((t (:foreground "grey40"))))
 '(diredp-no-priv ((t (:background "Black" :foreground "Green"))))
 '(diredp-other-priv ((t (:background "Black" :foreground "khaki"))))
 '(diredp-rare-priv ((t (:background "Black" :foreground "Red"))))
 '(diredp-read-priv ((t (:background "Black" :foreground "IndianRed"))))
 '(diredp-write-priv ((t (:background "Black" :foreground "Gold3"))))
 '(egg-diff-hunk-header ((((class color) (background dark)) (:background "grey30" :foreground "Gold"))))
 '(egg-log-HEAD ((t (:background "Black" :foreground "Red"))))
 '(egg-text-help ((t (:inherit egg-text-base :height 0.9))))
 '(elscreen-tab-background-face ((((type x w32 mac) (class color)) (:background "Black"))))
 '(elscreen-tab-control-face ((((type x w32 mac) (class color)) (:background "Black" :foreground "Green"))))
 '(elscreen-tab-current-screen-face ((((class color)) (:background "DarkRed" :foreground "Grey" :box (:line-width -1 :color "Red" :style released-button)))))
 '(elscreen-tab-other-screen-face ((((type x w32 mac) (class color)) (:background "Black" :foreground "Green3" :box (:line-width -1 :color "Grey20" :style released-button)))))
 '(emmet-preview-input ((t (:foreground "gold" :underline t))))
 '(emmet-preview-output ((t (:background "gray10" :foreground "grey80"))))
 '(emms-browser-album-face ((((class color) (background dark)) (:foreground "Green3" :height 1.1))))
 '(emms-browser-artist-face ((((class color) (background dark)) (:foreground "Gold3" :height 1.3))))
 '(emms-browser-track-face ((((class color) (background dark)) (:foreground "khaki3" :height 1.0))))
 '(emms-playlist-selected-face ((t (:foreground "Green"))))
 '(emms-playlist-track-face ((t (:foreground "DarkGreen"))))
 '(epe-dir-face ((t (:foreground "green3"))))
 '(epe-git-face ((t (:foreground "systemRedColor"))))
 '(epe-pipeline-delimiter-face ((t (:foreground "green4"))))
 '(epe-pipeline-host-face ((t (:foreground "systemGreenColor"))))
 '(epe-pipeline-time-face ((t (:foreground "systemGrayColor"))))
 '(epe-pipeline-user-face ((t (:foreground "gold"))))
 '(eperiodic-d-block-face ((((class color) (background dark)) (:inherit eperiodic-generic-block-face :background "DarkRed" :foreground "White"))))
 '(eperiodic-f-block-face ((((class color) (background dark)) (:inherit eperiodic-generic-block-face :background "DarkRed" :foreground "Grey"))))
 '(eperiodic-generic-block-face ((((class color)) nil)))
 '(eperiodic-group-number-face ((t (:inherit eperiodic-generic-block-face :foreground "grey" :weight bold))))
 '(eperiodic-header-face ((t (:foreground "Gold" :weight bold))))
 '(eperiodic-p-block-face ((((class color)) (:inherit eperiodic-generic-block-face :background "Green4" :foreground "Grey"))))
 '(eperiodic-period-number-face ((t (:foreground "grey" :weight bold))))
 '(eperiodic-s-block-face ((((class color)) (:inherit eperiodic-generic-block-face :background "tan3" :foreground "cornsilk2"))))
 '(erc-direct-msg-face ((t (:foreground "DodgerBlue"))))
 '(erm-syn-errline ((t (:background "black" :foreground "red" :underline t))))
 '(erm-syn-warnline ((t (:background "black" :foreground "yellow" :underline nil))))
 '(feebleline-git-branch-face ((t (:foreground "gray35"))))
 '(feebleline-linum-face ((t (:foreground "gray35"))))
 '(feebleline-time-face ((t (:foreground "gray35"))))
 '(fixme-face ((t (:foreground "orange" :box (:line-width 1 :color "orange") :weight bold))))
 '(flycheck-error-list-highlight ((t (:foreground "orange red"))))
 '(flycheck-posframe-error-face ((t (:background "gray12" :foreground "red3" :box (:line-width 1 :color "grey20")))))
 '(flycheck-posframe-face ((t (:inherit default :foreground "gold"))))
 '(flycheck-posframe-info-face ((t (:inherit flycheck-posframe-face :background "gray12" :box (:line-width 1 :color "grey20")))))
 '(gnus-button ((t (:foreground "khaki3" :weight bold))))
 '(gnus-cite-1 ((((class color) (background dark)) (:foreground "Grey50"))))
 '(gnus-signature ((t (:foreground "Orange" :slant italic))))
 '(gnus-summary-high-ancient ((t (:foreground "Grey50" :weight bold))))
 '(gnus-summary-high-read ((t (:foreground "Gold2" :weight bold))))
 '(gnus-summary-low-ancient ((t (:foreground "Grey10" :slant italic))))
 '(gnus-summary-low-read ((t (:foreground "Gold4" :slant italic))))
 '(gnus-summary-normal-ancient ((((class color) (background dark)) (:foreground "Grey40"))))
 '(gnus-summary-normal-read ((((class color) (background dark)) (:foreground "khaki2"))))
 '(go-to-char-highlight ((((class color) (background dark)) (:background "Pink" :foreground "Black"))))
 '(highlight-cl ((t (:foreground "#20ABFC" :underline nil))))
 '(highlight-cl-and-other ((t (:foreground "#20ABFC" :underline nil))))
 '(highlight-cl-macro ((t (:underline nil))))
 '(hl-sexp-face ((((class color) (background dark)) (:background "gray2"))))
 '(hs-face ((t (:background "DarkRed" :foreground "grey" :box (:line-width 1 :color "grey50")))))
 '(hs-fringe-face ((t (:background "DarkRed" :foreground "grey" :box (:line-width 2 :color "grey75" :style released-button)))))
 '(icicle-candidate-part ((((background dark)) (:background "Black" :foreground "Purple"))))
 '(icicle-complete-input ((((background dark)) (:foreground "Gold"))))
 '(icicle-completion ((((background dark)) (:foreground "Gold"))))
 '(icicle-current-candidate-highlight ((((background dark)) (:background "DarkRed" :foreground "White"))))
 '(icicle-input-completion-fail ((((background dark)) (:background "DarkRed" :foreground "White"))))
 '(icicle-input-completion-fail-lax ((((background dark)) (:background "khaki" :foreground "Black"))))
 '(icicle-match-highlight-Completions ((((background dark)) (:foreground "DodgerBlue1"))))
 '(icicle-multi-command-completion ((((background dark)) (:foreground "Gold"))))
 '(icicle-mustmatch-completion ((((type x w32 mac graphic) (class color)) (:inherit nil))))
 '(icicle-saved-candidate ((((background dark)) (:background "Black" :foreground "khaki"))))
 '(icicle-special-candidate ((((background dark)) (:background "Black" :foreground "Grey"))))
 '(icicle-whitespace-highlight ((((background dark)) (:background "DarkRed"))))
 '(info-elisp-command-ref-item ((t (:background "Black" :foreground "yellow3"))))
 '(info-elisp-function-ref-item ((t (:background "Black" :foreground "Gold3"))))
 '(info-elisp-macro-ref-item ((t (:background "Black" :foreground "Yellow3"))))
 '(info-elisp-reference-item ((t (:background "Black" :foreground "DarkRed"))))
 '(info-elisp-special-form-ref-item ((t (:background "Black" :foreground "OrangeRed2"))))
 '(info-elisp-syntax-class-item ((t (:background "Black" :foreground "Khaki3"))))
 '(info-elisp-user-option-ref-item ((t (:background "Black" :foreground "LawnGreen"))))
 '(info-elisp-variable-ref-item ((t (:background "Black" :foreground "#0048FF"))))
 '(info-file ((t (:background "Black" :foreground "Blue"))))
 '(info-menu-header ((t (:inherit variable-pitch :foreground "khaki3" :weight bold))))
 '(isearch-fail ((((class color) (min-colors 88) (background dark)) (:background "red4" :foreground "white"))))
 '(italic ((t (:underline nil :slant normal))))
 '(magit-blame-highlight ((t (:foreground "tan4"))))
 '(magit-branch-remote-head ((t (:foreground "tan3" :weight extra-bold))))
 '(magit-diff-add ((t (:foreground "DodgerBlue1"))))
 '(magit-diff-added ((t (:foreground "gold"))))
 '(magit-diff-added-highlight ((t (:foreground "gold"))))
 '(magit-diff-base ((t (:foreground "#ffffcc"))))
 '(magit-diff-base-highlight ((t (:foreground "#eeeebb"))))
 '(magit-diff-context ((t (:foreground "green3"))))
 '(magit-diff-file-heading-highlight ((t (:foreground "green2"))))
 '(magit-diff-lines-boundary ((t (:foreground "rosybrown4"))))
 '(magit-diff-lines-heading ((t (:foreground "rosybrown4"))))
 '(magit-diff-removed ((t (:foreground "red2"))))
 '(magit-diff-removed-highlight ((t (:foreground "darkred"))))
 '(magit-diff-whitespace-warning ((t (:background "red3" :foreground "white"))))
 '(magit-log-head-label ((t (:foreground "orange"))))
 '(magit-log-tag-label ((t (:foreground "gold"))))
 '(message-header-subject ((t (:foreground "gold" :weight bold))))
 '(message-header-to ((t (:foreground "DarkRed" :weight bold))))
 '(mm-uu-extract ((((class color) (background dark)) (:background "Black" :foreground "Gold3"))))
 '(modelinepos-column-warning ((t (:foreground "Yellow"))))
 '(newsticker-date-face ((t (:foreground "red" :slant italic :height 0.8))))
 '(newsticker-default-face ((((class color) (background dark)) (:inherit default))))
 '(newsticker-enclosure-face ((t (:background "orange" :weight bold))))
 '(newsticker-extra-face ((t (:foreground "gray50" :slant italic :height 0.9))))
 '(newsticker-feed-face ((t (:foreground "Green" :weight bold :height 1.2))))
 '(newsticker-immortal-item-face ((t (:foreground "green" :slant italic :weight bold))))
 '(newsticker-new-item-face ((t (:foreground "Gold" :weight bold))))
 '(newsticker-obsolete-item-face ((t (:strike-through t :weight bold))))
 '(newsticker-old-item-face ((t (:foreground "purple" :weight bold))))
 '(newsticker-statistics-face ((t (:foreground "red" :slant italic :height 0.8))))
 '(newsticker-treeview-face ((t (:foreground "Green4" :weight normal))))
 '(newsticker-treeview-new-face ((t (:inherit newsticker-treeview-face :foreground "DodgerBlue" :weight bold))))
 '(newsticker-treeview-old-face ((((class color) (background dark)) (:inherit newsticker-treeview-face :foreground "purple"))))
 '(newsticker-treeview-selection-face ((((class color) (background dark)) (:background "DarkRed" :foreground "White"))))
 '(pabbrev-suggestions-face ((((class color) (background dark)) (:background "Black" :foreground "khaki1"))))
 '(pabbrev-suggestions-label-face ((t (:background "Black" :foreground "Grey" :inverse-video nil))))
 '(popup-menu-summary-face ((t (:background "#191919" :foreground "grey"))))
 '(popup-summary-face ((t (:background "#191919" :foreground "grey"))))
 '(rcirc-my-nick ((((class color) (min-colors 88) (background dark)) (:foreground "Green3" :weight semi-bold))))
 '(rcirc-nick-in-message ((((class color) (min-colors 88) (background dark)) (:foreground "Gold"))))
 '(rcirc-nick-in-message-full-line ((t (:underline "grey20"))))
 '(rcirc-other-nick ((((class color) (min-colors 88) (background dark)) (:foreground "tomato"))))
 '(rcirc-prompt ((((min-colors 88) (background dark)) (:foreground "Purple"))))
 '(rcirc-server ((((class color) (min-colors 88) (background dark)) (:foreground "DarkRed"))))
 '(rcirc-server-prefix ((default (:foreground "khaki4")) (((class color) (min-colors 16)) nil)))
 '(rcirc-track-nick ((t (:foreground "Green"))))
 '(reb-match-0 ((((class color) (background dark)) (:background "khaki3" :foreground "Black"))))
 '(reb-match-1 ((((class color) (background dark)) (:background "dodgerblue3" :foreground "black"))))
 '(reb-match-2 ((((class color) (background dark)) (:background "chartreuse3" :foreground "black"))))
 '(reb-match-3 ((((class color) (background dark)) (:background "sienna3" :foreground "black"))))
 '(rfcview-headlink-face ((t (:foreground "DodgerBlue"))))
 '(rfcview-headname-face ((t (:foreground "DarkRed" :underline t :weight bold))))
 '(rfcview-headnum-face ((t (:foreground "DarkRed" :weight bold))))
 '(rfcview-mouseover-face ((t (:background "DarkRed" :foreground "white" :weight bold))))
 '(rfcview-rfcnum-face ((t (:foreground "Green3" :weight bold))))
 '(rfcview-stdnum-face ((t (:foreground "Grey" :weight bold))))
 '(rfcview-title-face ((t (:foreground "Gold" :weight bold))))
 '(rg-file-tag-face ((t (:foreground "blue"))))
 '(rg-filename-face ((t (:foreground "purple"))))
 '(rg-info-face ((t (:foreground "green"))))
 '(rg-match-face ((t (:foreground "gold"))))
 '(showtip-face ((((class color)) (:inherit tooltip :background "darkred" :foreground "white" :height 1.4))))
 '(speedbar-file-face ((((class color) (background dark)) (:foreground "SeaGreen2"))))
 '(speedbar-highlight-face ((((class color) (background dark)) (:background "LightGoldenrod" :foreground "black"))))
 '(speedbar-selected-face ((((class color) (background dark)) (:foreground "Cyan" :underline t))))
 '(speedbar-separator-face ((((class color) (background dark)) (:background "DarkRed" :foreground "white" :overline "gray"))))
 '(top-mode-mark-face (quote isearch))
 '(vr/group-0 ((t (:background "red" :foreground "black"))))
 '(vr/group-1 ((t (:background "gold2" :foreground "black"))))
 '(vr/group-2 ((t (:background "dodgerblue" :foreground "black"))))
 '(vr/match-0 ((t (:background "green4" :foreground "black"))))
 '(vr/match-1 ((t (:background "green4" :foreground "black"))))
 '(w3m-anchor ((((class color) (background dark)) (:foreground "DodgerBlue2" :underline t))))
 '(w3m-arrived-anchor ((((class color) (background dark)) (:foreground "Purple4" :underline t))))
 '(w3m-bold ((t (:foreground "Green3" :weight bold))))
 '(w3m-current-anchor ((t (:box (:line-width -1 :color "Grey30") :underline t))))
 '(w3m-form ((((class color) (background dark)) (:foreground "Red" :box nil :underline "DarkRed"))))
 '(w3m-form-button ((((type x w32 mac) (class color)) (:background "black" :foreground "LawnGreen" :box (:line-width -1 :color "#014500" :style released-button)))))
 '(w3m-form-button-mouse ((((type x w32 mac) (class color)) (:background "Black" :foreground "Red" :box (:line-width -1 :color "Grey30" :style released-button)))))
 '(w3m-form-button-pressed ((((type x w32 mac) (class color)) (:background "Black" :foreground "DarkRed" :box (:line-width -1 :color "Grey60" :style pressed-button)))))
 '(w3m-form-face ((((class color) (background dark)) (:foreground "khaki2" :underline "brown"))) t)
 '(w3m-header-line-location-content ((((class color) (background dark)) (:background "black" :foreground "Green"))))
 '(w3m-header-line-location-title ((((class color) (background dark)) (:background "black" :foreground "brown"))))
 '(w3m-history-current-url ((t (:background "black" :foreground "DodgerBlue"))))
 '(w3m-image ((((class color) (background dark)) (:background "Black" :foreground "DarkRed"))))
 '(w3m-image-anchor ((((class color) (background dark)) (:background "Black"))))
 '(w3m-link-numbering ((((class color) (background dark)) (:background "Black" :foreground "Grey"))))
 '(w3m-session-select ((((class color) (background dark)) (:foreground "grey50"))))
 '(w3m-tab-background ((((type x w32 mac) (class color)) (:background "black" :foreground "black"))))
 '(w3m-tab-mouse ((((type x w32 mac) (class color)) (:background "DarkRed" :foreground "white" :box (:line-width -1 :color "Red" :style released-button)))))
 '(w3m-tab-selected ((t (:inherit tabbar-default :background "black" :foreground "green2" :box (:line-width 1 :color "#10650F")))))
 '(w3m-tab-selected-background ((((type x w32 mac) (class color)) (:background "black" :foreground "black"))))
 '(w3m-tab-selected-retrieving ((((type x w32 mac) (class color)) (:background "black" :foreground "grey80" :box (:line-width -1 :color "Grey40" :style released-button)))))
 '(w3m-tab-unselected ((t (:inherit tabbar-default :background "black" :foreground "#10650F" :box (:line-width 1 :color "#10650F")))))
 '(w3m-tab-unselected-retrieving ((t (:inherit tabbar-default :background "black" :foreground "grey30" :box (:line-width 1 :color "grey30")))))
 '(w3m-tab-unselected-unseen ((t (:inherit tabbar-default :background "black" :foreground "DodgerBlue" :box (:line-width 1 :color "#10650F")))))
 '(web-mode-block-attr-name-face ((t (:foreground "#51D117"))))
 '(web-mode-block-face ((t (:background "black"))))
 '(web-mode-html-attr-equal-face ((t (:foreground "grey50"))))
 '(web-mode-html-tag-bracket-face ((t (:foreground "grey50"))))
 '(whitespace-highlight ((((class color) (background dark)) (:background "yellow2" :foreground "black"))))
 '(widget-field ((((class grayscale color) (background dark)) (:background "grey10" :foreground "DeepSkyBlue"))))
 '(widget-single-line-field ((((class grayscale color) (background dark)) (:background "grey10" :foreground "DeepSkyBlue"))))
 '(woman-addition ((t (:foreground "Gold3"))))
 '(woman-bold ((((background dark)) (:foreground "Green3" :weight bold))))
 '(woman-italic ((((background dark)) (:foreground "DarkRed" :underline t))))
 '(woman-unknown ((((min-colors 88) (background dark)) (:foreground "Cyan3"))))
 '(xgtags-file-face ((((class color) (background dark)) (:foreground "Grey50"))))
 '(xgtags-file-selected-face ((t (:foreground "Grey70" :weight bold))))
 '(xgtags-line-face ((((class color) (background dark)) (:foreground "khaki4"))))
 '(xgtags-line-number-face ((((class color) (background dark)) (:foreground "DarkRed"))))
 '(xgtags-line-number-selected-face ((t (:foreground "Red" :weight bold))))
 '(xgtags-line-selected-face ((t (:foreground "khaki"))))
 '(xgtags-match-face ((((class color) (background dark)) (:foreground "Green4"))))
 '(xgtags-match-selected-face ((t (:foreground "Green" :weight bold))))
 '(xref-keyword-face ((t (:foreground "grey"))) t)
 '(xref-list-pilot-face ((t (:foreground "gold"))) t)
 '(xref-list-symbol-face ((t (:foreground "green"))) t)
 '(yas/field-highlight-face ((t (:background "grey20" :foreground "gold"))))
 '(yas/mirror-highlight-face ((t (:background "brown" :foreground "white")))))
