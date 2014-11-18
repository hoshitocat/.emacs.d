(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)

(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)
(pallet-mode t)

;;; color theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'afternoon t)
;;; (require 'color-theme)
;;; (color-theme-initialize)
;;; (color-theme-deep-blue)
;;; (require 'ujelly-theme)
;;; (load-theme 'ujelly t)

;;; can see some whitespaces and tab
(require 'whitespace)
(setq whitespace-style
      '(face tabs tab-mark trailing space-before-tab space-after-tab::space))
(setq whitespace-space-regexp "\\(\x3000+\\)")
(setq whitespace-display-mappings
      '((space-mark ?\x3000 [?\□])
        (tab-mark   ?\t   [?\xBB ?\t])
        ))
(global-whitespace-mode t)

(set-face-attribute 'whitespace-trailing nil
                    :foreground "DeepPink"
                    :underline t)
(set-face-attribute 'whitespace-tab nil
                    :foreground "LightSkyBlue"
                    :underline t)
(set-face-attribute 'whitespace-space nil
                    :foreground "GreenYellow"
                    :weight 'bold)

;;; delete white space at the end of line before save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;; save cursor place
(require 'saveplace)
(setq-default save-place t)

(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)

;;; create new line at final line
(setq require-final-newline t)

;;; view line number
(global-linum-mode t)
(set-face-attribute 'linum nil
                    :foreground "#0aa"
                    :height 0.9)
;;; (setq linum-format "%4d")

;;; doesn't creaate backup files
(setq make-backup-files nil)
(setq auto-save-default nil)

;;; indent setting
(setq indent-tabs-mode nil)
(setq-default indent-tabs-mode nil)
(setq c-basic-offset 2)

;;; use emacsclient
(server-mode t)

;;; hide message at start emacs
(setq inhibit-startup-message t)

;;; hide tool bar and menu bar
(menu-bar-mode 0)
(tool-bar-mode 0)

;;; rectangular select mode
(cua-mode t)

;;; change cursor color
(if window-system (progn
 (setq initial-frame-alist '((width . 80)(height . 40)(top . 0)(left . 0)))
 ;;; (set-background-color "Black")
 ;;; (set-foreground-color "White")
 (set-cursor-color "yellow")
 ))

;;; highlight cursor line
;;; (defface hlline-face
;;;   '((((class color)
;;;       (background dark))
;;;      (:background "dark slate gray"))
;;;     (((class color)
;;;       (background light))
;;;      (:background "#CC0066"))
;;;     (t
;;;      ()))
;;;   "*Face used by hl-line.")
;;; (setq hl-line-face 'hlline-face)
(global-hl-line-mode)

;;; keymapping undo and redo
(require 'redo+)
(define-key global-map (kbd "C-z") 'undo)
(define-key global-map (kbd "C-S-z") 'redo)

;;; flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;;; helm
(require 'helm-config)
(global-set-key (kbd "C-c h") 'helm-mini)
(helm-mode 1)
(define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)

;;; git-gutter
(global-git-gutter-mode t)

;;; font size
(define-key global-map (kbd "M-y") 'helm-show-kill-ring)

(set-face-attribute 'default nil
                    :family "Ricty"
                    :height 150)

;;; setting transparency
(set-frame-parameter nil 'alpha 75)

;;; JavaScript js2-mode
(require 'js2-mode)
(defun js2-mode-hooks ()
  (setq js2-basic-offset 2)
  (setq c-basic-offset 2)
  (setq indent-tabs-mode nil))
(add-hook 'js2-mode 'js2-mode-hooks)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

;;; web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml$"     . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp$"       . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x$"   . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb$"       . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?$"     . web-mode))
(add-to-list 'auto-mode-alist '("\\.css?\\'"    . web-mode))
(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2)
(setq web-mode-code-indent-offset 2)
(setq web-mode-m)
(defun web-mode-hooks()
  (setq indent-tabs-mode nil))
(add-hook 'web-mode 'web-mode-hooks)

;;; markdown-mode
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '("\\.markdown" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.txt" . markdown-mode) auto-mode-alist))
(dolist (dir (list
              "/sbin"
              "/usr/sbin"
              "/bin"
              "/usr/bin"
              "/opt/local/bin"
              "/sw/bin"
              "/usr/local/bin"
              (expand-file-name "~/bin")
              (expand-file-name "~/.emacs.d/bin")
              ))
 (when (and (file-exists-p dir) (not (member dir exec-path)))
   (setenv "PATH" (concat dir ":" (getenv "PATH")))
   (setq exec-path (append (list dir) exec-path))))

;;; visualmode same vim
(define-key global-map (kbd "C-u") (kbd "C-@"))

;;; Beginning of line without brank spaces
(define-key global-map (kbd "C-6") (kbd "M-m"))

;;; auto reload buffer when change file
(global-auto-revert-mode 1)

;;; reload buffer
(defun revert-buffer-no-confirm (&optional force-reverting)
  "Interactive call to revert-buffer. Ignoring the auto-save
 file and not requesting for confirmation. When the current buffer
 is modified, the command refuses to revert it, unless you specify
 the optional argument: force-reverting to true."
  (interactive "P")
  ;;(message "force-reverting value is %s" force-reverting)
  (if (or force-reverting (not (buffer-modified-p)))
      (revert-buffer :ignore-auto :noconfirm)
    (error "The buffer has been modified")))

(global-set-key (kbd "s-r") 'revert-buffer-no-confirm)

;;; template
(auto-insert-mode)
(setq auto-insert-directory "~/.emacs.d/templates/")
(define-auto-insert "\\.html$" "html-template.html")
(define-auto-insert "\\.tex$" "tex-template.tex")

;;; auto-complete
(require 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)
