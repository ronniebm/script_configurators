;; ======== RONNIE EMACS Customization init.el === ronnie.coding@gmail.com ========================
;;
;; Tested:  Emacs 24.3 (ubuntu_14), Emacs 25.2 (ubuntu_18)
;; ================================================================================================

; SHORT SETTINGS ----------------------------------------------------------------------------------

(package-initialize)                                          ;; package initialize.
(setq inhibit-startup-screen t)                               ;; dissable startup screen.
(menu-bar-mode -1)                                            ;; dissable menu bar.
(tool-bar-mode -1)                                            ;; dissable tool bar.
(scroll-bar-mode -1)                                          ;; dissable scroll bar.
(if (display-graphic-p)(set-background-color "#aaaaaa"))     ;; if GUI, set bckg.color.
(set-background-color "honeydew")
(set-language-environment "UTF-8")                            ;; set language UTF-8.
(setq initial-scratch-message "== My notes ==\n\n> ")         ;; *scratch* screen title.
(blink-cursor-mode -1)                                        ;; blink cursor OFF.
(global-set-key (kbd "RET") 'newline-and-indent)              ;; new-line-and-intent.
(setq make-backup-files nil)                                  ;; prevent bakup files ~
(global-hl-line-mode 1)                                       ;; highlight current line.
(set-face-background 'hl-line "#e3e229")                      ;; face backgrount line.
(line-number-mode 1)                                          ;; show line num bottom bar.
(global-linum-mode t)                                         ;; show line num left-colum.
(setq linum-format " %3d ")                                   ;; line num lef-colum format.

(custom-set-faces
 '(linum ((t (:background "#23adac" :foreground "#ffffff")))))

(load-theme 'tsdh-dark 1)                                     ;; customized theme.
(setq show-paren-delay 0)                                     ;; show matching parenthesis.
(show-paren-mode t)                                           ;; show parent mode.
(electric-pair-mode 1)                                        ;; show pairs () [] {} y “”.
(global-visual-line-mode t)                                   ;; show proper line wrapping.
(setq-default show-trailing-whitespace t)                     ;; show trailing whitespaces.
(delete-selection-mode 1)                                     ;; delete/overwrite over selected text.
(electric-indent-mode 0)                                      ;; electric indent mode OFF.
(set-default 'tab-always-indent 'complete)                    ;; tab always indent ON.
(setq-default indent-tabs-mode nil)                           ;; indent-tabs-mode DISSABLED.
(setq-default tab-width 4)                                    ;; tab-with is 4.
(set-face-attribute 'default nil :height 130)                 ;; Default font size = 13spx.



; ALIASES ----------------------------------------------------------------------------------------
(defalias 'themes 'customize-themes)                          ;; access to themes config.
(defalias 'replace 'replace-string)                           ;; replace strings in a document.
(defalias 'lines 'list-matching-lines)                        ;; show all lines containing a str.



; KEY-BINDS --------------------------------------------------------------------------------------
(global-set-key [M-delete] 'kill-whole-line)        ;; delete actual line.
(global-set-key [f12] 'delete-trailing-whitespace)  ;; delete trailing whitspc.


;; MY FUNCTIONS ----------------------------------------------------------------------------------

(defun executable() ;; == EXEC. PERMISSIONS FOR CURRENT FILE ===
  "Add executable permissions on current file."
  (interactive)
  (when (buffer-file-name)
    (set-file-modes buffer-file-name
		    (logior (file-modes buffer-file-name) #o100))
    (message (concat "Made " buffer-file-name " executable"))))



(defun lorem() ;; === MY LOREM IPSUM GENERATOR ===
  "Insert a lorem ipsum."
  (interactive)
  (insert "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do "
	  "eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim"
	  "ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut "
	  "aliquip ex ea commodo consequat. Duis aute irure dolor in "
	  "reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla "
	  "pariatur. Excepteur sint occaecat cupidatat non proident, sunt in "
	  "culpa qui officia deserunt mollit anim id est laborum."))



(defun readme() ;; === MY README.md TEMPLATE ===
  "Insert a README.md template."
  (interactive)
  (insert "<img src=\"https://camo.githubusercontent.com/04a8a9a456b8ecafad2eb4f2cff6803cd0194496/687474703a2f2f7777772e686f6c626572746f6e7363686f6f6c2e636f6d2f686f6c626572746f6e2d6c6f676f2e706e67\"
width=30%/>  \n\n\n"
	  "### PROJECT:  \n"
	  "---\n\n\n"
-	  "For this project, we are going to learn about:<br>\n"
	  "- \n"
	  "- \n\n\n"
	  "#### GENERAL OBJECTIVES:<br>\n"
	  "- \n"
	  "- \n\n\n"
	  "#### MY PERSONAL REVIEW/NOTES:<br>\n\n"
	  "These are important things I want to document.\n\n\n\n"
	  "---\n"
	  "git_user: ronniebm  |  email: ronnie.coding@gmail.com\n"
	  ))

;; ==============================================================
;; Make Lines moves UP/DOWN, with M-up / M-down key-binds.
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
  (interactive "*p")
  (move-text-internal (- arg)))

(global-set-key [M-up] 'move-text-up)         ;; moves a line up.
(global-set-key [M-down] 'move-text-down)     ;; moves a line down.




; LONG CODE SETTINGS ----------------------------------------------------------------------------------

;; === SET EMACS DEFAULT FONT (WINDOWS, MAC, or GNU/LINUX) ===

(set-frame-font
 (cond
  ((string-equal system-type "windows-nt") ; Microsoft Windows
   (if (member "Consolas" (font-family-list))
       "Consolas"
     nil
     ))
  ((string-equal system-type "darwin") ; macOS
   (if (member "Menlo" (font-family-list))
       "Menlo-14"
     nil
     ))
  ((string-equal system-type "gnu/linux") ; linux
   (if (member "DejaVu Sans Mono" (font-family-list))
       "DejaVu Sans Mono"
     nil
     ))
  (t nil))
 t t)


; ***********************************************************************************************
; PACKAGES CONFIGURATIONS (Applyed on Emacs version == 24)    |   Ronnie's Personal Setup.
; ***********************************************************************************************

(when (= emacs-major-version 24)

  ; warning-minimum-level disabled --------------
  (setq warning-minimum-level :emergency)

  ; require/install packages --------------------
  (require 'package)
  (add-to-list 'package-archives
               '("MELPA Stable" . "http://stable.melpa.org/packages/") t)

  (add-to-list 'package-archives
               '("http://elpa.gnu.org/packages/") t)


  ; packages initialization ---------------------
  (package-initialize)

  ; creating a packages list. --------------------------------------------
  (defvar myPackages
    '(better-defaults                 ;; Set up some better Emacs defaults
      flycheck                        ;; on the fly syntax checking
      all-the-icons                   ;; install all-the-icons package
      neotree                         ;; file explorer bar
   ;   magit                           ;; emacs github features
      )
    )

  ; installing packages. -------------------------------------------------

  (mapc #'(lambda (package)
	  (unless (package-installed-p package)
	    (package-install package)))
      myPackages)


  ; some settings/key-binds for packages -----------
  (global-set-key [f8] 'neotree-toggle)
  (setq flycheck-mode 1)

 )


; ***********************************************************************************************
; PACKAGES CONFIGURATIONS (Applyed on Emacs version == 25)    |   Ronnie's Personal Setup.
; ***********************************************************************************************

(when (= emacs-major-version 25)


  ; configuring melpa 'stable' repository --------------------------------

  (require 'package)

  (add-to-list
   'package-archives
;   '("melpa" . "https://stable.melpa.org/packages/")
   '("melpa" . "https://melpa.org/packages/")
   t)


  ; creating a packages list. --------------------------------------------

  (defvar myPackages
    '(better-defaults                 ;; Set up some better Emacs defaults
      elpy                            ;; Emacs Lisp Python Environment
      flycheck                        ;; On the fly syntax checking
      py-autopep8                     ;; Run autopep8 on save
      blacken                         ;; Black formatting on save
      all-the-icons                   ;; install all-the-icons package
      neotree                         ;; file explorer bar
      auto-complete-c-headers
      anaconda-mode
      ac-c-headers
      ac-html
      )
    )

  ; installing packages. -------------------------------------------------

  (mapc #'(lambda (package)
	  (unless (package-installed-p package)
	    (package-install package)))
      myPackages)

  ; settings -------------------------------------------------------------

  (global-flycheck-mode 1)

  (elpy-enable)

  (setq elpy-modules
        (delq 'elpy-module-flymake elpy-modules))

  (add-hook 'elpy-mode-hook 'flycheck-mode)

  (require 'py-autopep8)
  (add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

  (require 'neotree)
  (global-set-key [f8] 'neotree-toggle)

  )
