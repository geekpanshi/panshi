;; Set the package installation directory so that packages aren't stored in the
;; ~/.emacs.d/elpa path.
(require 'package)
(setq package-user-dir (expand-file-name "./.packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;;(use-package simple-httpd
;;  :ensure t)

;; Initialize the package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install dependencies
(package-install 'htmlize)

;; Load the publishing system
(require 'ox-publish)

;; Customize the HTML output
(setq org-html-validation-link nil            ;; Don't show validation link
      org-html-head-include-scripts nil       ;; Use our own scripts
      org-html-head-include-default-style nil ;; Use our own styles
      org-html-head "<link rel=\"stylesheet\" href=\"https://cdn.simplecss.org/simple.min.css\" />")

(defun org-publish-sitemap-time-entry (entry style project)
    (format "%s %s"
            (format-time-string
             "[%Y.%m.%d]"
             (org-publish-find-date entry project))
            (org-publish-sitemap-default-entry entry style project)))

;; Define the publishing project
(setq org-publish-project-alist
      `(("org-post"
             :recursive t
             :base-directory "./content/posts"
             :base-extension "org"
             :publishing-function org-html-publish-to-html
             :publishing-directory "./public"
             :exclude "sitemap.org"
             :with-creator t            ;; Include Emacs and Org versions in footer
             :with-toc nil              ;; Include a table of contents
             :section-numbers nil       ;; Don't include section numbers
             :time-stamp-file nil       ;; Don't include time stamp in file
             :auto-preamble t
             :auto-sitemap t
             :author "panshishuo"
             :html-link-home "/panshi/first_page.html"
             :html-link-up "/panshi"
             :sitemap-style list
             :sitemap-title "磐石说"
             :sitemap-filename "index.org"
             :sitemap-sort-files anti-chronologically
             :sitemap-format-entry org-publish-sitemap-time-entry
             :html-head ,(concat
                          "<link rel=\"stylesheet\" type=\"text/css\" href=\"style.css\"/>\n"
                          "<script src=\"https://hm.baidu.com/hm.js?4dbc75a8d627e17a8714e4c8b2e9afa8\"></script>")
             :with-author t)
        ("org-static"
             :base-directory "./content/static"
             :base-extension "css\\|js"
             :publishing-directory "./public"
             :recursive t
             :publishing-function org-publish-attachment)
        ("org-images"
             :base-directory "./content/posts/img"
             :base-extension "jpg\\|jpeg\\|png\\|gif"
             :publishing-directory "./public/img"
             :recursive t
             :publishing-function org-publish-attachment)
        ("org" :components ("org-post" "org-images"))))
;; Generate the site output
(org-publish-all t)

(message "Build complete!")
