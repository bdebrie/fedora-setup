;;;;;;;;;;;;;;;;;;;;;;;
;; EMACS config file;;;
;;;;;;;;;;;;;;;;;;;;;;;

;;; Code:
(setq initial-buffer-choice "~/.config/emacs/init.el")


;; !LAYOUT
(scroll-bar-mode -1)
(tool-bar-mode -1)
(setq inhibit-startup-message t)
(electric-pair-mode 1)


;; !TABS
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq tab-width 2)
(setq-default css-indent-offset 2)
(setq-default js-indent-level 2)
(setq-default js2-strict-traii 2)
(setq-default scroll-conservatively 101)



;; !FONT
(set-face-attribute 'default nil :font "Fira Code" :height 110)

;; !THEME
(load-theme 'doom-molokai t)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; !PACKAGES
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package command-log-mode)
(use-package wrap-region)
(use-package js2-mode
  :mode "\\.js\\'"
  :init
  (setq js2-strict-missing-semi-warning nil))

(use-package rust-mode)

(use-package ivy
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
	       ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
	       ("C-j" . ivy-next-line)
	       ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(global-set-key (kbd "C-M-j") 'counsel-switch-buffer)

(use-package swiper)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom(
	  (doom-modeline-height 30)
	  ;; (doom-modeline-minor-modes t)
	  ))

(use-package doom-themes)
(use-package all-the-icons)

;; (use-package yasnippet)
;; (use-package yasnippet-snippets)

(use-package company
  :hook ((php-mode . company-mode)
         (js2-mode . company-mode)
         (css-mode . company-mode))
  :init
  (company-mode 1))

(use-package php-mode)
(add-hook 'php-mode-hook #'(lambda() (setq c-basic-offset 2)))

(use-package web-mode)
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(add-hook 'after-init-hook #'global-flycheck-mode)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(column-number-mode)
(global-display-line-numbers-mode t)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))


(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 2))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))


(use-package counsel
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history)))

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package general
  :config
  (general-create-definer bd/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (bd/leader-keys
    "t"  '(:ignore t :which-key "toggles")
    "tt" '(counsel-load-theme :which-key "choose theme"))

  (bd/leader-keys
    "l"  '(end-of-line  :which-key "wheelup"))

  (bd/leader-keys
    "j"  '((funcall mwheel-scroll-up-function 20)  :which-key "wheelup"))

  (bd/leader-keys
    "i"  '(evil-insert-state  :which-key "wheelup"))
  )

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal)
  (evil-set-initial-state 'term-mode 'emacs))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package hydra)

(defhydra hydra-scale-text ()
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t))

(defhydra hydra-scale-window ()
  "scale window"
  ("j" evil-window-increase-width "in")
  ("k" evil-window-decrease-width "out")
  ("f" nil "finished" :exit t))

(defhydra hydra-scale-window-y ()
  "scale window"
  ("j" evil-window-increase-height "in")
  ("k" evil-window-decrease-height "out")
  ("f" nil "finished" :exit t))

(defhydra hydra-scroll ()
  "scroll"
  ("j" gcm-scroll-down)
  ("k" gcm-scroll-up)
  ("f" nil "finished" :exit t))

(bd/leader-keys
 "trf" '(hydra-scale-text/body :which-key "scale font")
 "trx" '(hydra-scale-window/body :which-key "scale window-x")
 "try" '(hydra-scale-window-y/body :which-key "scale window-y")
 "ts" '(hydra-scroll/body :which-key "scroll"))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  ;; NOTE: Set this to the folder where you keep your Git repos!
  (when (file-directory-p "/var/www")
    (setq projectile-project-search-path '("/var/www")))
    (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

(use-package magit
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(defun gcm-scroll-down ()
  (interactive)
  (scroll-up 3))

(defun gcm-scroll-up ()
  (interactive)
  (scroll-down 3))

(defun bd/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (visual-line-mode 1))

;; Org Mode Configuration ------------------------------------------------------

(use-package org)

;; (use-package org-bullets
;;   :after org
;;   :hook (org-mode . org-bullets-mode)
;;   :custom
;;   (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

;; (global-set-key (kbd "C-SPC j") 'gcm-scroll-down)
;; (global-set-key (kbd "C-SPC k") 'gcm-scroll-up)





















(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("e8df30cd7fb42e56a4efc585540a2e63b0c6eeb9f4dc053373e05d774332fc13" "b5803dfb0e4b6b71f309606587dd88651efe0972a5be16ece6a958b197caeed8" "d47f868fd34613bd1fc11721fe055f26fd163426a299d45ce69bef1f109e1e71" "266ecb1511fa3513ed7992e6cd461756a895dcc5fef2d378f165fed1c894a78c" "23c806e34594a583ea5bbf5adf9a964afe4f28b4467d28777bcba0d35aa0872e" "8d7b028e7b7843ae00498f68fad28f3c6258eda0650fe7e17bfb017d51d0e2a2" "6c531d6c3dbc344045af7829a3a20a09929e6c41d7a7278963f7d3215139f6a7" "3d54650e34fa27561eb81fc3ceed504970cc553cfd37f46e8a80ec32254a3ec3" "1f1b545575c81b967879a5dddc878783e6ebcca764e4916a270f9474215289e5" "a82ab9f1308b4e10684815b08c9cac6b07d5ccb12491f44a942d845b406b0296" "028c226411a386abc7f7a0fba1a2ebfae5fe69e2a816f54898df41a6a3412bb5" "da186cce19b5aed3f6a2316845583dbee76aea9255ea0da857d1c058ff003546" "a9a67b318b7417adbedaab02f05fa679973e9718d9d26075c6235b1f0db703c8" "234dbb732ef054b109a9e5ee5b499632c63cc24f7c2383a849815dacc1727cb6" "97db542a8a1731ef44b60bc97406c1eb7ed4528b0d7296997cbb53969df852d6" "6c98bc9f39e8f8fd6da5b9c74a624cbb3782b4be8abae8fd84cbc43053d7c175" "7a7b1d475b42c1a0b61f3b1d1225dd249ffa1abb1b7f726aec59ac7ca3bf4dae" "1d5e33500bc9548f800f9e248b57d1b2a9ecde79cb40c0b1398dec51ee820daf" default))
 '(package-selected-packages
   '(rust-mode org-bullets js2-mode wrap-region vterm web-mode company company-mode yasnippet-snippets yasnippet multiple-cursors flycheck flymake-php sublimity which-key use-package twig-mode spacemacs-theme rainbow-delimiters php-mode nimbus-theme monokai-theme magit ivy-rich hydra helpful gruvbox-theme general evil-collection doom-themes doom-modeline counsel-projectile command-log-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
