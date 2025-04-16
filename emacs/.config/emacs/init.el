;; Quick fixes to problems that need to be solved later
(cons 'svg image-types) ;; Stops Pesky image not supported error

;; TODO: Research display-buffer-alist
;; ("\\*compilation\\*"
;;            (display-buffer-in-side-window) (window-height . 0.3) (side
;;                                                                   . bottom) (slot . 0))
;;

;; Custom Functions
(defun ph/find-init-file (&optional other-window)
  "Find the user's init file. If prefix arg is non-nil, find user's init file in other window."
  (interactive "P")
  (if (eq other-window nil)
      (find-file user-init-file)
    (find-file-other-window user-init-file)))

(defun ph/load-init-file ()
  "Load the user's init file"
  (interactive)
  (load-file user-init-file))

(defun ph/swap-mac-modifiers ()
    "Swaps the command and option modifiers between meta and super"
  (interactive)
  (if (eq mac-command-modifier 'super)
      (setq mac-command-modifier 'meta
            mac-option-modifier 'super)
    (setq mac-command-modifier 'super
          mac-option-modifier 'meta)))

(defun ph/helpful-remaps ()
  "set remapped keys for helpful commands"
  (keymap-global-set "C-h f" 'helpful-function)
  (keymap-global-set "C-h k" 'helpful-key)
  (keymap-global-set "C-h v" 'helpful-variable)
  (keymap-global-set "C-h o" 'helpful-callable))

(defun ph/embark-remaps ()
  "set keys for embark"
  (define-key minibuffer-mode-map (kbd "C-.") 'embark-act))

(defun ph/consult-remaps ()
  "set remapped keys for consult commands"
  (keymap-global-set "C-x b" 'consult-buffer)
  (keymap-global-set "C-x p b" 'consult-project-buffer))

(defun ph/line-numbers-hook ()
  "setup line numbers for certain text/programming modes"
  (dolist (mode '(prog-mode-hook text-mode-ook conf-mode-hook fundamental-mode-hook))
    (add-hook mode (lambda () (display-line-numbers-mode 1)))))

;; Keymap Settings
(keymap-global-unset "C-z" t)
(keymap-global-unset "C-x C-z" t)
(keymap-global-set "<f5>" 'ph/load-init-file)
(keymap-global-set "C-c c" 'compile)

;; Turning a few things off
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

;; Turning a few things on
(delete-selection-mode 1)
(electric-pair-mode 1)
(global-hl-line-mode 0)

;; Setting a few settings
;; (add-to-list 'default-frame-alist '(font . "FiraCode Nerd Font 12"))
(add-to-list 'default-frame-alist '(font . "Iosevka Nerd Font 10"))
(setq-default display-line-numbers-type 'relative)
(ph/line-numbers-hook)
(setq-default indent-tabs-mode nil)
(setq-default truncate-lines t)
(setq-default show-trailing-whitespace t)
(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024))
(setq make-backup-files nil)
(setq completions-format 'vertical) ;; When the completion window is up the completions are listed in columns instead of rows
(setq completions-detailed t) ;; Turns on extra details for some completions commands
(setq help-window-select t)
(setq help-window-keep-selected t)
(setq mark-even-if-inactive nil) ;; Don't allow the mark to be used if the mark is not active
(setq hscroll-step 1) ;; Controls how many columns to move over when point goes out of focus
(setq mouse-wheel-scroll-amount '(3 ((shift) . 1)))
(setq mouse-wheel-progressive-speed nil)
(setq visible-bell t)
(setq ring-bell-function 'ignore)
(setq inhibit-startup-screen t)
(setq frame-resize-pixelwise t) ;; This is needed to allow the window to size by pixel instead of rounding to the nearest character
(setq treesit-font-lock-level 4)
(setq project-vc-extra-root-markers '("dune-project" "Makefile" "gleam.toml"))

;; Org Specific Settings
(with-eval-after-load "org"
(keymap-set org-mode-map "C-c C-x u" 'org-clock-update-time-maybe))

;; Language Specific Settings
(setq js-indent-level 2)
(with-eval-after-load 'js
  (define-key js-mode-map (kbd "M-.") nil))
(setq typescript-indent-level 2)

;; Mac Specific Settings
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)
(if (eq system-type 'darwin)
  (and (add-to-list 'default-frame-alist '(font . "Iosevka Nerd Font 12"))
   (menu-bar-mode 1))
())

;; ERC Specific Settings
(setq erc-hide-list '("JOIN" "PART" "QUIT"))

;; Packages (Keep it simple stupid)
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; Theme
(add-to-list 'custom-theme-load-path (concat user-emacs-directory "everforest-theme"))
(package-install 'nord-theme)
(package-install 'modus-themes)
(package-install 'gruvbox-theme)
(package-install 'ef-themes)
;; (load-theme 'ef-elea-light t nil)
;; (load-theme 'everforest-hard-light t nil)
(load-theme 'modus-operandi t nil)

(package-install 'helpful)
(ph/helpful-remaps)

;; (package-install 'tree-sitter)
;; (package-install 'tree-sitter-langs)
;; (global-tree-sitter-mode)
;; (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)
(setq treesit-language-source-alist
      '((typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
        (javascript "https://github.com/tree-sitter/tree-sitter-javascript")
        (html "https://github.com/tree-sitter/tree-sitter-html")
        (json "https://github.com/tree-sitter/tree-sitter-json")
        (gleam "https://github.com/gleam-lang/tree-sitter-gleam")
        (toml "https://github.com/tree-sitter/tree-sitter-toml")
        (yaml "https://github.com/tree-sitter/tree-sitter-yaml")))

(add-to-list 'auto-mode-alist '("\\.yml'" . yaml-ts-mode))

(setq major-mode-remap-alist
      '((typescript-mode . typescript-ts-mode)
        (javascript-mode . javascript-ts-mode)
        (js-json-mode . json-ts-mode)
        (mhtml-mode . html-ts-mode)
        (conf-toml-mode . toml-ts-mode)))

(package-install 'markdown-mode)

(package-install 'typescript-mode)
(add-hook 'typescript-mode-hook (lambda () (flycheck-add-next-checker 'lsp 'javascript-eslint)))

(package-install 'tuareg)

(package-install 'go-mode)

(package-install 'lsp-java)

(package-install 'gleam-ts-mode)
(require 'gleam-ts-mode)
(add-to-list 'auto-mode-alist '("\\.gleam\\'" . gleam-ts-mode))
(add-hook 'gleam-ts-mode-hook 'eglot-ensure)
(require 'eglot)
(add-to-list 'eglot-server-programs '((gleam-ts-mode) "gleam" "lsp"))

(package-install 'web-mode)
(setq web-mode-code-indent-offset 2)

(package-install 'which-key)
(which-key-mode t)

(package-install 'magit)
(require 'magit)

(package-install 'vterm)
(add-hook 'vterm-mode-hook (lambda () (setq show-trailing-whitespace nil)))

(package-install 'elpher)

(package-install 'exec-path-from-shell)
(setq exec-path-from-shell-variables '("ZDOTDIR" "PATH" "MANPATH"))
(exec-path-from-shell-initialize)

(package-install 'lsp-mode)
(setq lsp-eslint-auto-fix-on-save t)
(setq lsp-completion-provider :none)
(add-hook 'lsp-mode-hook 'corfu-mode)
(package-install 'lsp-ui)
(package-install 'flycheck)

(add-hook 'typescript-ts-mode-hook 'lsp-deferred)
(add-hook 'c-ts-mode-hook 'lsp-deferred)
(add-hook 'java-ts-mode-hook 'lsp-deferred)

;; (package-install 'company)
;; (require 'company)
;; (setq company-idle-delay 0)
;; (setq company-minimum-prefix-length 1)

(package-install 'corfu)
(require 'corfu)
(setq corfu-auto t)
;; (global-corfu-mode)


(package-install 'vertico)
(require 'vertico)
(vertico-mode)

(package-install 'marginalia)
(require 'marginalia)
(marginalia-mode)

(package-install 'orderless)
(require 'orderless)
(setq completion-styles '(orderless basic))
(setq completion-category-overrides '((file (styles basic partial-completion))))

(package-install 'embark)
(ph/embark-remaps)

(package-install 'consult)
(ph/consult-remaps)

(package-install 'evil)
;; (evil-mode)

;; Remove the escape characters in the compilation buffer
(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (ansi-color-apply-on-region compilation-filter-start (point)))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)
(add-hook 'compilation-mode-hook (lambda () (setq show-trailing-whitespace nil)))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("317754d03bb6d85b5a598480e1bbee211335bbf496d441af4992bbf1e777579e"
     "671c79fc459f28077436448cef3b597064676ca2dc6b00f29f522a6137dd2c22"
     "a53c7ff4570e23d7c5833cd342c461684aa55ddba09b7788d6ae70e7645c12b4"
     default))
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)
