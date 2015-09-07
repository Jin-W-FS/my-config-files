(server-start)				; server-client mode

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(doc-view-continuous t)		; viewing pdf/ps files continuously
 '(ecb-options-version "2.40")
 '(gdb-many-windows t)
 '(inhibit-startup-screen t)
 '(transient-mark-mode t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; workaround for cedet and ecb
;; bypass cedet-version-max check by ecb
(defconst ecb-cedet-required-version-max '(3 0 0 0)
  "change to this value for cedet has updated to v2.0 but ecb's not")
(setq stack-trace-on-error t)

;; package manager and sources
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   t)
  (package-initialize))

;; linux terminal settings
(xterm-mouse-mode)

;; win32 path settings
(defun winnt-setups ()
  (setenv "HOME" "D:/Develop/emacs-24.5")
  (setenv "PATH" (concat "D:\\Cygwin64\\bin;" "D:/Develop/emacs-24.5/;" "D:/Develop/emacs-24.5/bin/;" (getenv "PATH")))
  (setq default-directory "~")		; set the default file path
  (setq load-path (cons "~/.emacs.d/elisp" load-path))
  (set-face-attribute			; Setting Font
   'default nil :font "WenQuanYi Micro Hei Mono 10"))
(if (eq system-type 'windows-nt) (winnt-setups))

;; common editor options
(show-paren-mode t)
(setq show-paren-style 'parentheses)

(setq column-number-mode t)

(setq-default kill-whole-line t)

;; enable the disabled options
(put 'scroll-left 'disabled nil)

;; modes

;; emacs shell-mode
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on t)
(setenv "PAGER" "cat")		    ;avoid paging error in emacs shell

;; javascript mode
(autoload 'javascript-mode "javascript" nil t)
(add-to-list 'auto-mode-alist '("\\.js\\'" . javascript-mode))
(add-to-list 'auto-mode-alist '("\\.json\\'" . javascript-mode))

;; markdown mode
(autoload 'markdown-mode "markdown-mode" "Major mode for editing Markdown files" t)
;; (add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; gnuplot-mode
(autoload 'gnuplot-mode "gnuplot-mode" "Major mode for editing gnuplot code." t)
(add-to-list 'auto-mode-alist '("\\.plt\\'" . gnuplot-mode))

;; google protobuf mode
;; (add-to-list 'auto-mode-alist '("\\.proto$\\'" . protobuf-mode))

;; csharp-mode
(autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)
(add-to-list 'auto-mode-alist '("\\.cs\\'" . csharp-mode))

;; common c mode
(defun my-c-mode-common-hook ()
  ;; minor modes
  (require 'xcscope)
  (cscope-minor-mode)
  (which-function-mode)		; show which function the cursor is in 
  (c-toggle-auto-state)		; auto insert newline
  (c-toggle-hungry-state)		; delete spaces hungrily
  (imenu-add-menubar-index)
  ;; (setq imenu-sort-function 'imenu-sort-by-name)
  ;; key mappings
  (define-key c-mode-base-map [return] 'newline-and-indent)
  (define-key c-mode-base-map [(control c) (c)] 'compile)
  ;; styles 
  (interactive)
  (c-set-style "linux")
  (setq-default c-basic-offset 8
		tab-width 8
		indent-tabs-mode t))
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;; ;; perl-mode
;; (add-hook 'perl-mode-hook 'linux-perl-mode)
;; (defun linux-perl-mode()
;;   ;;(global-set-key "\C-c \C-e" 'perl-eval)
;;   (cperl-mode)
;;   (interactive)
;;   (which-function-mode)
;;   (imenu-add-menubar-index)
;;   )
;; (defun perl-eval-wall (beg end)
;;   "Run selected region as Perl code"
;;   (interactive "r")
;;   (shell-command-on-region beg end "perl -w")
;;   )
;; (defun perl-eval (beg end)
;;   "Run selected region as Perl code"
;;   (interactive "r")
;;   (shell-command-on-region beg end "perl")
;;   )

;; ;; python mode
;; ;;switch between py2 and 3
;; (defun is-python3-p () "Check whether we're running python 2 or 3."
;;   (setq mystr (car (split-string (buffer-string) "\n" t)))
;;   (with-temp-buffer
;;     (insert mystr)
;;     (goto-char 0)
;;     (search-forward "python3" nil t)))

;; (define run-python (&optional buffer)
;;   (with-current-buffer (or buffer (current-buffer))
;;     (if (is-python3-p)
;; 	(run-python3)
;;       (run-python2))))

;; (define-key python-mode-map (kbd "C-c C-c") #'run-python)


;; functions

