(setq debug-on-error t)

;; MELPA INITIALIZATION
;; https://melpa.org/#/getting-started
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(custom-enabled-themes (quote (wheatgrass)))
 '(package-selected-packages (quote (org-bullets avy helm))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                     ("melpa" . "https://melpa.org/packages/")))


;; HELM INITIALIZATION
;; https://github.com/emacs-helm/helm/wiki#from-melpa
;; & https://tuhdo.github.io/helm-intro.html
(require 'helm-config)
(helm-mode 1)
(global-set-key (kbd "M-x") 'helm-M-x)
(setq org-log-done 'time) ;; Automatic timestamps (see https://orgmode.org/org.html#Closing-items
(setq org-agenda-files '("~/org")) ;; Include .org files in ~/org to the agenda
;; Modify agenda to "next" seven days (starting yesterday)n
;;    https://emacs.stackexchange.com/questions/12517/how-do-i-make-the-timespan-shown-by-org-agenda-start-yesterday
(setq org-agenda-start-day "-1d")
(setq org-agenda-span 7)
(setq org-agenda-start-on-weekday nil)

;; Avy (jump mode) key binding(s)
;; https://github.com/abo-abo/avy
(global-set-key (kbd "C-'") 'avy-goto-char-2)


;; Fancy ⚫ Bullets
;; https://zhangda.wordpress.com/2016/02/15/configurations-for-beautifying-emacs-org-mode/
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(setq org-bullets-bullet-list '("○" "☉" "◎" "◉" "○" "◌" "◎" "●" "◦" "◯" "⚪" "⚫" "⚬" "❍" "￮" "⊙" "⊚" "⊛" "∙" "∘"** 
))

;; Fancy ellipsis
;; http://endlessparentheses.com/changing-the-org-mode-ellipsis.html
(setq org-ellipsis " ⇥")

;; Show line numbers
;; https://superuser.com/a/1328642/44624
(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))

;; UTF-8 IN EMACS: EVERYWHERE, FOREVER
;; https://thraxys.wordpress.com/2016/01/13/utf-8-in-emacs-everywhere-forever/
;; (Honestly, not entirely sure how this changes behavior, but it seems like sound advice, so…leap of faith.)
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(when (display-graphic-p)
   (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING)))

;; Add TODO keywords
;; https://thraxys.wordpress.com/2016/01/14/pimp-up-your-org-agenda/
(setq org-todo-keywords
      '((sequence "TODO" "IN PROGRESS" "WAITING FOR" "|" "DONE" "DELETED")))

;; Save minibuffer history between emacs invocations
;;   in order to access recently-opened files w/arrow keys
;; https://stackoverflow.com/a/16147575/230615
(savehist-mode 1)

;; Enable Narrowing
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Narrowing.html
(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-region 'disabled nil)

;; Default regex builder syntax to allow single backslashes
;; https://www.masteringemacs.org/article/re-builder-interactive-regexp-builder
(require 're-builder)
(setq reb-re-syntax 'string)

;; Display load time of this file in order to detect .emacs bog-down
;; http://cheat.errtheblog.com/s/emacs_tips
(require 'cl)
(message "Emacs loaded in %fs\n"
         (* 0.000001 (apply #'-
                            (mapcar (lambda (time)
                                      (+ (* 1000000 (+ (* 65536 (first time)) (second time))) (third time)))
                                    (list (current-time) before-init-time)))))

;; Put autosave files (ie #foo#) in one place, *not*
;; scattered all over the file system!
;; http://cheat.errtheblog.com/s/emacs_tips
(defvar autosave-dir
 (concat "/tmp/emacs_autosaves/" (user-login-name) "/"))
(make-directory autosave-dir t)
(setq auto-save-file-name-transforms `(("\\(?:[^/]*/\\)*\\(.*\\)" ,(concat autosave-dir "\\1") t)))

;; Put backup files (ie foo~) in one place too. (The backup-directory-alist
;; list contains regexp=>directory mappings; filenames matching a regexp are
;; backed up in the corresponding directory. Emacs will mkdir it if necessary.)
;; http://cheat.errtheblog.com/s/emacs_tips
(defvar backup-dir (concat "/tmp/emacs_backups/" (user-login-name) "/"))
(setq backup-directory-alist (list (cons "." backup-dir)))
