;;; twig-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "twig-mode" "twig-mode.el" (0 0 0 0))
;;; Generated autoloads from twig-mode.el

(autoload 'twig-mode "twig-mode" "\
Major mode for editing twig files

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("\\.twig\\'" . twig-mode))

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "twig-mode" '("sgml-indent-line-num" "twig-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; twig-mode-autoloads.el ends here
