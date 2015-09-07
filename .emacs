(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(doc-view-continuous t)
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
(xterm-mouse-mode)

;; bypass cedet-version-max check by ecb
(defconst ecb-cedet-required-version-max '(3 0 0 0)
  "change to this value for cedet has updated to v2.0 but ecb's not")

;; auto save/load last session ;; not include program generated buffers.
;; (desktop-save-mode 1)

;; (require 'imenu+)
;; (require 'dictem)
;; (require 'protobuf-mode)
;; (require 'php-mode)
;; (require 'go-mode)

;; (setq py-install-directory "/usr/share/emacs/site-lisp/python-mode.el-6.1.3/")
;; (add-to-list 'load-path py-install-directory)
;; (require 'ipython)
;; (require 'python-mode)
;; (when (featurep 'python) (unload-feature 'python t))

;; (add-to-list 'auto-mode-alist '("\\.proto\\'" . protobuf-mode))
(add-to-list 'auto-mode-alist '("\\.plt\\'" . gnuplot-mode))

;;set linux-c-mode
(setq stack-trace-on-error t)
(add-hook 'c-mode-common-hook  '(lambda () (require 'xcscope)))
(add-hook 'c-mode-hook 'linux-c-mode)
(add-hook 'c++-mode-hook 'linux-cpp-mode)
;; 设置imenu的排序方式为按名称排序
;; (setq imenu-sort-function 'imenu–sort-by-name)
(defun linux-c-mode()
  ;; 将回车代替C-j的功能，换行的同时对齐
  (define-key c-mode-map [return] 'newline-and-indent)
  (interactive)
  ;; 设置C程序的对齐风格
  (c-set-style "K&R")
  ;; 自动模式，在此种模式下当你键入{时，会自动根据你设置的对齐风格对齐
  (c-toggle-auto-state)
  ;; 此模式下，当按Backspace时会删除最多的空格
  (c-toggle-hungry-state)
  ;; TAB键的宽度设置为8
  (setq c-basic-offset 8)
  ;; 在状态条上显示当前光标在哪个函数体内部
  (which-function-mode)
  ;; 在菜单中加入当前Buffer的函数索引
  (imenu-add-defs-to-menubar)
  )

(defun linux-cpp-mode()
  (define-key c++-mode-map [return] 'newline-and-indent)
  (define-key c++-mode-map [(control c) (c)] 'compile)
  (interactive)
  (c-set-style "K&R")
  (c-toggle-auto-state)
  (c-toggle-hungry-state)
  (setq c-basic-offset 8)
  (which-function-mode)
  (imenu-add-defs-to-menubar)
  )

(put 'scroll-left 'disabled nil)

;; perl-mode
(add-hook 'perl-mode-hook 'linux-perl-mode)
(defun linux-perl-mode()
  ;;(global-set-key "\C-c \C-e" 'perl-eval)
  (cperl-mode)
  (interactive)
  (which-function-mode)
  (imenu-add-menubar-index)
  )
(defun perl-eval-wall (beg end)
  "Run selected region as Perl code"
  (interactive "r")
  (shell-command-on-region beg end "perl -w")
  )
(defun perl-eval (beg end)
  "Run selected region as Perl code"
  (interactive "r")
  (shell-command-on-region beg end "perl")
  )

;; shell-mode
;; enable ansi color
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on t)
(setenv "PAGER" "cat")

;; javascript mode
;; additional javascript.el
(add-to-list 'auto-mode-alist '("\\.js\\'" . javascript-mode))
(add-to-list 'auto-mode-alist '("\\.json\\'" . javascript-mode))
(autoload 'javascript-mode "javascript" nil t)

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

;; auto add header graud
(define-auto-insert
  (cons "\\.\\([Hh]\\|hh\\|hpp\\)\\'" "My C / C++ header")
  '(nil
    "// " (file-name-nondirectory buffer-file-name) "\n"
    "//\n"
    "// last-edit-by: <> \n"
    "//\n"
    "// Description:\n"
    "//\n"
    (make-string 70 ?/) "\n\n"
    (let* ((noext (substring buffer-file-name 0 (match-beginning 0)))
	   (nopath (file-name-nondirectory noext))
	   (ident (concat (upcase nopath) "_H")))
      (concat "#ifndef " ident "\n"
	      "#define " ident  " 1\n\n\n"
	      "\n\n#endif // " ident "\n"))
    (make-string 70 ?/) "\n"
    "// $Log:$\n"
    "//\n"
    ))

;; markdown mode
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
;; (add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
