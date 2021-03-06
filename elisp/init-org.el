;; init-org.el
(use-package org
  :preface
  (defun hot-expand (str &optional mod)
    "Expand org template."
    (let (text)
      (when (region-active-p)
        (setq text (buffer-substring (region-beginning) (region-end)))
        (delete-region (region-beginning) (region-end)))
      (insert str)
      (org-try-structure-completion)
      (when mod (insert mod) (forward-line))
      (when text (insert text))))
  :bind (("C-c a" . org-agenda)
	 ("C-c o l" . org-store-link)
	 ("C-c t v" . org-tags-view)
	 )
  :config
  (progn
    ;; when opening a org file, don't collapse headings
    (setq org-startup-folded nil)
    ;; wrap long lines. don't let it disappear to the right
    (setq org-startup-truncated t)
    ;; when in a url link, enter key should open it
    (setq org-return-follows-link t)
    ;; make org-mode” syntax color embedded source code
    (setq org-src-fontify-natively t)
    ;; how the source code edit buffer is displayed
    (setq org-src-window-setup "current-window")
    ))

(use-package org-src
  :hook ((org-mode . (lambda ()
                       "Beautify Org Checkbox Symbol"
		       (local-set-key (kbd "C-<tab>") 'yas/expand-from-trigger-key)
		       (local-set-key (kbd "C-c o e") 'org-edit-src-code)
		       (local-set-key (kbd "C-c o i") 'org-insert-src-block)
		       ))
         (org-indent-mode . (lambda()
                              (diminish 'org-indent-mode)
                              ;; WORKAROUND: Prevent text moving around while using brackets
                              ;; @see https://github.com/seagle0128/.emacs.d/issues/88
                              (make-variable-buffer-local 'show-paren-mode)
                              (setq show-paren-mode nil))))
  :custom
  (org-src-fontify-natively t)
  (org-src-tab-acts-natively t)
  (org-edit-src-content-indentation 0)
  :config
  (add-to-list 'org-src-lang-modes '("html" . web))
  ;;; org code block
  (defun org-insert-src-block (src-code-type)
    "Insert a `SRC-CODE-TYPE' type source code block in org-mode."
    (interactive
     (let ((src-code-types
	    '("emacs-lisp" "python" "C" "shell" "java" "js" "clojure" "C++" "css"
	      "calc" "asymptote" "dot" "gnuplot" "ledger" "lilypond" "mscgen"
	      "octave" "oz" "plantuml" "R" "sass" "screen" "sql" "awk" "ditaa"
	      "haskell" "latex" "lisp" "matlab" "ocaml" "org" "perl" "ruby"
	      "scheme" "sqlite" "html")))
       (list (ido-completing-read "Source code type: " src-code-types))))
    (save-excursion
      (newline-and-indent)
      (insert (format "#+BEGIN_SRC %s\n" src-code-type))
      (newline-and-indent)
      (insert "#+END_SRC\n")
      (previous-line 2)
      (org-edit-src-code))))

(use-package org-habit
  :init
  (setq org-habit-show-habits t
	org-habit-show-all-today nil
	org-habit-graph-column 75
	org-habit-preceding-days 30
	org-habit-following-days 1
        org-habit-today-glyph ?@)
  :config
  (defvar my/org-habit-show-graphs-everywhere nil)

  (defun my/org-agenda-mark-habits ()
    (when (and my/org-habit-show-graphs-everywhere
	       (not (get-text-property (point) 'org-series)))
      (let ((cursor (point))
	    item data)
	(while (setq cursor (next-single-property-change cursor 'org-marker))
	  (setq item (get-text-property cursor 'org-marker))
	  (when (and item (org-is-habit-p item))
	    (with-current-buffer (marker-buffer item)
	      (setq data (org-habit-parse-todo item)))
	    (put-text-property cursor
			       (next-single-property-change cursor 'org-marker)
			       'org-habit-p data))))))
  (advice-add #'org-agenda-finalize :before #'my/org-agenda-mark-habits))

;; repeating task
(defun diary-last-day-of-month (date)
  "Return `t` if DATE is the last day of the month."
  (let* ((day (calendar-extract-day date))
         (month (calendar-extract-month date))
         (year (calendar-extract-year date))
         (last-day-of-month
          (calendar-last-day-of-month month year)))
    (= day last-day-of-month)))

;; org-bable
(org-babel-do-load-languages
 'org-babel-load-languages
 '((scheme . t)
   (latex . t)
   (css . t)
   (ruby . t)
   (shell . t)
   (python . t)
   (emacs-lisp . t)
   (matlab . t)
   (C . t)
   (ledger . t)
   (org . t)
   ))

(setq org-confirm-babel-evaluate nil)

;; org clock
;; Resume clocking task when emacs is restarted
(org-clock-persistence-insinuate)
(setq org-clock-in-resume t)
(setq org-clock-out-when-done t)
;; Save the running clock and all clock history when exiting Emacs, load it on startup
(setq org-clock-persist t)
;; Do not prompt to resume an active clock
(setq org-clock-persist-query-resume nil)
;; Enable auto clock resolution for finding open clocks
(setq org-clock-auto-clock-resolution (quote when-no-clock-is-running))
;; Include current clocking task in clock reports
(setq org-clock-report-include-clocking-task t)

;; Show the clocked-in task - if any - in the header line
(setq org-clock-out-remove-zero-time-clocks t)

(defun my/show-org-clock-in-header-line ()
  (setq-default header-line-format '((" " org-mode-line-string " "))))


(defun my/hide-org-clock-from-header-line ()
  (setq-default header-line-format nil))

(add-hook 'org-clock-in-hook 'my/show-org-clock-in-header-line)
(add-hook 'org-clock-out-hook 'my/hide-org-clock-from-header-line)
(add-hook 'org-clock-cancel-hook 'my/hide-org-clock-from-header-line)

(use-package org-pomodoro
  :ensure t
  :init
  (setq org-pomodoro-length 50
	org-pomodoro-short-break-length 5
	org-pomodoro-long-break-length 15
	org-pomodoro-long-break-frequency 4
	org-pomodoro-ask-upon-killing t
	org-pomodoro-ticking-sound-p t
	org-pomodoro-ticking-sound (concat user-emacs-directory "/pomodoro/ticking.m4a")
	org-pomodoro-finished-sound (concat user-emacs-directory "/pomodoro/alarm.m4a")
	org-pomodoro-short-break-sound (concat user-emacs-directory "/pomodoro/alarm.m4a")
	org-pomodoro-long-break-sound (concat user-emacs-directory "/pomodoro/alarm.m4a")
	;; org-pomodoro-start-sound (concat user-emacs-directory "/pomodoro/alarm.m4a")
	)
  (define-key org-agenda-mode-map "P" 'org-pomodoro))

;;; ==========================================================================
;;; Org Mode for GTD

(require 'find-lisp)
(setq jethro/org-agenda-directory (expand-file-name "~/iCloud/"))

(setq org-agenda-files '("~/iCloud/org/task.org" "~/iCloud/org/project.org" "~/iCloud/org/inbox.org" "~/iCloud/org/someday.org" "~/iCloud/org/review.org"))

(setq org-src-fontify-natively t)
(setq org-agenda-window-setup 'current-window)
(setq org-directory "~/iCloud/org/")

;;; Stage 1: Collecting

(setq org-capture-templates
      '(("i" "inbox" entry (file "~/iCloud/org/inbox.org")
	 "* TODO %?" :clock-resume t)
	("t" "task" entry (file "~/iCloud/org/task.org")
	 "* TODO %?" :clock-resume t)
	("s" "someday" entry (file "~/iCloud/org/someday.org")
	 "* TODO %?" :clock-resume t)
	("a" "appointment" entry (file "~/iCloud/org/task.org")
	 "* APPT %?")
	("p" "project" entry (file "~/iCloud/org/project.org")
	 "* PROJ %? [%]\n** TODO" :clock-resume t)
	("h" "habit" entry (file "~/iCloud/org/task.org")
	 "* TODO %?\n  :PROPERTIES:\n  :CATEGORY: Habit\n  :STYLE: habit\n  :REPEAT_TO_STATE: TODO\n  :END:\n  :LOGBOOK:\n  - Added %U\n  :END:"
	 )
	("j" "Journal" entry (file+datetree "~/iCloud/blog_site/org/draft/journal.org")
         "* %?\nEntered on %U\n\n")	
	("m" "Morning Journal" entry (file+datetree "~/iCloud/blog_site/org/draft/journal.org")
         "* 晨间记录\nEntered on %U\n\n天气:%? / 温度: / 地点:\n\n")
	("e" "Evening Journal" entry (file+datetree "~/iCloud/blog_site/org/draft/journal.org")
	 "* 晚间总结\nEntered on %U\n\n*1.最影响情绪的事是什么?*\n\n/正面:/%?\n\n/负面:/\n\n*2.今天做了什么?*\n\n/日常行为:/\n\n/突发行为:/\n\n*3.今天思考了什么?*\n")
	))

;;; Stage 2: Processing

;; Org Agenda Reading view


;; keywords

(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "APPT(a)" "PROJ(p)" "NOTE(N)" "|" "DONE(d)")
        (sequence "WAITING(w@/!)" "DEFFERED(f@/!)" "|" "CANCELLED(c@/!)")))

(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
	      ("NEXT" :foreground "blue" :weight bold)
	      ("DONE" :foreground "forest green" :weight bold)
	      ("APPT" :foreground "orange" :weight bold)
	      ("PROJ" :foreground "sky blue" :weight bold)
	      ("NOTE" :foreground "grey" :weight bold)
	      ("WAITING" :foreground "magenta" :weight bold)
	      ("CANCELLED" :foreground "forest green" :weight bold)
	      ("DEFFERED" :foreground "forest green" :weight bold)
	      )))

(setq org-log-done 'time)
(setq org-log-into-drawer t)
(setq org-log-state-notes-insert-after-drawers nil)

;; priority

;; 优先级范围和默认任务的优先级
(setq org-highest-priority ?A)
(setq org-lowest-priority  ?C)
(setq org-default-priority ?B)
;; 优先级醒目外观
(setq org-priority-faces
      '((?A . (:background "red" :foreground "white" :weight bold))
	(?B . (:background "DarkOrange" :foreground "white" :weight bold))
	(?C . (:background "SkyBlue" :foreground "black" :weight bold))
	))

;; effort
(setq org-global-properties (quote (("Effort_ALL" . "0:15 0:30 0:45 1:00 2:00 3:00 4:00 5:00 6:00 0:00")
				    ("STYLE_ALL" . "habit"))))


;; The Process
					; Step 1: Clarifying

(define-key org-mode-map (kbd "C-c C-q") 'counsel-org-tag)
;; 标签设置的细不一定好，关键要对自己有意义。
(setq org-tag-alist (quote ((:startgroup)
			    ("@study" . ?s)
			    ("@hack" . ?h)
			    ("@free" . ?f)
			    ("@work" . ?w)
			    (:endgroup)
			    (:newline)
			    (:startgroup)
			    ("monthly" . ?M)
			    ("weekly" . ?W)
			    (:endgroup)
                            (:newline)
			    ("#think" . ?t) ;; 需要思考的问题
			    ("#buy" . ?b) ;; 需要买的东西
			    )))

(setq org-fast-tag-selection-single-key nil)

					; Step 2: Organizing

(setq org-refile-use-outline-path 'file)
(setq org-outline-path-complete-in-steps nil)
;; (setq org-refile-allow-creating-parent-nodes 'confirm)
(setq org-refile-allow-creating-parent-nodes nil)
;; (setq org-refile-targets '(
;; 			   ("gtd.org" :maxlevel . 1)
;; 			   ("someday.org" :level . 1)
;; 			   ("bookmark.org" :maxlevel . 2)))

(setq org-refile-targets '(("task.org" :level . 0)
			   ("someday.org" :level . 0)
			   ("project.org" :level . 1)
			   ))

;; ;; my org-agenda process function
;; (defun my/org-task-someday-todo ()
;;   (interactive)
;;   (org-refile )
;;   )

;; (defun my/org-task-monthly-todo ()
;;   )

(defvar jethro/org-agenda-bulk-process-key ?f
  "Default key for bulk processing inbox items.")

;; (defun jethro/org-process-inbox ()
;;   "Called in org-agenda-mode, processes all inbox items."
;;   (interactive)
;;   (org-agenda-bulk-mark-regexp "inbox:")
;;   (jethro/bulk-process-entries))

(defun jethro/org-process-inbox ()
  "Called in org-agenda-mode, processes all inbox items."
  (interactive)
  (org-agenda-set-tags)
  (org-agenda-set-effort)
  (org-agenda-refile)
  )

(defvar jethro/org-current-effort "1:00" "Current effort for agenda items.")

(defun jethro/my-org-agenda-set-effort (effort)
  "Set the effort property for the current headline."
  (interactive
   (list (read-string (format "Effort [%s]: " jethro/org-current-effort) nil nil jethro/org-current-effort)))
  (setq jethro/org-current-effort effort)
  (org-agenda-check-no-diary)
  (let* ((hdmarker (or (org-get-at-bol 'org-hd-marker)
                       (org-agenda-error)))
         (buffer (marker-buffer hdmarker))
         (pos (marker-position hdmarker))
         (inhibit-read-only t)
         newhead)
    (org-with-remote-undo buffer
      (with-current-buffer buffer
        (widen)
        (goto-char pos)
        (org-show-context 'agenda)
        (funcall-interactively 'org-set-effort nil jethro/org-current-effort)
        (end-of-line 1)
        (setq newhead (org-get-heading)))
      (org-agenda-change-all-lines newhead hdmarker))))

(defun jethro/org-agenda-process-inbox-item ()
  "Process a single item in the org-agenda."
  (org-with-wide-buffer
   (org-agenda-set-tags)
   (org-agenda-priority)
   (call-interactively 'jethro/my-org-agenda-set-effort)
   (org-agenda-refile nil nil t)))

(defun jethro/bulk-process-entries ()
  (if (not (null org-agenda-bulk-marked-entries))
      (let ((entries (reverse org-agenda-bulk-marked-entries))
            (processed 0)
            (skipped 0))
        (dolist (e entries)
          (let ((pos (text-property-any (point-min) (point-max) 'org-hd-marker e)))
            (if (not pos)
                (progn (message "Skipping removed entry at %s" e)
                       (cl-incf skipped))
              (goto-char pos)
              (let (org-loop-over-headlines-in-active-region) (funcall 'jethro/org-agenda-process-inbox-item))
              ;; `post-command-hook' is not run yet.  We make sure any
              ;; pending log note is processed.
              (when (or (memq 'org-add-log-note (default-value 'post-command-hook))
                        (memq 'org-add-log-note post-command-hook))
                (org-add-log-note))
              (cl-incf processed))))
        (org-agenda-redo)
        (unless org-agenda-persistent-marks (org-agenda-bulk-unmark-all))
        (message "Acted on %d entries%s%s"
                 processed
                 (if (= skipped 0)
                     ""
                   (format ", skipped %d (disappeared before their turn)"
                           skipped))
                 (if (not org-agenda-persistent-marks) "" " (kept marked)")))
    ))

(defun jethro/org-inbox-capture ()
  (interactive)
  "Capture a task in agenda mode."
  (org-capture nil "i"))

(setq org-agenda-bulk-custom-functions `((,jethro/org-agenda-bulk-process-key jethro/org-agenda-process-inbox-item)))

(defun my/make-someday-task-active ()
  "make someday project active"
  (interactive)
  (org-agenda-set-tags "SOMEDAY")
  (org-agenda-todo "NEXT"))

(defun my/make-someday-task-inactive ()
  "make someday project active"
  (interactive)
  (org-agenda-set-tags "SOMEDAY")
  (org-agenda-todo "TODO"))

(define-key org-agenda-mode-map "r" 'jethro/org-process-inbox)
;; (define-key org-agenda-mode-map "R" 'org-agenda-refile)
(define-key org-agenda-mode-map "c" 'jethro/org-inbox-capture)
(define-key org-agenda-mode-map "+" 'my/make-someday-task-active)
(define-key org-agenda-mode-map "-" 'my/make-someday-task-inactive)

;; Clocking in

(defun jethro/set-todo-state-next ()
  "Visit each parent task and change NEXT states to TODO"
  (org-todo "NEXT"))

(add-hook 'org-clock-in-hook 'jethro/set-todo-state-next 'append)

;;; Stage 3: Reviewing

;; Custom agenda Commands
(use-package org-super-agenda
  :ensure t
  :init (setq org-super-agenda-groups t)
  :config (org-super-agenda-mode t))

(setq org-agenda-skip-scheduled-if-done t
      org-agenda-skip-deadline-if-done t
      org-agenda-include-deadlines t
      org-agenda-include-diary nil
      org-agenda-block-separator nil
      org-agenda-compact-blocks t
      org-agenda-start-with-log-mode t)

(setq org-agenda-custom-commands
      '(("o" "Main Agenda"
         ((agenda "" ((org-agenda-span 'day)
		      (org-super-agenda-groups
                       '((:name "Daily Agenda"
                                :time-grid t
		      		:habit t
                                :order 1)
		      	 (:name "Due Today"
                                :deadline today
                                :order 2)
                         (:name "Overdue"
                                :deadline past
                                :order 3)
                         (:name "Due Soon"
                                :deadline future
                                :order 4)
			 (:name "Important!"
				:priority "A"
				:order 5)
		      	 (:discard (:anything t))
		      	 ))
                      ))
	  (alltodo "" ((org-agenda-overriding-header "")
		       (org-super-agenda-groups
			'((:name "Weekly rewards"
				 :tag "#reward")
			  (:discard (:anything t))
			  ))))
	  (alltodo "" ((org-agenda-overriding-header "")
		       (org-super-agenda-groups
			'((:name "Important!"
				 :priority "A")
			  (:name "handly todo"
				 :and (:category ("Task") :date nil :not (:habit t)))
			  (:discard (:anything t))
			  ))))
	  (alltodo "" ((org-agenda-overriding-header "")
		       (org-agenda-skip-function 'jethro/org-agenda-skip-all-siblings-but-first)
		       (org-super-agenda-groups
			'((:name "Project review"
				 :and (:category "Project"))
			  (:discard (:anything t))
			  ))))
	  )
	 ((org-agenda-files '("~/iCloud/org/task.org" "~/iCloud/org/project.org"))))

	("r" "Review Agenda"
	 ((agenda "" ((org-agenad-span 7)
		      (org-super-agenda-groups
                       '((:name ""
                                :time-grid t)
		      	 ))))
	  (alltodo "" ((org-agenda-overriding-header "")
		       (org-super-agenda-groups
			'((:name "Monthly plan"
				 :and (:tag "monthly" :category ("Plan")))
			  (:name "Weekly plan"
				 :and (:tag "weekly" :category ("Plan")))
			  (:discard (:anything t))
			  )))))
	 ((org-agenda-files '("~/iCloud/org/review.org" "~/iCloud/org/project.org" "~/iCloud/org/task.org"))))
	
	("i" "Inbox Agenda"
	 ((alltodo "" ((org-agenda-overriding-header "Inbox Agenda")
		       (org-super-agenda-groups
			'((:name "Need to handle:"
				 :category "Inbox")
			  ))
		       )))
	 ((org-agenda-files '("~/iCloud/org/inbox.org"))))
	
	("p" "Someday/Maybe Agenda"
	 ((alltodo "" ((org-agenda-overriding-header "Someday/Maybe Agenda")
		       (org-super-agenda-groups
			'((:name "Goods to buy"
				 :tag "#buy")
			  (:name "Books to read"
				 :tag "#book")
			  ))
		       )))
	 ((org-agenda-files '("~/iCloud/org/someday.org"))))
	))

(defun jethro/org-agenda-skip-all-siblings-but-first ()
  "Skip all but the first non-done entry."
  (let (should-skip-entry)
    (unless (or (org-current-is-todo)
		(not (org-get-scheduled-time (point))))
      (setq should-skip-entry t)) ;; 当前是不是TODO且当前有scheduled time才设置跳过
    (save-excursion
      (while (and (not should-skip-entry) (org-goto-sibling t))
	(when (org-current-is-todo)
	  (setq should-skip-entry t)))) ;; 在当不跳过且走到兄弟节点时循环，如何当前为TODO则跳过。
    (when should-skip-entry
      (or (outline-next-heading)
	  (goto-char (point-max))))))

(defun jethro/org-agenda-skip-all-children-but-heading ()
  "Skip all but heading entry."
  (let (should-skip-entry)
    (unless (or (org-current-is-todo)
		(not (org-get-scheduled-time (point))))
      (setq should-skip-entry t))
    (save-excursion
      (while (and (not should-skip-entry) (org-goto-sibling t))
	(when (org-current-is-todo)
	  (setq should-skip-entry t))))
    (when should-skip-entry
      (or (outline-next-heading)
	  (goto-char (point-max))))))

(defun org-current-is-todo ()
  (string= "TODO" (org-get-todo-state)))

(defun jethro/switch-to-agenda ()
  (interactive)
  (org-agenda nil " ")
  (delete-other-windows))

;; (bind-key "<f1>" 'jethro/switch-to-agenda)

;; Column View

(setq org-columns-default-format "%40ITEM(Task) %Effort(EE){:} %CLOCKSUM(Time Spent) %SCHEDULED(Scheduled) %DEADLINE(Deadline)")

;; ----------------------------------------------------------------
;; org-refile2 advise

(advice-add 'org-refile :override #'org-refile2)
(defun org-refile2 (&optional arg default-buffer rfloc msg)
  "Move the entry or entries at point to another heading.

The list of target headings is compiled using the information in
`org-refile-targets', which see.

At the target location, the entry is filed as a subitem of the
target heading.  Depending on `org-reverse-note-order', the new
subitem will either be the first or the last subitem.

If there is an active region, all entries in that region will be
refiled.  However, the region must fulfill the requirement that
the first heading sets the top-level of the moved text.

With a `\\[universal-argument]' ARG, the command will only visit the target \
location
and not actually move anything.

With a prefix `\\[universal-argument] \\[universal-argument]', go to the \
location where the last
refiling operation has put the subtree.

With a numeric prefix argument of `2', refile to the running clock.

With a numeric prefix argument of `3', emulate `org-refile-keep'
being set to t and copy to the target location, don't move it.
Beware that keeping refiled entries may result in duplicated ID
properties.

RFLOC can be a refile location obtained in a different way.

MSG is a string to replace \"Refile\" in the default prompt with
another verb.  E.g. `org-copy' sets this parameter to \"Copy\".

See also `org-refile-use-outline-path'.

If you are using target caching (see `org-refile-use-cache'), you
have to clear the target cache in order to find new targets.
This can be done with a `0' prefix (`C-0 C-c C-w') or a triple
prefix argument (`C-u C-u C-u C-c C-w')."
  (interactive "P")
  (if (member arg '(0 (64)))
      (org-refile-cache-clear)
    (let* ((actionmsg (cond (msg msg)
			    ((equal arg 3) "Refile (and keep)")
			    (t "Refile")))
	   (regionp (org-region-active-p))
	   (region-start (and regionp (region-beginning)))
	   (region-end (and regionp (region-end)))
	   (org-refile-keep (if (equal arg 3) t org-refile-keep))
	   pos it nbuf file level reversed)
      (setq last-command nil)
      (when regionp
	(goto-char region-start)
	(beginning-of-line)
	(setq region-start (point))
	(unless (or (org-kill-is-subtree-p
		     (buffer-substring region-start region-end))
		    (prog1 org-refile-active-region-within-subtree
		      (let ((s (point-at-eol)))
			(org-toggle-heading)
			(setq region-end (+ (- (point-at-eol) s) region-end)))))
	  (user-error "The region is not a (sequence of) subtree(s)")))
      (if (equal arg '(16))
	  (org-refile-goto-last-stored)
	(when (or
	       (and (equal arg 2)
		    org-clock-hd-marker (marker-buffer org-clock-hd-marker)
		    (prog1
			(setq it (list (or org-clock-heading "running clock")
				       (buffer-file-name
					(marker-buffer org-clock-hd-marker))
				       ""
				       (marker-position org-clock-hd-marker)))
		      (setq arg nil)))
	       (setq it
		     (or rfloc
			 (let (heading-text)
			   (save-excursion
			     (unless (and arg (listp arg))
			       (org-back-to-heading t)
			       (setq heading-text-origin
				     (replace-regexp-in-string
				      org-link-bracket-re
				      "\\2"
				      (or (nth 4 (org-heading-components))
					  "")))
			       (setq heading-text
				     (if (> (length heading-text-origin) 10)
					 (concat (substring heading-text-origin
							    0 10) "....")
				       heading-text-origin)))
			     (org-refile-get-location
			      (cond ((and arg (listp arg)) "Goto")
				    (regionp (concat actionmsg " region to"))
				    (t (concat actionmsg " subtree \""
					       heading-text "\" to")))
			      default-buffer
			      (and (not (equal '(4) arg))
				   org-refile-allow-creating-parent-nodes)))))))
	  (setq file (nth 1 it)
		pos (nth 3 it))
	  (when (and (not arg)
		     pos
		     (equal (buffer-file-name) file)
		     (if regionp
			 (and (>= pos region-start)
			      (<= pos region-end))
		       (and (>= pos (point))
			    (< pos (save-excursion
				     (org-end-of-subtree t t))))))
	    (error "Cannot refile to position inside the tree or region"))
	  (setq nbuf (or (find-buffer-visiting file)
			 (find-file-noselect file)))
	  (if (and arg (not (equal arg 3)))
	      (progn
		(pop-to-buffer-same-window nbuf)
		(goto-char (cond (pos)
				 ((org-notes-order-reversed-p) (point-min))
				 (t (point-max))))
		(org-show-context 'org-goto))
	    (if regionp
		(progn
		  (org-kill-new (buffer-substring region-start region-end))
		  (org-save-markers-in-region region-start region-end))
	      (org-copy-subtree 1 nil t))
	    (with-current-buffer (setq nbuf (or (find-buffer-visiting file)
						(find-file-noselect file)))
	      (setq reversed (org-notes-order-reversed-p))
	      (org-with-wide-buffer
	       (if pos
		   (progn
		     (goto-char pos)
		     (setq level (org-get-valid-level (funcall outline-level) 1))
		     (goto-char
		      (if reversed
			  (or (outline-next-heading) (point-max))
			(or (save-excursion (org-get-next-sibling))
			    (org-end-of-subtree t t)
			    (point-max)))))
		 (setq level 1)
		 (if (not reversed)
		     (goto-char (point-max))
		   (goto-char (point-min))
		   (or (outline-next-heading) (goto-char (point-max)))))
	       (unless (bolp) (newline))
	       (org-paste-subtree level nil nil t)
	       ;; Record information, according to `org-log-refile'.
	       ;; Do not prompt for a note when refiling multiple
	       ;; headlines, however.  Simply add a time stamp.
	       (cond
		((not org-log-refile))
		(regionp
		 (org-map-region
		  (lambda () (org-add-log-setup 'refile nil nil 'time))
		  (point)
		  (+ (point) (- region-end region-start))))
		(t
		 (org-add-log-setup 'refile nil nil org-log-refile)))
	       (and org-auto-align-tags
		    (let ((org-loop-over-headlines-in-active-region nil))
		      (org-align-tags)))
	       (let ((bookmark-name (plist-get org-bookmark-names-plist
					       :last-refile)))
		 (when bookmark-name
		   (with-demoted-errors
		       (bookmark-set bookmark-name))))
	       ;; If we are refiling for capture, make sure that the
	       ;; last-capture pointers point here
	       (when (bound-and-true-p org-capture-is-refiling)
		 (let ((bookmark-name (plist-get org-bookmark-names-plist
						 :last-capture-marker)))
		   (when bookmark-name
		     (with-demoted-errors
			 (bookmark-set bookmark-name))))
		 (move-marker org-capture-last-stored-marker (point)))
	       (when (fboundp 'deactivate-mark) (deactivate-mark))
	       (run-hooks 'org-after-refile-insert-hook)))
	    (unless org-refile-keep
	      (if regionp
		  (delete-region (point) (+ (point) (- region-end region-start)))
		(org-preserve-local-variables
		 (delete-region
		  (and (org-back-to-heading t) (point))
		  (min (1+ (buffer-size)) (org-end-of-subtree t t) (point))))))
	    (when (featurep 'org-inlinetask)
	      (org-inlinetask-remove-END-maybe))
	    (setq org-markers-to-move nil)
	    (message "%s to \"%s\" in file %s: done" actionmsg
		     (car it) file)))))))

;; ----------------------------------------------------------------

;;; Stage 4: Doing

;; Org-pomodoro

;;; =========================================================================
;; other package and config

;; org html export
(setq org-html-head-include-scripts nil)
(setq org-html-head-include-default-style nil)
(setq org-html-htmlize-output-type nil) ;; 导出时不加行间样式！
(setq org-html-doctype "html5")
(setq org-html-html5-fancy t)
(setq user-full-name "Kinney Zhang")
(setq user-mail-address "kinneyzhang666@gmail.com")
(setq org-export-with-author nil)
(setq org-export-with-email nil)
(setq org-export-with-date nil)
(setq org-export-with-creator nil)
(setq org-html-validation-link nil)
(setq org-export-backends '(ascii html icalendar latex md))

(use-package org-bullets
  :ensure t
  :init (setq org-bullets-bullet-list '("◉" "○"	"✸" "✿"))
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package org-agenda-property
  :ensure t
  :bind (("C-c o p" . org-property-action)))

(use-package calfw-org
  :ensure t
  :defer t
  :bind (("C-x c c" . my-open-calendar))
  :config
  (defun my-open-calendar ()
    (interactive)
    (cfw:open-calendar-buffer
     :contents-sources
     (list
      (cfw:org-create-source "#FFFFFF")))))

(use-package calfw
  :ensure t
  :defer t)

(use-package move-text
  :ensure t
  :defer 5
  :config (move-text-default-bindings))

(use-package htmlize
  :ensure t
  :defer 5)

(use-package idle-org-agenda
  :after org-agenda
  :ensure t
  :init (setq idle-org-agenda-interval 6000
	      idle-org-agenda-key "o")
  :config (idle-org-agenda-mode))

;; org journal
;; (use-package org-journal
;;   :ensure t
;;   :custom
;;   (org-journal-dir "~/iCloud/journal/")
;;   (org-journal-date-format "%A, %d %B %Y")
;;   :init
;;   (setq org-journal-enable-agenda-integration nil)
;;   :bind (("C-c j c" . calendar)
;; 	 ("C-c j t" . journal-file-today)
;; 	 ("C-c j y" . journal-file-yesterday)))

;; (defun org-journal-find-location ()
;;   (org-journal-new-entry t)
;;   (goto-char (point-min)))

(defun org-display-subtree-inline-images ()
  "Toggle the display of inline images.
INCLUDE-LINKED is passed to `org-display-inline-images'."
  (interactive)
  (save-excursion
    (save-restriction
      (org-narrow-to-subtree)
      (let* ((beg (point-min))
             (end (point-max))
             (image-overlays (cl-intersection
                              org-inline-image-overlays
                              (overlays-in beg end))))
        (if image-overlays
            (progn
              (org-remove-inline-images)
              (message "Inline image display turned off"))
          (org-display-inline-images t t beg end)
          (setq image-overlays (cl-intersection
                                org-inline-image-overlays
                                (overlays-in beg end)))
          (if (and (org-called-interactively-p) image-overlays)
              (message "%d images displayed inline"
                       (length image-overlays))))))))

(provide 'init-org)

