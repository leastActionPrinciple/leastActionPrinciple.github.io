;; 配置MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(package-refresh-contents)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(exec-path
   '("/usr/bin/rustc" "/usr/bin/cargo" "/home/ttt/.cargo/bin/rust-script" "/home/ttt/.local/bin" "/home/ttt/.local/bin" "/usr/local/bin" "/usr/bin" "/bin" "/usr/local/sbin" "/usr/lib/jvm/default/bin" "/usr/bin/site_perl" "/usr/bin/vendor_perl" "/usr/bin/core_perl" "/usr/lib/jvm/default/bin"))
 '(haskell-process-type 'stack-ghci)
 '(inhibit-startup-screen t)
 '(org-babel-load-languages '((emacs-lisp . t) (haskell . t) (julia-vterm . t)))
 '(org-latex-classes
   '(("org-note" "\\documentclass[fontset=windows]{article}
                \\usepackage[colorlinks=true,linkcolor=red]{hyperref}
                \\usepackage{ctex}
                \\usepackage{tasks}
                \\settasks{
                         label={\\Alph*.}
                }
                [NO-DEFAULT-PACKAGES]
                [PACKAGES]
                [EXTRA]")
     ("article" "\\documentclass[11pt,fontset=windows]{article}"
      ("\\section{%s}" . "\\section*{%s}")
      ("\\subsection{%s}" . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
      ("\\paragraph{%s}" . "\\paragraph*{%s}")
      ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
     ("report" "\\documentclass[11pt]{report}"
      ("\\part{%s}" . "\\part*{%s}")
      ("\\chapter{%s}" . "\\chapter*{%s}")
      ("\\section{%s}" . "\\section*{%s}")
      ("\\subsection{%s}" . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
     ("book" "\\documentclass[11pt]{book}"
      ("\\part{%s}" . "\\part*{%s}")
      ("\\chapter{%s}" . "\\chapter*{%s}")
      ("\\section{%s}" . "\\section*{%s}")
      ("\\subsection{%s}" . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))))
 '(org-latex-packages-alist '(("" "ctex" t) ("" "mathrsfs" t)))
 '(package-selected-packages
   '(julia-snail ob-browser julia-mode rust-mode use-package racket-mode atom-dark-theme org-gtd haskell-mode ## yasnippet cdlatex auctex))
 '(tool-bar-mode nil)
 '(word-wrap nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; 字符编码
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

;; org自动换行
(global-visual-line-mode 1); 1 for on, 0 for off

(add-hook 'org-mode-hook
	  (lambda()
	    (setq truncate-lines nil)))

;; latex自动保存自动解析
(setq TeX-auto-save t)
(setq TeX-parse-self t)

;; latex文件包含
(setq-default TeX-master nil)

(add-hook 'LaTex-mode-hook 'turn-on-cdlatex) ; with AUCTex LaTex mode
(add-hook 'latex-mode-hook 'turn-on-cdlatex) ; with Emacs latex mode
(add-hook 'org-mode-hook 'turn-on-org-cdlatex)

;; org导出latex
(require 'ox-latex)
(setq org-latex-compiler "xelatex")

;;设置为全局模式,在任何mode中是生效的

(yas-global-mode 1)

(setq yas-snippet-dirs
      '("~/.emacs.d/snippets" ;;personal snippets
	"~/.emacs.d/elpa/yasnippet-20200604.246/snippets"
	))
(put 'upcase-region 'disabled nil)

(add-to-list 'load-path "~/.emacs.d/my/ob-racket")

(use-package ob-racket
  :after org
  :config
  (append '((racket . t) (scribble . t)) org-babel-load-languages)
)

(require 'ox-publish)

(setq org-publish-project-alist
        '(("blog-notes"
	   :base-directory "~/org/notes"
	   :base-extension "org"
	   :publishing-directory "~/org/public_html/leastActionPrinciple.github.io/"
	   :recursive t
	   :publishing-function org-html-publish-to-html
	   :headline-levels 4             ; Just the default for this project.
	   :auto-preamble t
	   :section-numbers nil
	   :author "leastActionPrinciple.github.io"
	   :email "1915843305@qq.com"
	   :auto-sitemap t                ; Generate sitemap.org automagically...
	   :sitemap-filename "sitemap.org"  ; ... call it sitemap.org (it's the default)...
	   :sitemap-title "Sitemap"         ; ... with title 'Sitemap'.
	   :sitemap-sort-files anti-chronologically
	   :sitemap-file-entry-format "%d %t"
	   )
	   ("blog-static"
	   :base-directory "~/org/notes"
	   :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
	   :publishing-directory "~/org/public_html/"
	   :recursive t
	   :publishing-function org-publish-attachment
	   )
	   ("blog" :components ("blog-notes" "blog-static"))))


