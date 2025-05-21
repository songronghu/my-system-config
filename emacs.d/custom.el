
;;                                                                          ;;
;;           Torstein Krause Johansen's .emacs file                         ;;
;;                                                                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 00 Table of contents
;;
;; Evaluate it with C-x C-e / eval-last-sexp to get toc in its own buffer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (occur "^;; [0-9]+")

;; Don't show the warnings buffer just because some package has used a
;; deprecated API
(setq warning-minimum-level :error)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 01 Name and email
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq user-full-name "song"
      user-mail-address "song@qq.com")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 10 Appearance
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(menu-bar-mode 0)
(setq column-number-mode t)

(when window-system
  (setq ring-bell-function 'ignore)
  (set-fringe-style 0)
  (set-cursor-color "red")
  (set-scroll-bar-mode nil)
  (tool-bar-mode 0)
  (pixel-scroll-precision-mode 1)
  ;; (set-face-attribute 'default nil :font "Monospace 12")
  ;; (set-face-attribute 'default nil
  ;;                     :family "Monospace"
  ;;                     :height 120
  ;;                     ;;:weight 'medium
  ;;                     :weight 'normal
  ;;                     ;;:width 'normal
  ;;                     ))
  (set-face-attribute 'default nil
                      :family "Source Code Pro"
                      :height 110
                      ;;:weight 'medium
                      :weight 'normal
                      :width 'normal
                      ))

;; (use-package sweet-theme
;;   :ensure t
;;   :init
;;   (load-theme 'sweet t))

(use-package sweet-theme
  :ensure t
  :init
  (load-theme 'tango-dark t))

(use-package doom-modeline
  :ensure t
  :hook
  (after-init . doom-modeline-mode))

(defun tkj/present()
  (interactive)
  (global-hl-line-mode)
  (global-display-line-numbers-mode)
  (set-face-attribute 'default nil :height 110))

(defun tkj/unpresent()
  (interactive)
  (global-display-line-numbers-mode -1)
  (set-face-attribute 'default nil :height 110))

(defun tkj/load-theme()
  (interactive)
  (let ((theme
         (intern
          (completing-read
           "Load theme: "
           (mapcar #'symbol-name (custom-available-themes))))))

    (dolist (theme custom-enabled-themes)
      (disable-theme theme))
    (load-theme theme t)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 20 Global shortcuts
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Navigate between buffers
(global-set-key "\M-p" 'previous-buffer)
(global-set-key "\M-n" 'next-buffer)

;; Navigate between visible buffers (windows in emacs speak)
(defun other-window-backward (&optional n)
  (interactive "p")
  (if n
      (other-window (- n))
    (other-frame -1)))
(global-set-key "\C-x\C-n" 'other-window)
(global-set-key "\C-x\C-p" 'other-window-backward)

;; Quickly switch between open buffer windows
(use-package ace-window
  :ensure t
  :bind
  ("M-o" . ace-window)
  :config
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)
        aw-dispatch-always t))

;; Give a pulse light when switching windows, or switching focus to
;; the minibuffer.
(require 'pulse)
(set-face-attribute 'pulse-highlight-start-face nil :background "#49505f")
(add-hook 'window-selection-change-functions
          (lambda (frame)
            (when (eq frame (selected-frame))
              (pulse-momentary-highlight-one-line))))

;; Don't report all saves
(setq save-silently t)

;; Balance window splits automatically
(setf window-combination-resize t)

;; Revert
(global-set-key  [ (f5) ] 'revert-buffer-quick)
(global-auto-revert-mode 1)
(setq revert-without-query (list "\\.png$" "\\.svg$")
      auto-revert-verbose nil)

(global-set-key "\M- " 'hippie-expand)
;;(global-set-key "\M-r" 'join-line)

;; Minimising & quitting Emacs way too many times without wanting to.
;;(global-unset-key "\C-z")
;;(global-unset-key "\C-x\C-c")

;; Don't write backslashed to indicate continuous lines
(set-display-table-slot standard-display-table 'wrap ?\ )

;; Treat 'y' or <CR> as yes, 'n' as no.
(fset 'yes-or-no-p 'y-or-n-p)

;;(global-set-key "\C-c\C-c" 'compile)

;; From https://www.emacswiki.org/emacs/KillingBuffer
(defun kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))

(use-package multiple-cursors
  :ensure t
  :bind
  ("C->" . 'mc/mark-next-like-this))

;; Minibuffer and buffer navigation
(use-package counsel
  :bind (("C-M-j" . 'counsel-switch-buffer)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history)
         ("C-h f" . 'counsel-describe-function)
         )
  :custom
  (counsel-linux-app-format-function #'counsel-linux-app-format-function-name-only)
  :config
  (counsel-mode 1))


(use-package smex
  :ensure t
  :bind
  ("M-x" . smex))

(use-package ido-vertical-mode
  :ensure t
  :init
  (setq ido-vertical-indicator ">"
        ido-vertical-define-keys 'C-n-C-p-up-and-down)
  )

;; Sub word support
(add-hook 'minibuffer-setup-hook 'subword-mode)

;; Find file at point
(global-set-key "\C-\M-f" 'find-file-at-point)

;; recentf
;; Maintain a list of recent files opened
(recentf-mode 1)
(setq recentf-max-saved-items 50)
(global-set-key (kbd "C-c f") 'recentf-open-files)

(use-package dumb-jump
  :ensure t
  :init
  (setq xref-show-definitions-function #'xref-show-definitions-completing-read)

  :config
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate))

(use-package ivy
  :ensure t
  :config
  (ivy-mode 1))

(use-package ivy-xref
  :ensure t
  :init
  (setq xref-show-definitions-function #'ivy-xref-show-defs)
  (setq xref-show-xrefs-function #'ivy-xref-show-xrefs))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 21 Search
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key "\C-cn" 'find-dired)
(global-set-key "\C-cN" 'grep-find)
(use-package use-package-chords
  :ensure t
  :init
  :config (key-chord-mode 1)
  (setq key-chord-two-keys-delay 0.4)
  (setq key-chord-one-key-delay 0.5) ; default 0.2
  )

(use-package avy
  :ensure t
  :chords)

;; Show current and total count
(setq isearch-lazy-count t)
(setq lazy-count-prefix-format nil)
(setq lazy-count-suffix-format "   (%s/%s)")

(use-package grep
  :ensure t
  :config
  (setq grep-find-ignored-directories
        (append
         (list
          ".git"
          ".idea"
          ".project"
          ".settings"
          ".svn"
          ".m2"
          ".local"
          ".config"
          "3rdparty"
          "bootstrap*"
          "pyenv"
          "target"
          )
         grep-find-ignored-directories))
  (setq grep-find-ignored-files
        (append
         (list
          "*.blob"
          "*.class"
          "*.gz"
          "*.jar"
          "*.pack"
          "*.xd"
          ".factorypath"
          "TAGS"
          "dependency-reduced-pom.xml"
          "projectile.cache"
          "workbench.xmi"
          )
         grep-find-ignored-files)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 22 Occur
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(advice-add 'isearch-occur :after
            '(lambda (origin &rest args)
               (isearch-exit)
               (select-window (get-buffer-window "*Occur*"))
               (goto-char (point-min))))

(advice-add 'occur :after
            '(lambda (origin &rest args)
               (isearch-exit)
               (select-window (get-buffer-window "*Occur*"))
               (goto-char (point-min))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 23 Reading & writing files
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Tell emacs to skip backup files
(setq make-backup-files nil)
;; Yes, I want large files
(setq large-file-warning-threshold 150000000)

;; Rename current buffer, as well as doing the related version control
;; commands to rename the file.
(defun rename-this-buffer-and-file ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (message "Buffer is not visiting a file!")
      (let ((new-name (read-file-name "New name: " filename)))
        (cond
         ((vc-backend filename) (vc-rename-file filename new-name))
         (t
          (rename-file filename new-name t)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil)
          (message
           "File '%s' successfully renamed to '%s'"
           filename
           (file-name-nondirectory new-name))))))))
(global-set-key (kbd "C-x C-r") 'rename-this-buffer-and-file)

;; Follow symlinks, just tell me about it
(setq vc-follow-symlinks t)

(defun tkj/copy-vc-link()
  "Copies the corresponding Bitbucket web URI of the current buffer
and line number."
  (interactive)
  (let ((file-name (file-relative-name buffer-file-name (vc-git-root buffer-file-name)))
        (repo-name (file-name-nondirectory (directory-file-name (vc-git-root buffer-file-name))))
        (git-url (magit-get "remote" "origin" "url"))
        (bitbucket-project-pattern ".*/\\([a-zA-Z0-9_-]+\\)/.*\\.git$")
        (bitbucket-revision (vc-working-revision (buffer-file-name) 'git))
        (bitbucket-project "FOO"))

    (when (string-match bitbucket-project-pattern git-url)
      (setq bitbucket-project (match-string 1 git-url)))

    (kill-new
     (concat "https://jira.stibodx.com/stash/projects/"
             bitbucket-project
             "/repos/" repo-name "/browse/" file-name
             "?at=" bitbucket-revision
             "#" (number-to-string (line-number-at-pos))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 24 White space
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq tab-width 4)
(setq-default indent-tabs-mode nil)
(global-visual-line-mode)

;; This disables bidirectional text to prevent "trojan source"
;; exploits, see https://www.trojansource.codes/
(setf (default-value 'bidi-display-reordering) nil)

;; ws-butler cleans up whitespace only on the lines you've edited,
;; keeping messy colleagues happy ;-) Important that it doesn't clean
;; the whitespace on currrent line, otherwise, eclim leaves messy
;; code behind.
(use-package ws-butler
  :ensure t
  :init
  (setq ws-butler-keep-whitespace-before-point nil)
  :config
  (ws-butler-global-mode))

(defun tkj/indent-and-fix-whitespace()
  (interactive)
  (delete-trailing-whitespace)
  (untabify (point-min) (point-max))
  (indent-region (point-min) (point-max)))
(global-set-key "\C-\M-\\" 'tkj/indent-and-fix-whitespace)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Prefer UTF 8, but don't override current encoding if specified
;; (unless you specify a write hook).
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(prefer-coding-system 'utf-8-unix)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 30 Version control
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Editing VC log messages
(add-hook 'log-edit-hook (lambda () (flyspell-mode 1)))

(use-package magit
  :ensure t
  :config
  (setq magit-log-arguments '("-n256" "--graph" "--decorate" "--color")
        ;; Show diffs per word, looks nicer!
        magit-diff-refine-hunk t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 40 Text buffers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package ispell
  :init
  (setq ispell-program-name "hunspell"
        ispell-list-command "list"
        ;; The dictionary must reside in /usr/share/hunspell
        ispell-dictionary "en_GB")
  :hook ((prog-mode . flyspell-prog-mode)))

(defun tkj/copy-uri-encoded-region()
  "URI encodes the current active region and puts it on the kill
ring (clipboard)."
  (interactive)
  (kill-new
   (url-hexify-string
    (buffer-substring-no-properties (mark) (point)))))

(defun tkj/markdown-to-confluence ()
  "Convert all Markdown to Confluence/Jira markup in the selected
region or the entire buffer if no region is selected."
  (interactive)
  (save-excursion
    (let ((start (if (use-region-p) (region-beginning) (point-min)))
          (end (if (use-region-p) (region-end) (point-max))))

      (goto-char start) (while (re-search-forward "```.*" end t) (replace-match "{code}"))
      (goto-char start) (while (re-search-forward "`\\([^`]+\\)`" end t) (replace-match "{\\1}"))
      (goto-char start) (while (search-forward "######" end t) (replace-match "h6. "))
      (goto-char start) (while (search-forward "#####" end t) (replace-match "h5. "))
      (goto-char start) (while (search-forward "####" end t) (replace-match "h4. "))
      (goto-char start) (while (search-forward "###" end t) (replace-match "h3. "))
      (goto-char start) (while (search-forward "##" end t) (replace-match "h2. "))
      (goto-char start) (while (search-forward "#" end t) (replace-match "h1. "))
      )))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Latex and bibtex
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq bibtex-align-at-equal-sign t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 50 Clipboard
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package xclip
  :ensure t
  :init
  (xclip-mode 1))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Date, time and calendar
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun tkj/insert-date ()
  (interactive)
  (let (( time (current-time-string) ))
    (insert (format-time-string "%Y-%m-%d"))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 60 Programming buffers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Highlight blocks of code in bold
;;(setq show-paren-style 'expression)
;;(set-face-attribute 'show-paren-match nil :weight 'extra-bold)

;; Don't ask before killing the current compilation. This is useful if
;; you're running servers after compiling them, so that the
;; compilation never finishes.
(setq compilation-ask-about-save nil
      compilation-always-kill t
      compilation-scroll-output t
      compile-command "~/bin/tc")

;; Taken from
;; https://emacs.stackexchange.com/questions/31493/print-elapsed-time-in-compilation-buffer/56130#56130
(make-variable-buffer-local 'my-compilation-start-time)

(add-hook 'compilation-start-hook #'my-compilation-start-hook)
(defun my-compilation-start-hook (proc)
  (setq my-compilation-start-time (current-time)))

(add-hook 'compilation-finish-functions #'my-compilation-finish-function)
(defun my-compilation-finish-function (buf why)
  (let* ((elapsed  (time-subtract nil my-compilation-start-time))
         (msg (format "Compilation took: %s" (format-time-string "%T.%N" elapsed t))))
    (save-excursion (goto-char (point-max)) (insert msg))
    (message "Compilation %s: %s" (string-trim-right why) msg)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 70 Projectile
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package projectile
  :ensure t
  :config
  (projectile-global-mode)
  :bind (;;("C-t" . projectile-grep)
         ("C-c p g" . projectile-grep)))
(use-package counsel-projectile
  :ensure t
  :bind
  (("C-c p f" . counsel-projectile-find-file)
   ("C-c p s j" . counsel-projectile-rg)
   ("C-c p p" . counsel-projectile-switch-project)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 71 fly check
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package flycheck :ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 72 snippets
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package yasnippet
  :ensure t
  :config
  (setq yas/root-directory
        (list "~/.emacs.d/snippets")
        yas-indent-line 'fixed)
  (yas-global-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 73 company - complete any aka company
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package company
  :ensure t
  :config
  (global-set-key (kbd "<C-return>") 'company-complete)
  (global-company-mode 1))

;; Get auto completion of :emoji: names.
(use-package company-emoji
  :ensure t
  :after company-mode
  :config
  (company-emoji-init))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 80 Java
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq eldoc-echo-area-use-multiline-p nil)
(use-package eglot-java :ensure t)
(use-package eglot
  :config
  (setq eglot-report-progress nil)
  :bind
  (("M-RET" . eglot-code-actions)))

(setq eglot-java-user-init-opts-fn 'custom-eglot-java-init-opts)
(defun custom-eglot-java-init-opts ( &optional server eglot-java-eclipse-jdt)
  "Custom options that will be merged with any default settings."
  ;;:bundles ["/home/me/.emacs.d/lsp-bundles/com.microsoft.java.debug.plugin-0.50.0.jar"]
  `(:bundles ["/home/ronghusong/.emacs.d/share/eclipse.jdt.ls/com.microsoft.java.debug.plugin-0.53.1.jar"]))
    ;;自动下载java调试插件`(:bundles [,(download-java-debug-plugin)]))
    ;;`(:bundles [,(download-java-debug-plugin)])

(use-package dape
  :ensure t
  :commands (dape)
  :init
  (require 'hydra)
  (defhydra dape-hydra (:hint nil)
    "
     ^Stepping^           ^Breakpoints^               ^Info
     ^^^^^^^^-----------------------------------------------------------
     _n_: Next            _bb_: Toggle (add/remove)   _si_: Info
     _i_/_o_: Step in/out   _bd_: Delete                _sm_: Memory
     _<_/_>_: Stack up/down _bD_: Delete all            _ss_: Select Stack
     _c_: Continue        _bl_: Set log message       _R_: Repl
     _r_: Restart
     _d_: Init   _k_: Kill   _q_: Quit
     "
    ("n" dape-next)
    ("i" dape-step-in)
    ("o" dape-step-out)
    ("<" dape-stack-select-down)
    (">" dape-stack-select-up)
    ("c" dape-continue)
    ("r" dape-restart)
    ("ba" dape-breakpoint-toggle)
    ("bb" dape-breakpoint-toggle)
    ("be" dape-breakpoint-expression)
    ("bd" dape-breakpoint-remove-at-point)
    ("bD" dape-breakpoint-remove-all)
    ("bl" dape-breakpoint-log)
    ("si" dape-info)
    ("sm" dape-read-memory)
    ("ss" dape-select-stack)
    ("R"  dape-repl)
    ("d" dape)
    ("k" dape-kill :color blue)
    ("q" dape-quit :color blue))
  (global-set-key (kbd "C-c d") 'dape-hydra/body))

(defun download-java-debug-plugin ()
  (let ((cache-dir (expand-file-name "~/.cache/emacs/"))
        (url "https://repo1.maven.org/maven2/com/microsoft/java/com.microsoft.java.debug.plugin/maven-metadata.xml")
        (version nil)
        (jar-file-name nil)
        (jar-file nil))
    (unless (file-directory-p cache-dir)
      (make-directory cache-dir t))
    (setq jar-file (car (directory-files cache-dir nil "com\\.microsoft\\.java\\.debug\\.plugin-\\([0-9]+\\.[0-9]+\\.[0-9]+\\)\\.jar" t)))
    (if jar-file
        (expand-file-name jar-file cache-dir)
      (with-temp-buffer
        (url-insert-file-contents url)
        (when (re-search-forward "<latest>\\(.*?\\)</latest>" nil t)
          (setq version (match-string 1))
          (setq jar-file-name (format "com.microsoft.java.debug.plugin-%s.jar" version))
          (setq jar-file (expand-file-name jar-file-name cache-dir))
          (unless (file-exists-p jar-file)
            (setq url (format "https://repo1.maven.org/maven2/com/microsoft/java/com.microsoft.java.debug.plugin/%s/%s"
                              version jar-file-name))
            (message url)
            (url-copy-file url jar-file))
          jar-file)))))

;; (setq eglot-java-user-init-opts-fn 'custom-eglot-java-init-opts)
;; (defun custom-eglot-java-init-opts (server eglot-java-eclipse-jdt)
;;   "Custom options that will be merged with any default settings."
;;   '(:bundles: ["/home/ronghusong/.emacs.d/share/eclipse.jdt.ls/plugins/com.microsoft.java.debug.plugin-0.53.1.jar"]
;;               :workspaceFolders: ["/home/ronghusong/IdeaProjects/Tiantu-Respository/branches/anra-server"]
;;               :settings: (:java
;;                           (:home "/usr/lib/jvm/java-21-openjdk-amd64")
;;                           (:format
;;                            (:settings
;;                             (:url "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml")
;;                             :enabled t)))
;;               :extendedClientCapabilities (:classFileContentsSupport t)))

(add-hook 'java-mode-hook 'eglot-java-mode)
(add-hook 'eglot-java-mode-hook (lambda ()
                                  (define-key eglot-java-mode-map (kbd "C-c l n") #'eglot-java-file-new)
                                  (define-key eglot-java-mode-map (kbd "C-c l x") #'eglot-java-run-main)
                                  (define-key eglot-java-mode-map (kbd "C-c l t") #'eglot-java-run-test)
                                  (define-key eglot-java-mode-map (kbd "C-c l N") #'eglot-java-project-new)
                                  (define-key eglot-java-mode-map (kbd "C-c l T") #'eglot-java-project-build-task)
                                  (define-key eglot-java-mode-map (kbd "C-c l R") #'eglot-java-project-build-refresh)
                                  ;; 绑定 M-. 到 eglot-find-implement
                                  (local-set-key (kbd "M-.") #'eglot-find-implement)))

(defun tkj/default-code-style-hook()
  (setq c-basic-offset 4
        c-label-offset 0
        indent-tabs-mode nil
        compile-command "~/bin/tc"
        require-final-newline nil))
(add-hook 'java-mode-hook 'tkj/default-code-style-hook)

(defun my-java-mode-hook ()
  (auto-fill-mode)
  (flycheck-mode)
  (subword-mode)
  (yas-minor-mode)
  (when window-system
    (set-fringe-style '(4 . 0)))

  ;; Fix indentation for anonymous classes
  (c-set-offset 'substatement-open 0)
  (if (assoc 'inexpr-class c-offsets-alist)
      (c-set-offset 'inexpr-class 0))

  ;; Indent arguments on the next line as indented body.
  (c-set-offset 'arglist-intro '++))
(add-hook 'java-mode-hook 'my-java-mode-hook)

(defun tkj/configure-xref-for-eglot-java ()
  (setq xref-backends '(eglot-xref-backend
                        go-xref-backend
                        python-xref-backend
                        javascript-xref-backend
                        typescript-xref-backend
                        csharp-xref-backend
                        clojure-xref-backend
                        rust-xref-backend
                        ruby-xref-backend
                        )))

(add-hook 'java-mode-hook 'tkj/configure-xref-for-eglot-java)

(defun tkj/java-run-junit-at-point ()
  "Run the JUnit test method or class at point."
  (interactive)
  (let* ((method-name (thing-at-point 'symbol t))
         (class-name (file-name-sans-extension (file-name-nondirectory buffer-file-name)))
         (pom-file (locate-dominating-file (or (buffer-file-name) default-directory) "pom.xml")))
    (if (and method-name class-name pom-file)
        (let* ((default-directory (file-name-directory pom-file))
               (test-param (if (string-equal class-name method-name)
                               class-name
                             (format "%s#%s" class-name method-name)))
               (command (format "mvn --batch-mode --file %s test -Dtest=%s"
                                (expand-file-name "pom.xml" pom-file)
                                test-param)))
          (compilation-start command 'compilation-mode
                             (lambda (_) (format "Run JUnit: %s" test-param))))
      (message "Unable to determine method, class, or pom.xml file."))))
(add-hook 'java-mode-hook (lambda () (local-set-key (kbd "C-c t") #'tkj/java-run-junit-at-point)))

(setq fernflower-path "/home/ronghusong/.emacs.d/share/eclipse.jdt.ls/fernflower.jar")
(defun tkj/java-decompile-class ()
  "Run the FernFlower decompiler on the current .class file using
 fernflower, and opens the decompiled Java file."
  (interactive)
  (let* ((current-file (buffer-file-name))
         (output-dir (concat (file-name-directory current-file) "decompiled/"))
         (decompiled-file (concat output-dir (file-name-base current-file) ".java"))
         (command (format "java -jar %s %s %s"
                          (shell-quote-argument fernflower-path)
                          (shell-quote-argument current-file)
                          (shell-quote-argument output-dir))))
    (if (and current-file (string-equal (file-name-extension current-file) "class"))
        (progn
          (unless (file-directory-p output-dir)
            (make-directory output-dir t))
          (message "Running FernFlower decompiler...")
          (shell-command command)
          (if (file-exists-p decompiled-file)
              (find-file decompiled-file)
            (message "Error: Decompiled file not found at %s" decompiled-file)))
      (message "Error: This command can only be run on .class files"))))

(defun tkj/java-maven-coordinate-to-dependency()
  "Convert the Maven coordinate in the active region to a Maven <dependency> block."
  (interactive)
  (if (use-region-p)
      (let* ((coordinate (buffer-substring-no-properties (region-beginning) (region-end)))
             (parts (split-string coordinate ":"))
             (group-id (nth 0 parts))
             (artifact-id (nth 1 parts))
             (type (nth 2 parts))
             (version (nth 3 parts))
             (dependency (format "<dependency>
  <groupId>%s</groupId>
  <artifactId>%s</artifactId>
  <type>%s</type>
  <version>%s</version>
</dependency>"
                                 group-id artifact-id type version))
             (start (region-beginning)))
        (delete-region (region-beginning) (region-end))
        (insert dependency)
        (indent-region start (point)))
    (message "No active region. Please select a Maven coordinate to convert.")))

(defun my/java-run-main ()
  "Run the main class using eglot-java."
  (interactive)
  (if (fboundp 'eglot-java-run-main)
    (call-interactively #'eglot-java-run-main)
    (message "eglot-java-run-main not available")))

(with-eval-after-load 'eglot-java
                      (define-key eglot-java-mode-map (kbd "C-c C-c") #'my/java-run-main))

(defun my/java-kill-process ()
  "Kill the Java process running in *compilation* or similar buffer."
  (interactive)
  (let ((buffer (get-buffer "*compilation*")))
    (if (and buffer (get-buffer-process buffer))
        (kill-process (get-buffer-process buffer))
      (call-interactively #'kill-process))))  ;; fallback: prompt user

;; 提高调试性能
(setq read-process-output-max (* 1024 1024)) ;; 1mb
;; debugger
(add-to-list 'eglot-server-programs
             `((java-mode java-ts-mode) .
               ("jdtls"
                :initializationOptions
                (:bundles ["/home/ronghusong/.emacs.d/share/eclipse.jdt.ls/com.microsoft.java.debug.plugin-0.53.1.jar"]))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 81 go
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'treesit) ;; 确保 Tree-sitter 可用
(setq custom-tab-width 2)
(add-hook 'go-ts-mode-hook 'eglot-ensure)
(defun my-go-run ()
  "Run all Go files in the current directory."
  (interactive)
  (save-buffer) ;; 自动保存当前文件
  (let ((dir (file-name-directory buffer-file-name)))
    (setq-local compile-command (format "go run %s" (shell-quote-argument dir)))
    (call-interactively #'compile)))

(add-hook 'go-ts-mode-hook
          (lambda ()
            ;; 使用 eglot 组织导入
            (add-hook 'before-save-hook
                      (lambda ()
                        (call-interactively 'eglot-code-action-organize-imports))
                      nil t)
            ;; 绑定快捷键运行 Go 代码
            (local-set-key (kbd "C-c C-c") #'my-go-run)
            ;; 设置缩进
            (setq tab-width 2)
            (setq standard-indent 2)
            (setq-default go-ts-mode-indent-offset custom-tab-width)
            (setq indent-tabs-mode nil)
            (symbol-overlay-mode -1)
            ;; 绑定 M-. 到 xref-find-definitions
            (local-set-key (kbd "M-.") #'xref-find-definitions)
            ))

(defun eglot-format-buffer-before-save ()
  "Format buffer before saving when using eglot."
  (add-hook 'before-save-hook #'eglot-format-buffer -10 t))

(add-hook 'go-ts-mode-hook #'eglot-format-buffer-before-save)

(use-package dap-mode
  :ensure t
  :config
  (require 'dap-ui)
  (dap-ui-mode 1)
  (require 'dap-dlv-go)
  (add-hook 'go-ts-mode-hook #'dap-mode)
  (add-hook 'go-ts-mode-hook #'dap-ui-mode)

  ;; === Java 配置 ===
  ;; 避免 telemetry 消息引发死锁
  ;;(dap-register-debug-provider "telemetry" (lambda (_) nil))
  ;;(require 'dap-java)
  ;;(add-hook 'java-mode-hook #'dap-mode)
  ;;(add-hook 'java-mode-hook #'dap-ui-mode)
  ;;(add-hook 'dap-stopped-hook
  ;;          (lambda (_) (call-interactively #'dap-hydra)))
  (dap-register-debug-template "Go :: Run main.go"
                               (list :type "go"
                                     :request "launch"
                                     :name "Go :: Run main.go"
                                     :mode "auto"
                                     :program "${workspaceFolder}/biz_server"
                                     :cwd "${workspaceFolder}/biz_server"
                                     ;;:program "/home/ronghusong/06_code/go/hero_story.go_server/biz_server"
                                     ;;:cwd "/home/ronghusong/06_code/go/hero_story.go_server/biz_server"
                                     :buildFlags ""
                                     :args []
                                     :env nil
                                     :envFile nil)))
;;(use-package lsp-java
;;  :ensure t
;;  :hook (java-mode . lsp)
;;  :config
;;  (setq lsp-java-server-install-dir "/home/ronghusong/.emacs.d/share/eclipse.jdt.ls")
;;  (setq lsp-java-java-path "/usr/lib/jvm/java-21-openjdk-amd64/bin/java")
;;  (setq lsp-java-completion-enabled t)
;;  (setq lsp-java-content-provider-preferred "fernflower")
;;  (setq lsp-java-import-gradle-enabled t)
;;  (setq lsp-java-save-action-organize-imports t)
;;  (setq lsp-java-configuration-maven-user-settings "/home/ronghusong/software/install_package/apache-maven-3.9.7/conf/settings.xml")
;;  (setq lsp-java-autobuild-enabled t)
;;  (setq lsp-java-errors-incomplete-classpath-severity "ignore")
;;  (setq lsp-java-import-gradle-offline-enabled nil)
;;  ;; 启用注解处理器
;;  (setq lsp-java-annotation-process-enabled t)
;;  (setq lsp-java-vmargs
;;        '("-javaagent:/home/ronghusong/.m2/repository/org/projectlombok/lombok/1.18.34/lombok-1.18.34.jar"))
;;  (add-hook 'java-mode-hook #'lsp))

;;(setq dap-go-debug-program '("/home/ronghusong/software/go/bin/dlv")
;; (require 'go-mode)

;; (add-hook 'go-mode-hook 'eglot-ensure)

;; (defun my-go-run ()
;;   "Run all Go files in the current directory."
;;   (interactive)
;;   (save-buffer) ;; 自动保存当前文件
;;   (let ((dir (file-name-directory buffer-file-name)))
;;     (setq-local compile-command (format "go run %s" (shell-quote-argument dir)))
;;     (call-interactively #'compile)))

;; (add-hook 'go-mode-hook
;;           (lambda ()
;;             ;;(add-hook 'before-save-hook 'gofmt-before-save)
;;             (add-hook 'before-save-hook
;;                       (lambda ()
;;                         (call-interactively 'eglot-code-action-organize-imports))
;;                       nil t)
;;             (local-set-key (kbd "C-c C-c") #'my-go-run)
;;             (setq-default)
;;             (setq tab-width 2)
;;             (setq standard-indent 2)
;;             (setq indent-tabs-mode nil)))

;; (defun eglot-format-buffer-before-save ()
;;   (add-hook 'before-save-hook #'eglot-format-buffer -10 t))

;; (add-hook 'go-mode-hook #'eglot-format-buffer-before-save)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 82 JavaScript
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq js-indent-level tab-width)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 83 BASH
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq sh-basic-offset tab-width
      sh-indentation tab-width)
(use-package term
  :commands (ansi-term)
  :bind ("M-s t" . (lambda () (interactive) (ansi-term "/home/ronghusong/software/tools/terminal/tmux-bash.sh"))))

;; snippets, please
(add-hook 'sh-mode-hook 'yas-minor-mode)

;; on the fly syntax checking
(add-hook 'sh-mode-hook 'flycheck-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 84 XML
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq nxml-slash-auto-complete-flag t)
(setq nxml-child-indent 4)
(setq nxml-attribute-indent 4)

(defun tkj/tidy-up-xml()
  "Pretty print XML that's all on one line."
  (interactive)
  (goto-char 0)
  (replace-string "><" ">
<")
  (indent-region (point-min) (point-max)))
(global-set-key (kbd "C-x t") 'tkj/tidy-up-xml)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 83 YAML
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package yaml-mode
  :ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 85 Org
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun tkj/org-file-of-the-day()
  (interactive)
  (let ((daily-name (format-time-string "%Y/%Y-%m-%d")))
    (find-file
     (expand-file-name
      (concat "~/Document/scribbles/" daily-name ".org")))))

(defun tkj/org-update-agenda-files()
  (interactive)
  (setq org-agenda-files
        (list
         (concat "~/Document/scribbles/" (format-time-string "%Y") "/outlook.org")
         (concat "~/Document/scribbles/" (format-time-string "%Y") "/home.org")
         (concat "~/Document/scribbles/" (format-time-string "%Y") "/" (format-time-string "%Y-%m-%d") ".org")
         )))

(defun tkj/copy-jira-link()
  "Creates a Jira link out of the issue key at point. The function
then inserts it into your kill ring so you can paste/yank it
where you need it."
  (interactive)
  (let ((issue (thing-at-point 'filename 'no-properties)))
    (kill-new (concat "https://jira.stibodx.com/browse/" issue))))

;; Open Jira issue references in the browser
(setq bug-reference-bug-regexp "\\b\\(\\([A-Za-z][A-Za-z0-9]\\{1,10\\}-[0-9]+\\)\\)"
      bug-reference-url-format "https://jira.stibodx.com/browse/%s")
(add-hook 'org-mode-hook 'bug-reference-mode)

;; Pretty Org tables
;; (progn
;;   (add-to-list 'load-path "/usr/local/src/org-pretty-table")
;;   (require 'org-pretty-table)
;;   (add-hook 'org-mode-hook (lambda () (org-pretty-table-mode))))

(use-package org
  :init
  (setq org-clock-mode-line-total 'today
        org-fontify-quote-and-verse-blocks t
        org-indent-mode t
        org-return-follows-link t
        org-startup-folded 'content
        org-todo-keywords '((sequence "🆕(t)" "▶️(s)" "⏳(w)" "🔎(p)" "|" "✅(d)" "CANC(c)" "👨(g)"))
        )

  :config
  (add-hook 'org-mode-hook 'org-indent-mode)
  (add-hook 'org-mode-hook 'flyspell-mode)

  :bind
  (("\C-ca" . org-agenda)
   ("\C-ct" . org-capture)
   ("\C-cl" . tkj/org-file-of-the-day))
  ("\C-cu" . tkj/org-update-agenda-files))

(use-package org-bullets
  :ensure t
  :init
  ;;(setq org-bullets-bullet-list '("❯" "❯❯" "❯❯❯" "❯❯❯❯" "❯❯❯❯❯"))
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●"))
  :config
  (add-hook 'org-mode-hook 'org-bullets-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 86 HTML and CSS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq css-indent-offset tab-width)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 87 Perl
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(setq perl-indent-level tab-width)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 88 Python
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'auto-mode-alist '("Pipfile" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.env\\'" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.kv\\'" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.ts\\'" . js-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 90 AI
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun tkj/load-ai()
  (interactive)
  (add-to-list 'load-path "~/.emacs.d/elpa-29.4/copilot-20250223.139/copilot.el")
  (use-package editorconfig)
  (require 'copilot)
  (define-key copilot-completion-map (kbd "<tab>") 'copilot-accept-completion))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 91 envrc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package envrc
  :ensure t
  :init
  (envrc-global-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 92 eaf
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'bbyac)
(bbyac-global-mode 1)

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "google-chrome")
(add-to-list 'load-path "/home/ronghusong/.emacs.d/site-lisp/emacs-application-framework")
(require 'eaf)
(require 'eaf-browser)
(require 'eaf-pdf-viewer)
(require 'eaf-markdown-previewer)
(require 'eaf-markmap)
(require 'eaf-camera)
(require 'eaf-video-player)
(require 'eaf-js-video-player)
(require 'eaf-image-viewer)
(require 'eaf-mindmap)

(defun adviser-find-file (orig-fn file &rest args)
  (let ((fn (if (commandp 'eaf-open) 'eaf-open orig-fn)))
    (pcase (file-name-extension file)
      ("pdf"  (apply fn file nil))
      ("epub" (apply fn file nil))
      (_      (apply orig-fn file args)))))
(advice-add #'find-file :around #'adviser-find-file)

;; open default browser in emacs
(setq browse-url-browser-function 'eaf-open-browser)
(defalias 'browse-web #'eaf-open-browser)
;; eaf-webengine-pc-user-agent
(setq eaf-user-agent "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36")
;;(setq eaf-user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.6834.83 Safari/537.36")

(setq eaf-browser-default-search-engine "google")
(setq eaf-browser-blank-page-url "http://cn.bing.com")

;; continue where you left off
(setq eaf-browser-continue-where-left-off t)
;; prevent ads
(setq eaf-browser-enable-adblocker t)
;; light-mode
(setq eaf-browser-dark-mode nil)

(defun my-open-url-in-eaf (url)
  "Use EAF Open Special URL，Default bing.com。"
  (interactive "sURL(eg: bing.com): ")
  (if (string= url "")
      (setq url "https://cn.bing.com"))
  (eaf-open-browser url))
(global-set-key (kbd "C-c o") 'my-open-url-in-eaf)

;; proxy settings
(setq eaf-proxy-type "http")
(setq eaf-proxy-host "127.0.0.1")
(setq eaf-proxy-port "18080")

;;eaf markdown dark mode exists an issue, show unclear
(setq eaf-markdown-dark-mode nil)
;; eaf-pdf-view
(setq eaf-pdf-dark-mode nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 93 navicate
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; expand region
(require 'expand-region)
(global-set-key (kbd "M-s s") 'er/expand-region)

;; Install and configure smartparens
(use-package smartparens
  :ensure t
  :hook (
         (prog-mode . smartparens-mode)
         (c++-mode . smartparens-mode)
         (c-mode . smartparens-strict-mode)
         )
  :custom
  (sp-escape-quotes-after-insert nil)
  :config
  (require 'smartparens-config)
  (smartparens-global-mode t))

;; fold region
(require 'vimish-fold)
(global-set-key (kbd "M-+") #'vimish-fold)
(global-set-key (kbd "M-_") #'vimish-fold-delete)

;; scroll by line
;;(global-set-key (kbd "M-k") 'scroll-down-line)
;;(global-set-key (kbd "M-j") 'scroll-up-line)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 95 evil
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)
  (define-key evil-insert-state-map (kbd "C-d") 'delete-char)
  (define-key evil-normal-state-map (kbd "C-i") 'evil-jump-forward)
  (define-key evil-normal-state-map (kbd "M-j") 'avy-goto-char)
  (define-key evil-normal-state-map (kbd "M-w") 'avy-goto-word-1)
  (define-key evil-insert-state-map (kbd "M-j") 'avy-goto-char)
  (define-key evil-insert-state-map (kbd "M-w") 'avy-goto-word-1)
  ;;(define-key evil-normal-state-map (kbd "M-.") 'xref-find-definitions)
  ;;(define-key evil-motion-state-map (kbd "M-.") 'xref-find-definitions)
  ;;(define-key evil-normal-state-map (kbd "M-.") 'eglot-find-implementation)
  ;;(define-key evil-motion-state-map (kbd "M-.") 'eglot-find-implementation)
  (define-key evil-normal-state-map (kbd "M-.") 'my-find-implementation-smart)
  (define-key evil-motion-state-map (kbd "M-.") 'my-find-implementation-smart)
  (define-key evil-normal-state-map (kbd "M-?") 'xref-find-references)
  (define-key evil-motion-state-map (kbd "M-?") 'xref-find-references)
  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(defun my-find-implementation-smart ()
  (interactive)
  (cond
    ((eq major-mode 'go-ts-mode)
     (call-interactively 'xref-find-definitions))
    ((or (eq major-mode 'java-mode)
         (eq major-mode 'eglot-java-mode)) ; 如果你使用 JDEE
     (call-interactively 'eglot-find-implementation)) ; 或者你可能需要其他 Java 相关的跳转函数
    (t
      (message "当前模式不支持跳转到实现"))))

;; Enable general.el
(require 'general)
(general-evil-setup)

;; now usable `jj` is possible!
(general-imap "j"
  (general-key-dispatch 'self-insert-command
    :timeout 0.25
    "j" 'evil-normal-state
    "c" 'avy-goto-char
    "w" 'avy-goto-word-1
    "l" 'avy-goto-line))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; evil comment
(use-package evil-nerd-commenter
  :bind ("M-/" . evilnc-comment-or-uncomment-lines))
;; solved evil input slow
(setq input-method-function nil)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 96 connect postgraduate
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(unless (package-installed-p 'pg)
  (package-vc-install "https://github.com/emarsden/pg-el/" nil nil 'pg))
(unless (package-installed-p 'pgmacs)
  (package-vc-install "https://github.com/emarsden/pgmacs/" nil nil 'pgmacs))
(require 'pgmacs)
;; sql-connection-list
(defvar sql-connection-alist nil)
(defmacro sql-specify-connections (&rest connections)
  "Set the sql-connection-alist from CONNECTIONS.
  Generates respective interactive functions to establish each
  connection."
  `(progn
     ,@(mapcar (lambda (conn)
                 `(add-to-list 'sql-connection-alist ',conn))
               connections)
     ,@(mapcar (lambda (conn)
                 (let* ((varname (car conn))
                        (fn-name (intern (format "sql-connect-to-%s" varname)))
                        (buf-name (format "*%s*" varname)))
                   `(defun ,fn-name ,'()
                      (interactive)
                      (sql-connect ',varname ,buf-name))))
               connections)))
(when (file-exists-p "~/.emacs.d/work.el")
  (load-file "~/.emacs.d/work.el"))

;; rime input
(add-to-list 'load-path "~/.emacs.d/elpa/emacs-rime")
(require 'rime)

(setq rime-user-data-dir "~/.config/fcitx/rime")

(setq rime-posframe-properties
      (list :background-color "#333333"
            :foreground-color "#dcdccc"
            :font "WenQuanYi Micro Hei Mono-14"
            :internal-border-width 10))
(setq default-input-method "rime"
      rime-show-candidate 'posframe)

;; allow emacsclient connect
(server-start)

;; org-babel-load-languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((sql . t)
   (emacs-lisp . t)
   (python . t)
   (java . t)
   (mermaid . t)))

;; paste image from clipboard
(defvar mfz/image-dir "Images")

(defun mfz/ensure-directory (path)
  "create directory if it does not exist and user agrees"
  (when (and (not (file-exists-p path))
             (y-or-n-p (format "Directory %s does not exist. Create it?" path)))
    (make-directory path :parents)))

(defun mfz/paste-image-clipboard ()
  "Paste screenshot from clipboard"
  (interactive)
  (mfz/ensure-directory (file-name-as-directory mfz/image-dir))
  (let ((image-path (concat (file-name-as-directory mfz/image-dir)
                            (file-name-base (buffer-name))
                            (format-time-string "_%Y_%m_%d__%H_%M_%S")
                            ".png")))
    (shell-command-to-string (format "xclip -selection clipboard -t image/png -o > %s" image-path))
    (insert "[[file:" image-path "]]\n")
    (org-display-inline-images)))

(setq org-image-actual-width nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 96 Mermaid
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load Org Babel for Mermaid
(use-package ob-mermaid
  :ensure t
  :config
  (setq ob-mermaid-cli-path "/home/ronghusong/.nvm/versions/node/v22.12.0/bin/mmdc")) ;; Replace with the actual path to mmdc
;; Optional: Customize Org Babel results display
(setq org-confirm-babel-evaluate nil) ;; Don't ask for confirmation when evaluating code
(setq org-babel-default-header-args:mermaid
      '((:results . "file") (:exports . "results")))

(with-eval-after-load 'org
  ;; This is needed as of Org 9.2
  (require 'org-tempo)
  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("sj" . "src java"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("py" . "src python"))
  (add-to-list 'org-structure-template-alist '("gp" . "src dot :file output.pdf :cmdline -Kdot -Tpdf\n"))
  )
