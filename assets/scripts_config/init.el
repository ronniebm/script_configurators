;; ***************************************
;; ** My personal EMACS Configuration.  **
;; ** --------------------------------  **
;; ** author: ronnie barrios            **
;; ** github: ronniebm                  **
;; ** email:  ronnie.coding@gmail.com   **
;; ** --------------------------------  **
;; ** feel free to send me an email !   **
;; ***************************************
;;
;; EMACS TESTED VERSIONS:
;;   -> GNU Emacs 24.3.1
;;   -> ...
;; ---------------------------------------
;;
;; OS TESTED VERSIONS:
;;   -> Ubuntu, 14.04.6 LTS - Trusty Tahr.
;;   -> Ubuntu, 18.04 LTS - Bionic Beaver.
;; ---------------------------------------

;; When Emacs is started, it normally tries to load a Lisp program from an
;; initialization file, or init file for short. This file, if it exists,
;; specifies how to initialize Emacs for you. Emacs looks for your init file
;; using the filenames ~/.emacs, ~/.emacs.el, or ~/.emacs.d/init.el; you can
;; choose to use any one of these three names.
;;
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Init-File.html
;; -------------------------------------------------------------------------


;; 1) Add Main Repositories for Emacs packages (work only in ubuntu 14).
;; (package-initialize)
;; (setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
;;			 ("marmalade" . "http://marmalade-repo.org/packages/")
;;			 ("melpa" . "http://melpa.org/packages/")))
;;
;;
;; =========================================================================
;; MELPA Package Support
;; =========================================================================
;; Enables basic packaging support:

(require 'package)

;; Adds the Melpa archive to the list of available repositories
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)

;; Initializes the package infrastructure
(package-initialize)

;; If there are no archived package contents, refresh them
(when (not package-archive-contents)
  (package-refresh-contents))

;; ===============================
;; Installs packages
;; ===============================
;; myPackages contains a list of package names:
;;
(defvar myPackages
  '(better-defaults                 ;; Set up some better Emacs defaults
    elpy                            ;; Emacs Lisp Python Environment
    flycheck                        ;; On the fly syntax checking
    py-autopep8                     ;; Run autopep8 on save
    blacken                         ;; Black formatting on save
    material-theme                  ;; Theme
    neotree                         ;; file explorer bar
    )
)

;; ===============================
;; Scans the list in myPackages.
;; ===============================
;; If the package listed is not already installed, install it
(mapc #'(lambda (package)
	  (unless (package-installed-p package)
	    (package-install package)))
      myPackages)

;; laad material theme.
(load-theme 'material t)

;;
;; ==============================
;; PYTHON Development Setup
;; ==============================
;; Enable elpy
(elpy-enable)

;; Enable Flycheck
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; Enable autopep8
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;; ==============================================================
;; MY PERSONAL CONFIGURATION SETTINGS
;; ==============================================================
;; 1) Removes toolbar, scroll bar and menu bar.
;;    to make emacs looks less cluttered.
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

;; 2) Inhibit startup-message and scratch-message.
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)

;; 3) blink cursor mode adjustment and new line autoindent.
(blink-cursor-mode -1)
(global-set-key (kbd "RET") 'newline-and-indent)

;; 4) prevent backup files ~ from being created.
(setq make-backup-files nil)

;; 5) defining my aliases access Alt-x + 'alias_name'.
(defalias 'themes 'customize-themes)
(defalias 'lines 'list-matching-lines)

;; 6) Emacs Highlight the Current Line.
(global-hl-line-mode 1)
(set-face-background 'hl-line "#557c80")

;; 7) Turn ON 'show Line Number' in the bottom bar.
(line-number-mode 1)

;; 8) Configuring left column numerating feature: 'Linum-mode'.
(global-linum-mode t)
(setq linum-format " %3d ")  ;my personal format
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(linum ((t (:inherit (shadow default) :background "#23adac" :foreground "#ffffff")))))

;; 9) customized-theme:
(load-theme 'tsdh-dark 1)

;; 10) Highlight corresponding parentheses when cursor is on one.
(setq show-paren-delay 0) ;; shows matching parenthesis asap
(show-paren-mode t)
(electric-pair-mode 1)    ;; it pairs () [] {} y “”.

;; 11) Proper line wrapping.
(global-visual-line-mode t)

;; 12) Shows innecessart trailing white-spaces.
(setq-default show-trailing-whitespace t)

