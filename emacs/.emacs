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

;; ;;                
;; (set-frame-height (next-frame) 32)
;; (set-frame-width (next-frame) 40)

;;      
(setq load-path (cons "~/.emacs.d/lisp" load-path))


;;     
;; (require 'auto-complete)
;; (require 'auto-complete-config)
;; (global-auto-complete-mode t)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "/home/shinya/.emacs.d/lisp/ac-dict")
(ac-config-default)


;;Set C-h as Backspace
(global-set-key "\C-h" 'delete-backward-char)


;; YaTex     
;;        
(add-hook 'yatex-mode-hook'(lambda ()(setq auto-fill-function nil)))

;; Don't show menu bar and tool bar
(menu-bar-mode 0)
(tool-bar-mode 0)

;; c-eldoc
;; (require 'c-eldoc)
;; (add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)

; espresso-mode for jQuery
(add-to-list 'load-path "~/.emacs.d/lisp")
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
(setq YaTeX-kanji-code 4)

(require 'flymake)

(defun flymake-cc-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
         (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "g++" (list "-Wall" "-Wextra" "-fsyntax-only" "-std=c++0x" local-file))))

(push '("\\.cpp$" flymake-cc-init) flymake-allowed-file-name-masks)

(add-hook 'c++-mode-hook
          '(lambda ()
             (flymake-mode t)))

;; fullscreen
(defun toggle-fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen (if (frame-parameter nil 'fullscreen)
                                           nil
                                           'maximized)))
(global-set-key [(meta j)] 'toggle-fullscreen)

;; font
(cond
(window-system (set-default-font "Takaoゴシック-12")
(set-fontset-font
(frame-parameter nil 'font)
'japanese-jisx0208
'("Takaoゴシック" . "unicode-bmp")
)))


;; redo+
(require 'redo+)
(when (require 'redo+ nil t)
  (define-key global-map (kbd "C-.") 'redo))

;; Nakatani's wrap-region-by-string function
;; 選択範囲を任意の文字列で囲む。
;; (defun wrap-region-by-string ()
;;   (interactive
;;    (let ((start-point (region-beginning))
;;          (end-point (region-end))
;;          (start-str (read-string "Start: " nil 'my-history))
;;          (end-str (read-string "End: " nil 'my-history)))
;;      (save-excursion
;;        (goto-char start-point)
;;        (insert start-str)
;;        (goto-char (+ end-point (length start-str)))
;;        (insert end-str)))))
;; (global-set-key "\C-xw" 'wrap-region-by-string)

(defun extended-dollar ()
  (interactive
   (let (
         (start-point (region-beginning))
         (end-point (region-end))
         )
     (save-excursion
       (when mark-active
         (goto-char start-point)
         (insert "$")
         (goto-char (+ end-point (length "$")))
         (insert "$")
         )
       )
     )
   )
  )
(global-set-key "\M-$" 'extended-dollar)


(defun current-tex-open ()
  (interactive)
  ;; (setq wd (thing-at-point 'word))
  ;; (message "%s" (current-word))
  (setq tfile-name (elt (split-string (current-word) "{") 1))
  (setq file-name (elt (split-string tfile-name "}") 0))
  (message "%s" file-name)
  ;; (cond ((equal (elt (split-string file-name "\.") 1) "tex")
  ;;     (message "%s" file-name))
  ;;     ((message "not tex")))
  ;; ;; (find-file-literally (current-word))
  (find-file-literally file-name)
  )
(global-set-key "\M-n" 'current-tex-open)

(autoload 'd-mode "d-mode" "Major mode for editing D code." t)
(add-to-list 'auto-mode-alist '("\\.d[i]?\\'" . d-mode))


;;; GDB 関連
;;; 有用なバッファを開くモード
(setq gdb-many-windows t)

;;; 変数の上にマウスカーソルを置くと値を表示
(add-hook 'gdb-mode-hook '(lambda () (gud-tooltip-mode t)))

;;; I/O バッファを表示
(setq gdb-use-separate-io-buffer t)

;;; t にすると mini buffer に値が表示される
(setq gud-tooltip-echo-area nil)

;; php-mode
(load "php-mode")
