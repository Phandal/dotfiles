;; Packages
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(setq use-package-always-ensure t)

;; Corfu is used for completion in region. AKA autocomplete when typing
(use-package corfu
  :init
  (setq corfu-auto t
	corfu-preview-current nil)
  :config
  (keymap-unset corfu-map "RET")
  (global-corfu-mode))

;; Corfu-Popupinfo is used to show documentation in the corfu candidate
(use-package corfu-popupinfo
  :ensure nil
  :after corfu
  :hook (corfu-mode . corfu-popupinfo-mode))

;; Kind-icon adds icons to the Corfu popup
(use-package kind-icon
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

;; Cape adds extra Capfs to the completions list
(use-package cape
  :bind ("C-c p" . cape-prefix-map)
  :init
  ;; Add to the global default value of `completion-at-point-functions' which is
  ;; used by `completion-at-point'.  The order of the functions matters, the
  ;; first function returning a result wins.  Note that the list of buffer-local
  ;; completion functions takes precedence over the global list.
  (add-hook 'completion-at-point-functions #'cape-elisp-block))

;; Exec-path-from-shell is used to load the environment variables from the shell.
;;   For exapmle, loading $MANPATH and $PATH
(use-package exec-path-from-shell
  :config
  (setq exec-path-from-shell-variables '("ZDOTDIR" "PATH" "MANPATH"))
  (exec-path-from-shell-initialize))

(use-package vterm)

;; Vertico is a better vetical completion system
(use-package vertico
  :config (vertico-mode))

;; Marginalia provides more info in the Vertico display
(use-package marginalia
  :config
  (marginalia-mode))

;; Orderless is a backend used for completion functions such as corfu and fido
(use-package orderless
  :config
  (setq completion-styles '(orderless basic)
	completion-category-overrides '((file (styles basic partial-completion)))))

;; ef-themes is a collection of light and dark themes that are pretty and legible.
(use-package ef-themes
  :config
  (load-theme 'ef-owl t nil))

;; magit is a better git client
(use-package magit)

;; lsp-mode is a better lsp client
(use-package lsp-mode)
(use-package lsp-pyright)

;; Major Language Modes
(use-package gleam-ts-mode)
(use-package ocaml-ts-mode)

(use-package project
:defer t
:config
  (add-to-list 'project-vc-extra-root-markers "package.json")
  (add-to-list 'project-vc-extra-root-markers "mix.exs"))

;; Setting a few variables
(setq make-backup-files nil)
(setq inhibit-startup-screen t)
(setq confirm-kill-emacs 'yes-or-no-p)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)
(setq visible-bell t)
(setq ring-bell-function 'ignore)
(setq display-line-numbers-type 'relative)
(setq frame-resize-pixelwise t)
(setq gc-cons-threshold 100000000)
(setq erc-hide-list '("JOIN" "PART" "QUIT"))
(setq custom-file "~/.config/emacs-custom.el")
(setq-default truncate-lines t)
(load-file custom-file)

;; Minor Mode Settings
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(pixel-scroll-precision-mode 1)
(which-key-mode 1)

;; TreeSitter Settings
;;   Add filetypes to the list of modes recognized by emacs
(setq treesit-font-lock-level 4)
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-ts-mode))
(add-to-list 'auto-mode-alist '("\\(?:CMakeLists\\.txt\\|\\.cmake\\)\\'" . cmake-ts-mode))

;;   Map specific modes to their tree sitter equivalents
(setq major-mode-remap-alist
      '((typescript-mode . typescript-ts-mode)
        (javascript-mode . typescript-ts-mode)
	(js-mode . js-ts-mode)
	(c-mode . c-ts-mode)
        (js-json-mode . json-ts-mode)
        (mhtml-mode . html-ts-mode)
        (conf-toml-mode . toml-ts-mode)
	(python-mode . python-ts-mode)))

;; Language Specific Settings
;;;; Programming
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;;;; Typescript
(add-hook 'typescript-ts-base-mode-hook 'lsp-deferred)

;;;; Javascript
(setq js-indent-level 2)

;;;; Python
(add-hook 'python-ts-mode-hook (lambda () (require 'lsp-pyright) (lsp-deferred)))
