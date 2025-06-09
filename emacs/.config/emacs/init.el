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
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-ts-mode))
(add-to-list 'auto-mode-alist '("\\(?:CMakeLists\\.txt\\|\\.cmake\\)\\'" . cmake-ts-mode))

;;   Map specific modes to their tree sitter equivalents
(setq major-mode-remap-alist
      '((typescript-mode . typescript-ts-mode)
        (javascript-mode . typescript-ts-mode)
        (js-json-mode . json-ts-mode)
        (mhtml-mode . html-ts-mode)
        (conf-toml-mode . toml-ts-mode)))

;; Custom Set Stuff. I would like to know if I could turn this off somehow?
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("59c36051a521e3ea68dc530ded1c7be169cd19e8873b7994bfc02a216041bf3b"
     "d609d9aaf89d935677b04d34e4449ba3f8bbfdcaaeeaab3d21ee035f43321ff1"
     default))
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
