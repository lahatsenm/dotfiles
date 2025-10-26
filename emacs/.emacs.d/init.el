(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/")))

(package-initialize)

;; Custom settings in "custom.el"
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
;; Load custom file if it exists
(when (file-exists-p custom-file)
  (load custom-file))

;; Install selected packages automatically
(unless package-archive-contents
  (package-refresh-contents))
(package-install-selected-packages)


;; Theme
;; https://www.reddit.com/r/emacs/comments/rj1wce/how_to_get_colors_and_themes_working_correctly/
(defun load-theme-cleanly (theme)
  "Disable active themes, then load theme."
  (interactive
   (list (intern
          (completing-read "Load Theme: "
                           (mapcar 'symbol-name (custom-available-themes))))))
  (disable-current-themes)
  (load-theme theme t))

(defun disable-current-themes nil
  "Disables all currently enabled themes."
  (interactive)
  (mapcar 'disable-theme custom-enabled-themes))

(load-theme-cleanly 'solarized-dark-high-contrast)

;;----------------------------------------------

(setq ring-bell-function 'ignore)
(setq inhibit-startup-screen t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(column-number-mode 1)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)
(global-auto-revert-mode 1)
;;(blink-cursor-mode -1)
(desktop-save-mode 1)
(recentf-mode 1)
(windmove-default-keybindings)
(ido-mode 1)
(ido-everywhere 1)
(ido-ubiquitous-mode 1)
(ido-yes-or-no-mode 1)
(setq dired-dwim-target t) ;; dired thing

;; Font configuration
(add-to-list 'default-frame-alist '(font . "TX-02-XlabMono-14.3"))
(set-face-attribute 'default nil :font "TX-02-XlabMono" :height 143)
;;(set-face-attribute 'default nil :font "JetBrainsMono" :height 143 :foreground "#E0E0E0")
;;(set-face-attribute 'default nil :font "CascadiaCode" :height 143 :foreground "#E0E0E0")
;;(set-face-attribute 'default nil :font "BerkeleyMono" :height 143 :foreground "#E0E0E0")
;;(set-face-attribute 'default nil :font "RobotoMono" :height 143 :foreground "#E0E0E0")
;;(set-face-attribute 'default nil :font "Iosevka" :height 180 :foreground "#E0E0E0")
;;(set-face-attribute 'default nil :font "comicMono" :height 143 :foreground "#E0E0E0")

;; Fallback fonts
(set-fontset-font t 'unicode "Noto Sans Symbols2" nil 'append)
(set-fontset-font t 'unicode "Noto Sans CJK KR" nil 'append)
(set-fontset-font t 'unicode "FontAwesome" nil 'append)

;;(set-face-attribute 'default nil :font "Comic Code" :height 135 :foreground "#E0E0E0") ;; this is a very beautiful font as well
;;(setq-default line-spacing 0.2) ;; this is better in terms of visual

(customize-set-variable
 'display-buffer-alist
 '(("\\*Occur\\*"
    (display-buffer-below-selected)
    (window-height . 0.30))))

(customize-set-variable
 'display-buffer-alist
 '(("\\*Compilation\\*"
    (display-buffer-below-selected)
    (window-height . 0.30))))

;; I think we don't need this anymore since we are using
;; the package manager directly to install smex
;;(add-to-list 'load-path "~/.emacs.d/lisp/smex")
;;(require 'smex)
;;(smex-initialize)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(defun rc/duplicate-line ()
  "Duplicate current line"
  (interactive)
  (let ((column (- (point) (point-at-bol)))
        (line (let ((s (thing-at-point 'line t)))
                (if s (string-remove-suffix "\n" s) ""))))
    (move-end-of-line 1)
    (newline)
    (insert line)
    (move-beginning-of-line 1)
    (forward-char column)))


;; company-mode in all buffers
(add-hook 'after-init-hook 'global-company-mode)
(with-eval-after-load 'company
  (define-key company-active-map (kbd "<return>") nil)
  (define-key company-active-map (kbd "RET") nil)
  (define-key company-active-map (kbd "<tab>") #'company-complete-selection))

;; LSP configuration
;; !!!!!!!!!!!! NOT USING IT RIGHT NOW !!!!!!!!!!!!!!
;; (use-package lsp-mode
;;   :disabled t
;;   :commands (lsp lsp-deferred)
;;   :init
;;   (setq lsp-keymap-prefix "C-c l")
;;   (setq lsp-headerline-breadcrumb-enable nil))
;; (use-package rust-mode
;;  :hook (rust-mode . lsp-deferred))
;; (use-package c-mode
;;   :hook (c-mode . lsp-deferred))
;; (use-package lua-mode
;;  :hook (lua-mode . lsp-deferred))
;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

;; yasnippet
(require 'yasnippet)
(yas-global-mode 1)

;; KEYBINDINGS
(global-set-key (kbd "C-,") 'rc/duplicate-line)
(global-set-key (kbd "M-n") 'scroll-up-line)
(global-set-key (kbd "M-p") 'scroll-down-line)
(global-set-key (kbd "M-P") 'beginning-of-buffer)
(global-set-key (kbd "M-N") 'end-of-buffer)
(global-set-key (kbd "C-;") 'ido-select-window)
(global-set-key (kbd "M-O") 'resize-window)
(global-set-key (kbd "M-o") 'occur)
(global-set-key (kbd "M-I") 'imenu)
(global-set-key (kbd "C-:") 'rgrep)
(global-set-key [remap dabbrev-expand] 'hippie-expand)
(global-set-key (kbd "C-!") 'avy-goto-line)
(global-set-key (kbd "M-<up>") 'move-text-up)
(global-set-key (kbd "M-<down>") 'move-text-down)

;; sudo-edit
(require 'sudo-edit)
(global-set-key (kbd "C-c C-r") 'sudo-edit)

;; expand-region
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C-)") 'er/contract-region)

;; multiple-cursors
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C-<tab>") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<iso-lefttab>") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<tab>") 'mc/mark-all-like-this)

;; AUCTeX
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

;; beacon
;;(beacon-mode 1)

(pdf-tools-install)

;; Deactivate line numbers in pdf-view-mode to avoid warnings
(require 'display-line-numbers)
(defun display-line-numbers--turn-on ()
  "Turn on `display-line-numbers-mode'."
  (unless (or (minibufferp) (eq major-mode 'pdf-view-mode))
    (display-line-numbers-mode)))

;; Tab MANAGEMENT
(defvar indent-width 4
  "The consistent width I want for indentation and tab display.")

;; Set the default *display* width for tab characters globally
(setq-default tab-width indent-width)

;; Set the default to use spaces ONLY for indentation, never tabs
(setq-default indent-tabs-mode nil)

;; --- C, C++, Java, etc. (using the common hook) ---
(add-hook 'c-mode-common-hook
          (lambda ()
            ;; Ensure buffer-local settings match the desired width
            (setq tab-width indent-width)
            (setq indent-tabs-mode nil)
            ;; Set the indentation offset for C-like modes
            ;; Note: c-basic-offset influences many indentation calculations
            (setq c-basic-offset indent-width)))

;; Spell checking TeX
(add-hook 'tex-mode-hook
          #'(lambda () (setq ispell-parser 'tex)))
;;---------------------------------------------

;; Ocaml
(let ((ocp-path (expand-file-name "~/.opam/default/share/emacs/site-lisp")))
  (when (file-directory-p ocp-path)
    (add-to-list 'load-path ocp-path)
    (require 'ocp-indent)))

;; hyprlang tree-sitter grammar
(with-eval-after-load 'treesit
  (add-to-list 'treesit-language-source-alist
               '(hyprlang "https://github.com/tree-sitter-grammars/tree-sitter-hyprlang")))

(use-package hyprlang-ts-mode
  :if (require 'hyprlang-ts-mode nil 'noerror) ; only load if available
  :ensure t
  :custom
  (hyprlang-ts-mode-indent-offset 4))

;; QML mode
(let ((qml-path "~/.emacs.d/elisp/qml-ts-mode"))
  (when (file-directory-p qml-path)
    (add-to-list 'load-path qml-path)
    (require 'qml-ts-mode nil 'noerror)))
