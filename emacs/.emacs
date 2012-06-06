;enable font-lock
(when(fboundp 'global-font-lock-mode)(global-font-lock-mode t))
(setq font-lock-maximum-decoration t)

;use UTF-8
;(if (= emacs-major-version 21)
;    (require 'un-define))
(coding-system-put 'utf-8 'category 'utf-8)
(set-language-info "Japanese" 'coding-priority(cons 'utf-8(get-language-info "Japanese" 'coding-priority)))
(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)

; highlight selected region
(transient-mark-mode t)

;use bash
(setq explicit-shell-file-name "/bin/bash") 
(setq shell-file-name "/bin/bash")
(setq shell-command-switch "-c")

;hide inputting password
(add-hook 'comint-output-filter-functions 'comint-watch-for-password-prompt)

;handle escape sequences
(autoload 'ansi-color-for-comint-mode-on "ansi-color"
          "Set `ansi-color-for-comint-mode' to t." t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;use UTF-8
(add-hook 'shell-mode-hook(lambda()(set-buffer-process-coding-system 'utf-8 'utf-8)))

(if window-system (menu-bar-mode 1) ( menu-bar-mode -1))

;;       
(column-number-mode t)
;;       
(line-number-mode t)

;;                 
(setq inhibit-startup-message t)

;;                
(set-frame-height (next-frame) 32)
(set-frame-width (next-frame) 80)

;;      
(setq load-path (cons "~/.emacs.d" load-path))


;;     
(require 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)


;;Set C-h as Backspace
(global-set-key "\C-h" 'delete-backward-char)

;; YaTex     
;;        
(add-hook 'yatex-mode-hook'(lambda ()(setq auto-fill-function nil)))

;; Don't show menu bar and tool bar
(menu-bar-mode 0)
(tool-bar-mode 0)

;; c-eldoc
(require 'c-eldoc)
(add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)

; espresso-mode for jQuery
(add-to-list 'load-path "~/.emacs.d")
(autoload #'espresso-mode "espresso" "Start espresso-mode" t)
(add-to-list 'auto-mode-alist '("\\.js$" . espresso-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . espresso-mode))

;;; YaTeX
;; yatex-mode の起動
(setq auto-mode-alist 
       (cons (cons "\.tex$" 'yatex-mode) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
;; 野鳥が置いてある directry の load-path 設定
;; default で load-path が通っている場合は必要ありません
(setq load-path
     (cons (expand-file-name
            "/usr/share/emacs/site-lisp/yatex") load-path))
;; 文章作成時の日本語文字コード
;; 0: no-converion
;; 1: Shift JIS (windows & dos default)
;; 2: ISO-2022-JP (other default)
;; 3: EUC
;; 4: UTF-8
(setq YaTeX-kanji-code 2)

(require 'flymake)

(defun flymake-cc-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
         (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "g++" (list "-Wall" "-Wextra" "-fsyntax-only" local-file))))

(push '("\\.cpp$" flymake-cc-init) flymake-allowed-file-name-masks)

(add-hook 'c++-mode-hook
          '(lambda ()
             (flymake-mode t)))