;; ==============================================================
;; 13) Remove useless whitespace when saving a file [Disabled].
;; ==============================================================
;;(add-hook 'before-save-hook 'whitespace-cleanup)
;;(add-hook 'before-save-hook (lambda() (delete-trailing-whitespace)))
;;
;;
;; ==============================================================
;; 14) Folder explorer (file tree) Neotree [Disabled]
;; ==============================================================
;;(require 'neotree)
;;(global-set-key [f8] 'neotree-toggle) ;; the F8 key toggles the file tree
;;
;;
;; ==============================================================
;; 15) Make Lines moves UP/DOWN, with M-up / M-down key-binds.
;; this is a very interesting feature !.. also it works if
;; you select 2 or more lines, and then the key-bind.
;; ==============================================================

(defun move-text-internal (arg)
  (cond
   ((and mark-active transient-mark-mode)
    (if (> (point) (mark))
	(exchange-point-and-mark))
    (let ((column (current-column))
	  (text (delete-and-extract-region (point) (mark))))
      (forward-line arg)
      (move-to-column column t)
      (set-mark (point))
      (insert text)
      (exchange-point-and-mark)
      (setq deactivate-mark nil)))
   (t
    (let ((column (current-column)))
      (beginning-of-line)
      (when (or (> arg 0) (not (bobp)))
	(forward-line)
	(when (or (< arg 0) (not (eobp)))
	  (transpose-lines arg)
	  (when (and (eval-when-compile
		       '(and (>= emacs-major-version 24)
			     (>= emacs-minor-version 3)))
		     (< arg 0))
	    (forward-line -1)))
	(forward-line -1))
      (move-to-column column t)))))

(defun move-text-down (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines down."
  (interactive "*p")
  (move-text-internal arg))

(defun move-text-up (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines up."
  (move-text-internal (- arg)))

  (interactive "*p")

(global-set-key [M-up] 'move-text-up)         ;; moves a line up.
(global-set-key [M-down] 'move-text-down)     ;; moves a line down.
(global-set-key [M-delete] 'kill-whole-line)  ;; deletes actual line.

;; ==========================================================================
;; 16) Defining a Lorem ipsum generator function !.
;; ==========================================================================
;; for use press M-x lorem [Return] and the text
;; should be placed ! cool isn't ?

(defun lorem ()
  "Insert a lorem ipsum."
  (interactive)
  (insert "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do "
	  "eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim"
	  "ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut "
	  "aliquip ex ea commodo consequat. Duis aute irure dolor in "
	  "reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla "
	  "pariatur. Excepteur sint occaecat cupidatat non proident, sunt in "
	  "culpa qui officia deserunt mollit anim id est laborum."))

;; ==========================================================================
;; 17) DEFINING MY PERSONAL ABBREVIATIONS.
;; ==========================================================================
;;

(setq-default abbrev-mode t)
(clear-abbrev-table global-abbrev-table)
(define-abbrev-table 'global-abbrev-table
  '(
    ;; my personal abbrev
    ("docstring" "\"\"\"by the way
	      this is a
	      long example !!" )
    ("templatereadme" "### PROJECT:
---
For this project, we are going to learn about:<br>

-
-

#### GENERAL OBJECTIVES:<br>

-
-

&emsp;&emsp;<img src=\"https://www.enter.co/wp-content/authors/Holberton-215.jpg\" />
---
### Personal Review:
-


---
git_user: ronniebm  |  email: ronnie.coding@gmail.com
")
    ;;
    ))




;; ===================================================================
;; 18) Giving execution permissions to my current file !.
;; ===================================================================

(defun executable()
  "Add executable permissions on current file."
  (interactive)
  (when (buffer-file-name)
    (set-file-modes buffer-file-name
		    (logior (file-modes buffer-file-name) #o100))
    (message (concat "Made " buffer-file-name " executable"))))


;; ===================================================================
;; 19) Key-binds to resize buffer windows. [TESTING -- not released]
;; ===================================================================
;;(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
;;(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
;;(global-set-key (kbd "S-C-<up>") 'enlarge-indow)
;;(global-set-key (kbd "S-C-<down>") 'shrink-window)

;; ===================================================================
;; 20) Configuring a SHELL BUFFER in a bottom windows when emacs start.
;;     [TESTING -- not released]
;; ===================================================================
;;(split-window-below 30)
;;(other-window)

(set-face-attribute 'default nil :height 150)
(toggle-frame-fullscreen)

(require 'neotree)

;; Enable NEOTREE key-bind command.
(global-set-key [f8] 'neotree-toggle)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.(require 'neotree)
 '(package-selected-packages
   (quote
    (neotree py-autopep8 material-theme flycheck elpy blacken better-defaults))))
