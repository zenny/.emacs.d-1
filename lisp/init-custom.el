;;自定义属性

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(company-idle-delay 0.1)
 '(company-minimum-prefix-length 2)
 '(compilation-message-face (quote default))
 '(custom-enabled-themes (quote (leuven)))
 '(custom-safe-themes
   (quote
    ("9a155066ec746201156bb39f7518c1828a73d67742e11271e4f24b7b178c4710" "bd7b7c5df1174796deefce5debc2d976b264585d51852c962362be83932873d9" default)))
 '(evil-leader/leader "SPC")
 '(evil-want-C-u-scroll t)
 '(fci-rule-color "#3C3D37")
 '(fringe-mode 0 nil (fringe))
 '(gdb-enable-debug t)
 '(gdb-many-windows t)
 '(gdb-speedbar-auto-raise t)
 '(gnus-nntp-server "news.yaako.com")
 '(highlight-changes-colors (quote ("#FD5FF0" "#AE81FF")))
 '(highlight-tail-colors
   (quote
    (("#3C3D37" . 0)
     ("#679A01" . 20)
     ("#4BBEAE" . 30)
     ("#1DB4D0" . 50)
     ("#9A8F21" . 60)
     ("#A75B00" . 70)
     ("#F309DF" . 85)
     ("#3C3D37" . 100))))
 '(magit-diff-use-overlays nil)
 '(menu-bar-mode t)
 '(org-agenda-files nil)
 '(org-agenda-window-setup (quote current-window))
 '(org-mobile-directory "")
 '(org-mobile-encryption-password "nrkinney666")
 '(org-pomodoro-ask-upon-killing t)
 '(org-pomodoro-length 50)
 '(org-pomodoro-long-break-length 20)
 '(package-selected-packages
   (quote
    (ccls auto-complete-clang auto-complete evil-nerd-commenter window-numbering powerline-evil powerline which-key diary-manager fcitx csharp-mode abc-mode org-projectile leuven-theme company-ycmd company-anaconda use-package evil evil-leader exec-path-from-shell expand-region flycheck goto-chg helm-ag helm-core hungry-delete iedit js2-refactor memoize multiple-cursors nodejs-repl org-pomodoro pkg-info popup popwin reveal-in-osx-finder ruby-hash-syntax s shell-pop shut-up smartparens swiper web-mode yasnippet pallet dictionary color-theme color-theme-sanityinc-tomorrow monokai-theme company)))
 '(popwin:popup-window-position (quote right))
 '(popwin:popup-window-width 80)
 '(pos-tip-background-color "#FFFACE")
 '(pos-tip-foreground-color "#272822")
 '(shell-pop-default-directory "/Users/kinney")
 '(shell-pop-full-span t)
 '(shell-pop-shell-type
   (quote
    ("terminal" "*terminal*"
     (lambda nil
       (term shell-pop-term-shell)))))
 '(shell-pop-term-shell "/bin/bash")
 '(shell-pop-universal-key "C-t")
 '(shell-pop-window-position "right")
 '(shell-pop-window-size 40)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(tooltip-mode nil)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#F92672")
     (40 . "#CF4F1F")
     (60 . "#C26C0F")
     (80 . "#E6DB74")
     (100 . "#AB8C00")
     (120 . "#A18F00")
     (140 . "#989200")
     (160 . "#8E9500")
     (180 . "#A6E22E")
     (200 . "#729A1E")
     (220 . "#609C3C")
     (240 . "#4E9D5B")
     (260 . "#3C9F79")
     (280 . "#A1EFE4")
     (300 . "#299BA6")
     (320 . "#2896B5")
     (340 . "#2790C3")
     (360 . "#66D9EF"))))
 '(vc-annotate-very-old-color nil t)
 '(weechat-color-list
   (quote
    (unspecified "#272822" "#3C3D37" "#F70057" "#F92672" "#86C30D" "#A6E22E" "#BEB244" "#E6DB74" "#40CAE4" "#66D9EF" "#FB35EA" "#FD5FF0" "#74DBCD" "#A1EFE4" "#F8F8F2" "#F8F8F0"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hl-line ((t (:background "gray91"))))
 '(js2-external-variable ((t (:foreground "dark gray"))))
 '(web-mode-html-attr-name-face ((t (:foreground "light green"))))
 '(web-mode-html-tag-bracket-face ((t (:foreground "keyboardFocusIndicatorColor"))))
 '(web-mode-html-tag-face ((t (:foreground "keyboardFocusIndicatorColor")))))
