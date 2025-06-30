;; Packages
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; Corfu is used for completion in region. AKA autocomplete when typing
(package-install 'corfu)

;; Exec-path-from-shell is used to load the environment variables from the shell.
;;   For exapmle, loading $MANPATH and $PATH
(package-install 'exec-path-from-shell)

;; Orderless is a backend used for completion functions such as corfu and fido
(package-install 'orderless)

;; ef-themes is a collection of light and dark themes that are pretty and legible.
(package-install 'ef-themes)

;; magit is a better git client
(package-install 'magit)

;; lsp-mode is a better lsp client
(package-install 'lsp-mode)

;; Major Language Modes
(package-install 'gleam-ts-mode)

;; Appearance
(load-theme 'modus-vivendi-deuteranopia t nil)

;; Package settings
;; Corfu
(setq corfu-auto t)
(add-hook 'eglot-managed-mode-hook 'corfu-mode)
(add-hook 'lsp-mode-hook 'corfu-mode)

;; Exec-path-from-shell
(setq exec-path-from-shell-variables '("ZDOTDIR" "PATH" "MANPATH"))
(exec-path-from-shell-initialize)

;; Orderless
(setq completion-styles '(orderless basic)
      completion-category-overrides '((file (styles basic partial-completion))))

;; Project
(with-eval-after-load 'project
(add-to-list 'project-vc-extra-root-markers "package.json"))

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
(setq custom-file "~/.config/emacs-custom.el")
(load-file custom-file)
(setq-default truncate-lines t)

;; Minor Mode Settings
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(pixel-scroll-precision-mode 1)
(which-key-mode 1)
(fido-vertical-mode 1)

;; TreeSitter Settings
;;   Add filetypes to the list of modes recognized by emacs
(setq treesit-font-lock-level 4)
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-ts-mode))
(add-to-list 'auto-mode-alist '("\\(?:CMakeLists\\.txt\\|\\.cmake\\)\\'" . cmake-ts-mode))

;;   Map specific modes to their tree sitter equivalents
(setq major-mode-remap-alist
      '((typescript-mode . typescript-ts-mode)
        (javascript-mode . typescript-ts-mode)
	(c-mode . c-ts-mode)
        (js-json-mode . json-ts-mode)
        (mhtml-mode . html-ts-mode)
        (conf-toml-mode . toml-ts-mode)))

;; Language Specific Settings
;;;; Programming
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;;;; Typescript
(add-hook 'typescript-ts-base-mode-hook 'lsp-deferred)
