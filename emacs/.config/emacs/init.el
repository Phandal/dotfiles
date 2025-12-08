;; Packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(setq use-package-always-ensure t)

;; Corfu is used for completion in region. AKA autocomplete when typing
(use-package corfu
  :ensure t
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

;; Consult allows for search and navigation commands with preview
;; Example configuration for Consult
(use-package consult
  :bind (;; C-c bindings in `mode-specific-map'
         ("C-c M-x" . consult-mode-command)
         ("C-c h" . consult-history)
         ("C-c k" . consult-kmacro)
         ("C-c m" . consult-man)
         ("C-c i" . consult-info)
         ([remap Info-search] . consult-info)
         ;; C-x bindings in `ctl-x-map'
         ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
         ("C-x t b" . consult-buffer-other-tab)    ;; orig. switch-to-buffer-other-tab
         ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
         ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)                ;; orig. yank-pop
         ;; M-g bindings in `goto-map'
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
         ("M-g g" . consult-goto-line)             ;; orig. goto-line
         ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
         ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ;; M-s bindings in `search-map'
         ("M-s d" . consult-find)                  ;; Alternative: consult-fd
         ("M-s c" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
         ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history)                 ;; orig. next-matching-history-element
         ("M-r" . consult-history))                ;; orig. previous-matching-history-element
  :init
  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)
 )

;; ef-themes is a collection of light and dark themes that are pretty and legible.
(use-package ef-themes)

;;base16 themes is a collection of light and dark themes based on 16 colors
(use-package base16-theme)

;; magit is a better git client
(use-package magit)

;; lsp-mode is a better lsp client
(use-package lsp-mode
  :init (setq-default lsp-format-buffer-on-save t)
  :config
  (setq lsp-signature-auto-activate t))
(use-package lsp-pyright)
(use-package lsp-java)

(use-package flymake
  :init
  (setq flymake-show-diagnostics-at-end-of-line nil)
  :bind (
         ("M-n" . flymake-goto-next-error)
         ("M-p" . flymake-goto-prev-error)))

;; Major Language Modes
(use-package gleam-ts-mode)
(use-package ocaml-ts-mode)

(use-package project
  :defer t
  :config
  (add-to-list 'project-vc-extra-root-markers "package.json")
  (add-to-list 'project-vc-extra-root-markers "compile_commands.json")
  (add-to-list 'project-vc-extra-root-markers "mix.exs"))

;; Appearance
(add-to-list 'default-frame-alist '(font . "Iosevka Nerd Font 10"))
(add-to-list 'custom-theme-load-path (concat user-emacs-directory "everforest-theme"))
(load-theme 'base16-black-metal-immortal t nil)
;; (set-face-attribute 'corfu-border nil :background 'unspecified :inherit 'default)
;; (set-face-attribute 'corfu-current nil :background 'unspecified :foreground 'unspecified :inherit 'diff-header :extend t)
;; (set-face-attribute 'corfu-default nil :background 'unspecified :inherit 'default)

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
(setq scroll-conservatively 101)
(setq custom-file "~/.config/emacs-custom.el")
(setq-default indent-tabs-mode nil)
(setq-default truncate-lines t)
(setq-default tab-width 2)
(setopt text-mode-ispell-word-completion nil)
(load-file custom-file)

;; Minor Mode Settings
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(pixel-scroll-precision-mode 1)
(delete-selection-mode 1)
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
	      (java-mode . java-ts-mode)
	      (js-mode . typescript-ts-mode)
	      (c-mode . c-ts-mode)
        (js-json-mode . json-ts-mode)
        (mhtml-mode . html-ts-mode)
        (conf-toml-mode . toml-ts-mode)
        (lua-mode . lua-ts-mode)
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

;;;; Java
(add-hook 'java-ts-mode (lambda () (require 'lsp-java) (lsp-deferred)))

;; Compilation Mode
(require 'ansi-color)

(defun ph/ansi-colorize-compilation-buffer ()
  (when (eq major-mode 'compilation-mode)
    (let ((inhibit-read-only t))
      (ansi-color-apply-on-region compilation-filter-start (point)))))

(add-hook 'compilation-filter-hook #'ph/ansi-colorize-compilation-buffer)
