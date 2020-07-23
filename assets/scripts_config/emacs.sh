#!/bin/bash

if ls -a | grep ".emacs" > /dev/null ; then
    rm ~/.emacs
fi

touch ~/.emacs
echo ";; Add MELPA Packages Manager
(when (>= emacs-major-version 24)
      (require 'package)
      (add-to-list
       'package-archives
       '(\"melpa\" . \"http://melpa.milkbox.net/packages/\")
t))

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

;; Add Theme
(load-theme 'tango-dark t)

;; Add Needed Packages
(defvar list_packages
	'(elpy         ;; Emacs Lisp Python Environment
	  auto-complete ;; Auto complete mode
	  flycheck     ;; On the fly syntax cheking
	  py-autopep8  ;; Run autopep8 on save
	 )
)

;; Install Packages
(mapc #'(lambda (package)
       (unless (package-installed-p package)
       (package-install package)))
list_packages)

;; Enable Packages
    (elpy-enable)
    (setq elpy-rpc-virtualenv-path 'current)

    (when (require 'flycheck nil t)
    	  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
    	  (add-hook 'elpy-mode-hook 'flycheck-mode))

    (require 'py-autopep8)
    (add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;; Power Ups
(show-paren-mode)
(auto-complete-mode)
(global-visual-line-mode 1)
(setq electric-pair-pairs
      '(
        (?\\\" . ?\\\")
        (?\\< . ?\\>)))
(electric-pair-mode 1)


(require 'whitespace)
(setq whitespace-style '(face empty lines-tail trailing))
(global-whitespace-mode 1)
(setq make-backup-files nil)

(setq column-number-mode 1)
(global-linum-mode 1)

;; C Programming Language
(setq c-default-style \"bsd\"
	  c-basic-offset 8
          tab-width 8
          indent-tabs-mode t)

(custom-set-variables
'(custom-safe-themes
(quote
(\"f9aede508e587fe21bcfc0a85e1ec7d27312d9587e686a6f5afdbb0d220eab50\" default)))
  '(package-selected-packages (quote (py-autopep8 elpy monokai-theme jedi))))

(custom-set-faces
)" >> ~/.emacs

