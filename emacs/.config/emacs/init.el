;; Make this look nicer later
(setq make-backup-files nil)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)
(setq visible-bell t)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq-default truncate-lines t)
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-ts-mode))
(setq major-mode-remap-alist
      '((typescript-mode . typescript-ts-mode)
        (javascript-mode . typescript-ts-mode)
        (js-json-mode . json-ts-mode)
        (mhtml-mode . html-ts-mode)
        (conf-toml-mode . toml-ts-mode)))
(pixel-scroll-precision-mode 1)
(which-key-mode 1)
(fido-vertical-mode 1)
(load-theme 'modus-operandi-tinted)
(package-install 'corfu)
(setq corfu-auto t)
(add-hook 'eglot-managed-mode-hook 'corfu-mode)
(package-install 'exec-path-from-shell)
(exec-path-from-shell-initialize)
(package-install 'orderless)
(setq completion-styles '(orderless basic)
      completion-category-overrides '((file (styles basic partial-completion))))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
