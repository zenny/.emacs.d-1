;;; init-blog
;;; auto generate blog's sitemap.xml, post-info, index.org, archive.org, category.org.
;;;===================================================================================
(require 'pp-html)
(require 'pp-xml)

(defvar blog-language "zh-cn")
(defvar blog-generator "Emacs OrgMode 9.1.9")

(defvar blog-name "戈楷旎")
(defvar blog-description "happy hacking emacs!")
(defvar blog-domain "https://geekinney.com/")
(defvar blog-author "Kinney Zhang")
(defvar blog-author-email "kinneyzhang666@gmail.com")

(defvar blog-root-dir "~/iCloud/blog_site/")
(defvar blog-base-dir "~/iCloud/blog_site/org/")
(defvar blog-publish-dir "~/iCloud/blog_site/post/")

(defvar blog-abs-url-prefix
  (concat blog-domain (string-trim blog-publish-dir blog-root-dir)))
(defvar blog-rel-url-prefix
  (concat "/" (string-trim blog-publish-dir blog-root-dir)))
(defvar blog-icon "/static/img/favicon.ico")
(defvar blog-css "/static/light.css")

(defvar ga-script "(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)})(window,document,'script','https://www.google-analytics.com/analytics.js','ga');ga('create', 'UA-149578968-1', 'auto');ga('send', 'pageview');")

;; get valine appid and appkey
(defun geekblog--get-valine-info ()
  "get appId and appKey list"
  (let ((valine-file (concat blog-root-dir "valine"))
	(applist nil))
    (with-temp-buffer
      (insert-file-contents valine-file)
      (goto-char (point-min))
      (setq appid (substring (thing-at-point 'line) 0 -1))
      (next-line)
      (setq appkey (thing-at-point 'line))
      (setq applist `(,appid ,appkey)))
    applist))

(defvar valine-script
  (concat
   "new Valine({
el: '#vcomments',
appId: '" (car (geekblog--get-valine-info)) "',
appKey: '" (cadr (geekblog--get-valine-info)) "',
visitor: true,
notify: true,
verify: false,
avatar: 'identicon',
placeholder: '留下你的评论吧～'
})"))

(defvar other-script
  '((script :src "/static/jQuery.min.js")
    (script "$(document).ready(function(){
var theme = sessionStorage.getItem(\"theme\");
if(theme==\"dark\"){
document.getElementById(\"pagestyle\").href=\"/static/dark.css\";
}else if(theme==\"light\"){
document.getElementById(\"pagestyle\").href=\"/static/light.css\";
}else{
sessionStorage.setItem(\"theme\",\"light\");
}});")))

;; (defun geekblog/publish-file (post) ;; if something changed, generate page(?)

;;   )

(defvar base-head
  `((meta :charset "utf-8")
    (meta :name "viewport" :content "width=device-width, initial-scale=1")
    ;; (title ,title)
    (title "title")
    (meta :name "generator" :content ,blog-generator)
    (meta :name "author" :content ,blog-author)
    (link :rel "shortcut icon" :href ,blog-icon)
    (link :rel "bookmark" :href ,blog-icon :type "image/x-icon")
    (link :rel "stylesheet" :type "text/css" :href ,blog-css)
    (script :data-ad-client "ca-pub-3231589012114037" :src "https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js") ;; 完善没有值的属性的解析。async
    (script ,ga-script)))

(defvar base-menu
  `((div :id "toptitle"
	 (a :id "logo" :href "/" ,blog-name)
	 (p :class "description" ,blog-description))
    (div :id "topnav"
	 (a :href "/index.html" "首页")
	 (a :href "/archive.html" "归档")
	 (a :href "/category.html" "分类")
	 (a :href "/about.html" "关于")
	 (a :href "/message.html" "留言"))))

(defvar main-post
  '((p "main-post")))

(defvar sidebar
  '((div "sidebar")))

(defvar base-comment
  `((div :id "comment-div"
	 (script :src "/static/Valine.min.js")
	 (div :id "vcomment")
	 (script ,valine-script))))

(defvar postamble
  `((p (span :class "dim" "©2019-2020")
       " 戈楷旎 "
       (span :class "dim" "| Licensed under ")
       (a :rel "license" :href "http://creativecommons.org/licenses/by-nc-sa/4.0/"(img :alt "知识共享许可协议" :style "border-width:0" :src "/static/img/license.png")))
    (p :class "creator"
       (span :class "dim" "Generated by")
       (a :href "https://www.gnu.org/software/emacs/" "Emacs")
       " 26.3 (" (a :href "https://orgmode.org" "Org")
       " mode 9.1.9)")
    (:include ,other-script)))

(defvar base-html
  `(html :lang "en"
	 (head (:include ,base-head))
	 (body
	  (div :id "layout"
	       (div :id "org-div-header"
		    (:include ,base-menu))
	       (div :id "content"
		    (div :id "main"
			 (:block main
				 (:include ,main-post)
				 (:include ,base-comment)))
		    (div :id "side"
			 (:include ,sidebar)))
	       (div :id "postamble"
		    (:include ,postamble))))))

;; (pp-html-test base-html)

;; (defvar archive-page
;;   `(:extend main
;; 	    (:include ,archive-format)))

;; (defvar category-page
;;   `(:extend main
;; 	    (:include ,category-format)))

;; (defvar post-page
;;   `(:extend main
;; 	    (:include ,post-format)))


;;;==================================================
(defun geekblog--get-post-meta (meta-list post)
  "get meta info of a post"
  (let ((meta-res))
    (with-temp-buffer
      (insert-file-contents (concat blog-base-dir post))
      (goto-char (point-min))
      (if (not (listp meta-list))
	  (setq meta-list (list meta-list)))
      (dolist (meta meta-list)
	(cond
	 ((string= "count" meta)
	  (progn (setq res (my/word-count))
		 (setq meta-res (append meta-res `(,res)))))
	 ((string= "abs-url" meta) ;; absolute url
	  (progn (setq res (concat blog-abs-url-prefix (file-name-base post) ".html"))
		 (setq meta-res (append meta-res `(,res)))))
	 ((string= "rel-url" meta) ;; relative url
	  (progn (setq res (concat blog-rel-url-prefix (file-name-base post) ".html"))
		 (setq meta-res (append meta-res `(,res)))))
	 ((member meta '("title" "date" "category"))
	  (progn
	    (goto-char (point-min))
	    (re-search-forward (concat ".*#\\+" (upcase meta)) nil t)
	    (setq res (plist-get (cadr (org-element-at-point)) :value))
	    (setq meta-res (append meta-res `(,res)))))
	 (t (error "invalid post meta!"))))
      (if (eq (list-length meta-res) 1)
	  (setq meta-res (car meta-res))))
    meta-res))

;; (geekblog--get-post-meta "date" "at-the-end-of-2019.org")

(defun geekblog--get-post-digest (post num)
  (let ((post-file (concat blog-base-dir post)))
    (with-temp-buffer
      (insert-file-contents post-file)
      (setq buffer-string (replace-regexp-in-string "^.+BEGIN_SRC.+\n\\(.*\n\\)*?.+END_SRC$" "" (buffer-substring-no-properties (point-min) (point-max)))
	    buffer-string (replace-regexp-in-string "^#\\+.+$" "" buffer-string)
	    buffer-string
	    (replace-regexp-in-string "\\(^=\\|=$\\| =\\|= \\|^/\\|/$\\| /\\|/ \\|^*\\|*$\\| \\*\\|\\* \\|^+\\|+$\\| \\+\\|\\+ \\|^~\\|~$\\| ~\\|~ \\|^_\\|_$\\| _\\|_ \\)" "" buffer-string)
	    buffer-string (replace-regexp-in-string "\\(\\[\\[\\|http.+\\]\\[\\|\\]\\]\\)" "" buffer-string)
	    buffer-string (replace-regexp-in-string "^本文转载.+\n" "" buffer-string)
	    buffer-string (replace-regexp-in-string "^http.+\n" "" buffer-string)
	    buffer-string (replace-regexp-in-string "\n+" "" buffer-string))
      (concat (substring buffer-string 0 num) " .... ")
      )))

;;;-----------------------------------------------------------
(defun geekblog--post-info-format (url count title date category)
  "get post info html"
  (pp-html
   `(div :class "post-info"
	 (p "「"
	    (span "分类: " ,category " · ")
	    (span "字数: " ,(number-to-string count) " · ")
	    (span :id ,url
		  :class "leancloud_visitors"
		  :data-flag-title ,title
		  (span :class "post-meta-item-text" "阅读 ")
		  (span :class "leancloud-visitors-count" "...")
		  " 次")
	    "」"))))

(defun geekblog/generate-post-info ()
  "generate post info for each post"
  (let* ((post (buffer-name))
	 (metas (geekblog--get-post-meta '("rel-url" "count" "title" "date" "category") post))
	 (html-str (geekblog--post-info-format (nth 0 metas) (nth 1 metas) (nth 2 metas) (nth 3 metas) (nth 4 metas))))
    html-str))
;;;--------------------------------------------------
(defun geekblog--sitemap-format-part (url date)
  (pp-xml
   `(url (loc ,url)
	 (lastmod ,date)
	 (changefreq "daily")
	 (priority "0.8"))))

(defun geekblog--sitemap-format (posts)
  "get blog sitemap.xml"
  (let ((xml-str))
    (if (stringp posts)
	(setq posts (read posts)))
    (dolist (post posts)
      (progn
	(setq metas (nth 0 (geekblog--get-post-meta '("abs-url" "date") post)))
	(setq xml-str (concat xml-str (geekblog--sitemap-format-part (nth 0 metas) (nth 1 metas))))))
    (concat "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n<urlset xmlns=\"http://www.sitemaps.org/schemas/sitemap/0.9\">\n" xml-str "</urlset>")))

(defun geekblog/generate-sitemap (&optional proj)
  (interactive)
  (let ((xml (concat blog-root-dir "sitemap.xml")))
    (with-temp-buffer
      (insert (geekblog--sitemap-format (geekblog--get-all-posts)))
      (write-file xml))
    (message "sitemap.xml deployed successfully!")))
;;;-------------------------------------------------
(defun geekblog--rss-format-part (title url date digest)
  (pp-html
   `(item (title ,title)
	  (link ,url)
	  (description ,digest)
	  (author ,blog-author)
	  (pubDate ,date))))

(defun geekblog--rss-format-all (xml-str)
  (setq xml-str
	(concat "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\n"
		(pp-xml
		 `(rss :version "2.0"
		       (channel (title ,blog-name)
				(link ,blog-domain)
				(description ,blog-site-description)
				(Webmaster ,blog-author-email)
				(language ,blog-language)
				(generator ,blog-generator)
				(ttl "5")
				(image
				 (url ,blog-icon)
				 (title ,blog-name)
				 (link ,blog-domain)
				 (width "32")
				 (height "32"))
				,xml-str))))))

(defun geekblog--rss-format (posts)
  (let ((xml-str))
    (if (stringp posts)
	(setq posts (read posts)))
    (dolist (post posts)
      (with-temp-buffer
	(setq metas (geekblog--get-post-meta '("title" "abs-url" "date") post))
	(setq digest (geekblog--get-post-digest post 100))
	(setq xml-str (concat xml-str (geekblog--rss-format-part (nth 0 metas) (nth 1 metas) (nth 2 metas) digest)))))
    (geekblog--rss-format-all xml-str)))

(defun geekblog/generate-rss (&optional proj)
  (interactive)
  (let ((rss (concat blog-root-dir "feed.xml")))
    (with-temp-buffer
      (insert (geekblog--rss-format (geekblog--get-all-posts)))
      (write-file rss))
    (message "feed.xml deployed successfully!")
    ))
;;;-------------------------------------------------
(defun list-car-string-more (list1 list2)
  "compare the car of list1 to list2, which is a string"
  (if (string> (car list1) (car list2))
      (eq t t)
    (eq t nil)))

(defun geekblog--get-all-posts ()
  "make all posts a list by date"
  (let ((posts (cdr (cdr (directory-files blog-base-dir))))
	(date-post-list)
	(post-list))
    (dolist (post posts)
      (setq date (geekblog--get-post-meta "date" post))
      (setq date-post-pair `(,date ,post))
      (setq date-post-list (cons date-post-pair date-post-list)))
    (setq date-post-list-sorted (sort date-post-list 'list-car-string-more))
    (dolist (item date-post-list-sorted)
      (setq post-list (append post-list (cdr item))))
    post-list))
;;;--------------------------------------------------
;; (defvar digest-format ;; :for has problem, cannot find valiable post.
;;   `((:for post ,(geekblog--get-all-posts)
;; 	  (div :class "post-div"
;; 	       (h2 (a :href ,(geekblog--get-post-meta "rel-url" post)
;; 		      ,(geekblog--get-post-meta "title" post)))
;; 	       (p ,(geekblog--get-post-digest post 170)
;; 		  (a :href ,(geekblog--get-post-meta "rel-url" post) "「阅读全文」"))
;; 	       (p (code (a :href "/category.html" ,(geekblog--get-post-meta "category" post)))
;; 		  (span :class "post-div-meta"
;; 			(span ,(number-to-string (geekblog--get-post-meta "count" post)) "字 · ")
;; 			(span :class "post-date" ,(geekblog--get-post-meta "date" post))))))))

;; (defvar index-page
;;   `(:extend main
;; 	    (:include ,digest-format)))

(defun geekblog/generate-index-page ()
  (interactive)
  (let ((index-file (concat blog-root-dir "index.html")))
    (with-temp-buffer
      (insert (pp-html index-page))
      (write-file index-file))
    (message "index.html generated successfully!")))
;;;--------------------------------------------------------
;; (defvar archive-format
;;   `((:for year ,(geekblog--get-year-list (geekblog--get-all-posts))
;; 	  (div :class "archive-year"
;; 	       (h2 year
;; 		   (ul
;; 		    (:for 
;; 		     (li ,post-date " "
;; 			 (a :href ,post-url ,post-title)))))
;; 	       ))))

(defun geekblog--get-year-list (posts)
  (let ((year-list))
    (dolist (post posts)
      (setq date (geekblog--get-post-meta "date" post))
      (setq year (substring date 0 4))
      (setq year-list (append year-list (list year))))
    year-list))

;; (defun geekblog--get-year-post-list (posts)
;;   (let ((year-post-list))
;;     ()))

(defun geekblog--archive-format (posts)
  (let ((archive-year-str "")
	(archive-year-str-with-year "")
	(year-list nil)
	(year-and-archive-single-str-list nil))
    (dolist (post posts)
      (setq url (concat "/" (string-trim blog-publish-dir blog-root-dir) (file-name-base post) ".html"))
      (setq title (geekblog--get-post-meta "title" post))
      (setq date (geekblog--get-post-meta "date" post))
      (setq year (substring date 0 4))
      (setq month-and-day (concat (substring date 5 7) (substring date 8 10)))
      (setq archive-single-str (concat " * " month-and-day " [[" url "][" title "]]"))
      (setq year-and-archive-single-str-list (cons `(,year ,archive-single-str) year-and-archive-single-str-list))
      ;; (("2020" " * 0222 [[url][title]]") ("2020" " * 0221 [[url][title]]") ... ("2019" " * 1231 [[url][title]]"))
      (setq year-list (cons year year-list)))
    (setq year-and-archive-single-str-list (reverse year-and-archive-single-str-list))
    (setq year-list (reverse year-list))
    (setq years (delete-dups year-list))
    (dolist (year years)
      (dolist (elem year-and-archive-single-str-list)
	(if (string= year (car elem))
	    (setq archive-year-str (concat archive-year-str (cadr elem) "\n"))))
      (setq archive-year-str-with-year (concat archive-year-str-with-year "* " year "\n" archive-year-str))
      (setq archive-year-str ""))
    (concat "#+TITLE: 文章归档\n#+STARTUP: showall\n#+OPTIONS: toc:nil H:1 num:0 title:nil\n" archive-year-str-with-year)))

(defun geekblog/generate-archive-page (&optional proj)
  (interactive)
  (let ((archive (concat blog-page-dir "archive.org")))
    (with-temp-buffer
      (insert (geekblog--archive-format (geekblog--get-all-posts)))
      (write-file archive))
    (message "archive.org deployed successfully!")))
;;;---------------------------------------------------------
(defun geekblog--category-format (posts)
  "generate blog's category.org string"
  (let ((one-category-str "")
	(category-str-with-category "")
	(category-and-category-single-str-list)
	(category-list))
    (dolist (post posts)
      (setq url (concat "/" (string-trim blog-publish-dir blog-root-dir) (file-name-base post) ".html"))
      (setq title (geekblog--get-post-meta "title" post))
      (setq category (geekblog--get-post-meta "category" post))
      (setq category-single-str (concat " * [[" url "][" title "]]"))
      (setq category-and-category-single-str-list (cons `(,category ,category-single-str) category-and-category-single-str-list))
      (setq category-list (cons category category-list)))
    (setq category-list (sort category-list 'string<))
    (setq categories (delete-dups category-list))
    (dolist (category categories)
      (dolist (elem category-and-category-single-str-list)
	(if (string= category (car elem))
	    (setq one-category-str (concat one-category-str (cadr elem) "\n"))))
      (setq category-str-with-category (concat category-str-with-category "* " category "\n" one-category-str))
      (setq one-category-str ""))
    (concat "#+TITLE: 标签分类\n#+STARTUP: showall\n#+OPTIONS: toc:nil H:1 num:0 title:nil\n" category-str-with-category)))

(defun geekblog/generate-category-page (&optional proj)
  (interactive)
  (let ((category (concat blog-page-dir "category.org")))
    (with-temp-buffer
      (insert (geekblog--category-format (geekblog--get-all-posts)))
      (write-file category))
    (message "category.org deployed successfully!")))
;;;------------------------------------------------------------------
(defun geekblog/push-to-github (&optional proj)
  (progn
    (shell-command "~/iCloud/blog_site/deploy.sh")
    (message "blog deployed successfully!")))

(defun geekblog/publish-project-force (proj)
  (interactive "sEnter the project name: ")
  (org-publish proj t nil))

(defun geekblog/new-post (slug title category)
  (interactive "sinput slug: \nsinput title: \nsinput category: ")
  (let* ((blog-org-dir "~/iCloud/blog_site/org/")
	 (blog-org-file (concat blog-org-dir slug ".org"))
	 (blog-org-created-date (format-time-string "%Y-%m-%d"))
	 (blog-org-head-template (concat "#+TITLE: " title "\n#+DATE: " blog-org-created-date "\n#+CATEGORY: " category "\n#+INCLUDE: \"../code/post-info.org\"\n#+STARTUP: showall\n#+OPTIONS: toc:nil H:2 num:2\n#+TOC: headlines:2\n")))
    (if (file-exists-p blog-org-file)
	(find-file blog-org-file)
      (progn
	(find-file blog-org-file)
	(insert blog-org-head-template)))))
;;;-------------------------------------------------------
;;;==============================================================
;; https://gongzhitaao.org/orgcss/org.css
;; org html export
(setq org-html-head-include-scripts nil)
(setq org-html-head-include-default-style nil)
(setq org-html-htmlize-output-type nil) ;; 导出时不加行间样式！
(setq org-html-doctype "html5")
(setq org-html-html5-fancy t)

(defun org-html-src-block2 (src-block _contents info)
  "Transcode a SRC-BLOCK element from Org to HTML.
		    CONTENTS holds the contents of the item.  INFO is a plist holding
		    contextual information."
  (if (org-export-read-attribute :attr_html src-block :textarea)
      (org-html--textarea-block src-block)
    (let ((lang (org-element-property :language src-block))
	  (code (org-html-format-code src-block info))
	  (label (let ((lbl (and (org-element-property :name src-block)
				 (org-export-get-reference src-block info))))
		   (if lbl (format " id=\"%s\"" lbl) ""))))
      (if (not lang) (format "<pre><code class=\"example\"%s>\n%s</code></pre>" label code)
	(format "<div class=\"col-auto\">\n%s%s\n</div>"
		;; Build caption.
		(let ((caption (org-export-get-caption src-block)))
		  (if (not caption) ""
		    (let ((listing-number
			   (format
			    "<span class=\"listing-number\">%s </span>"
			    (format
			     (org-html--translate "Listing %d:" info)
			     (org-export-get-ordinal
			      src-block info nil #'org-html--has-caption-p)))))
		      (format "<label class=\"org-src-name\">%s%s</label>"
			      listing-number
			      (org-trim (org-export-data caption info))))))
		;; Contents.
		(format "<pre><code class=\"%s\"%s>%s</code></pre>"
			lang label code))))))

(advice-add 'org-html-src-block :override 'org-html-src-block2)
;;-------------------------------------------------------------
(setq user-full-name "Kinney Zhang")
(setq user-mail-address "kinneyzhang666@gmail.com")
(setq org-export-with-author t)
(setq org-export-with-email t)
(setq org-export-with-date t)
(setq org-export-with-creator t)
;; (setq org-html-creator-string
;;       "<a href=\"https://www.gnu.org/software/emacs/\">Emacs</a> 26.3 (<a href=\"https://orgmode.org\">Org</a> mode 9.1.9)")

;; (setq my/html-head
;;       "
;; <link rel=\"shortcut icon\" href=\"/static/img/favicon.ico\"/>
;; <link rel=\"bookmark\" href=\"/static/img/favicon.ico\" type=\"image/x-icon\"/>
;; <link id=\"pagestyle\" rel=\"stylesheet\" type=\"text/css\" href=\"/static/light.css\"/>
;; <!-- Google Adsense -->
;; <script data-ad-client=\"ca-pub-3231589012114037\" async src=\"https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js\"></script>
;; <!-- End Google Adsense -->
;; ")

;; (setq my/html-home/up-format
;;       "
;; <div id=\"org-div-header\">
;; <div class=\"toptitle\">
;; <a id=\"logo\" href=\"/\">戈楷旎</a>
;; <p class=\"description\">happy hacking emacs!</p>
;; </div>
;; <div class=\"topnav\">
;; <a href=\"/\">首页</a>&nbsp;&nbsp;
;; <a href=\"/archive.html\">归档</a>&nbsp;&nbsp;
;; <a href=\"/category.html\">分类</a>&nbsp;&nbsp;
;; <a href=\"/about.html\">关于</a>&nbsp;&nbsp;
;; <a href=\"/message.html\">留言</a>&nbsp;&nbsp;
;; </div>
;; </div>")

;; (setq my/org-html-postamble-of-page
;;       '(("en"
;; 	 "
;; <script src=\"/static/jQuery.min.js\"></script>

;; <p><span class=\"dim\">©2020</span> 戈楷旎 <span class=\"dim\">| Licensed under </span><a rel=\"license\" href=\"http://creativecommons.org/licenses/by-nc-sa/4.0/\"><img alt=\"知识共享许可协议\" style=\"border-width:0\" src=\"/static/img/license.png\"/></a></p>
;; <p class=\"creator\"><span class=\"dim\">Generated by</span> %c</p>\n

;; <!-- Google Analytics -->
;; <script>
;; (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)})(window,document,'script','https://www.google-analytics.com/analytics.js','ga');ga('create', 'UA-149578968-1', 'auto');ga('send', 'pageview');
;; </script>
;; <!-- End Google Analytics -->

;; <script>
;; $(document).ready(function(){
;; var theme = sessionStorage.getItem(\"theme\");
;; if(theme==\"dark\"){
;; document.getElementById(\"pagestyle\").href=\"/static/dark.css\";
;; }else if(theme==\"light\"){
;; document.getElementById(\"pagestyle\").href=\"/static/light.css\";
;; }else{
;; sessionStorage.setItem(\"theme\",\"light\");
;; }});
;; </script>")))

;; (setq my/org-html-postamble-of-post
;;       `(( "en"
;; 	  ,(concat "
;; <p class=\"date\"><i>Posted on %d</i></p><br>

;; <script src=\"/static/jQuery.min.js\"></script>
;; <script src=\"/static/Valine.min.js\"></script>

;; <div id=\"vcomments\"></div>
;; <script>
;; new Valine({
;; el: '#vcomments',
;; appId: '" (car (geekblog--get-valine-info)) "',
;; appKey: '" (cadr (geekblog--get-valine-info)) "',
;; visitor: true,
;; notify: true,
;; verify: false,
;; avatar: 'identicon',
;; placeholder: '留下你的评论吧～'
;; })
;; </script>

;; <p><span class=\"dim\">©2020</span> 戈楷旎 <span class=\"dim\">| Licensed under </span><a rel=\"license\" href=\"http://creativecommons.org/licenses/by-nc-sa/4.0/\"><img alt=\"知识共享许可协议\" style=\"border-width:0\" src=\"/static/img/license.png\"/></a></p>
;; <p class=\"creator\"><span class=\"dim\">Generated by</span> %c</p>\n

;; <!-- Google Analytics -->
;; <script>
;; (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)})(window,document,'script','https://www.google-analytics.com/analytics.js','ga');ga('create', 'UA-149578968-1', 'auto');ga('send', 'pageview');
;; </script>
;; <!-- End Google Analytics -->

;; <script>
;; $(document).ready(function(){
;; var theme = sessionStorage.getItem(\"theme\");
;; if(theme==\"dark\"){
;; document.getElementById(\"pagestyle\").href=\"/static/dark.css\";
;; }else if(theme==\"light\"){
;; document.getElementById(\"pagestyle\").href=\"/static/light.css\";
;; }else{
;; sessionStorage.setItem(\"theme\",\"light\");
;; }});
;; </script>"))))

;;--------------------------------------------------------------
;; (setq org-publish-project-alist
;;       `(("geekblog"
;; 	 :base-extension "org"
;; 	 :recursive nil
;; 	 :base-directory ,blog-base-dir
;; 	 :publishing-directory ,blog-publish-dir
;; 	 :publishing-function org-html-publish-to-html
;; 	 :preparation-function
;; 	 (geekblog/generate-sitemap geekblog/generate-rss geekblog/generate-index-page geekblog/generate-archive-page geekblog/generate-category-page)
;; 	 :completion-function geekblog/push-to-github
;; 	 :body-only t
;; 	 )))

(use-package simple-httpd
  :ensure t
  :config
  (setq httpd-root (expand-file-name "~/iCloud/blog_site"))) ;; Set default server directory

(defun preview-current-buffer-in-browser ()
  "Open current buffer as html."
  (interactive)
  (let ((fileurl (concat "http://127.0.0.1:8080/post/" (file-name-base (buffer-name)) ".html")))
    (unless (httpd-running-p) (httpd-start))
    (browse-url fileurl)))

(provide 'init-blog-hack)
