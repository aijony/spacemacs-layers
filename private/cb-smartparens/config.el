;;; Enable smartparens

(smartparens-global-mode)
(show-smartparens-global-mode +1)

(custom-set-variables
 '(sp-autoinsert-if-followed-by-word t)
 '(sp-navigate-close-if-unbalanced t)
 '(sp-message-width nil))

(add-hook 'prog-mode-hook 'smartparens-strict-mode)
(add-hook 'markdown-mode-hook 'smartparens-strict-mode)
(add-hook 'ielm-mode-hook 'smartparens-strict-mode)

(add-hook 'minibuffer-setup-hook 'sp/maybe-enable-smartparens t)
(add-hook 'minibuffer-inactive-mode-hook 'sp/maybe-enable-smartparens t)

(add-hook 'smartparens-mode-hook 'sp/hacky-set-sp-bindings t)
(add-hook 'smartparens-strict-mode-hook 'sp/hacky-set-sp-bindings t)

;;; Remove apostrophe pair for some modes

(defvar sp/prompt-modes
  '(comint-mode
    inf-ruby-mode
    inferior-python-mode
    ielm-mode
    erc-mode
    utop-mode
    slime-repl-mode
    inferior-scheme-mode
    inferior-haskell-mode
    sclang-post-buffer-mode))

(sp-with-modes sp/prompt-modes
  (sp-local-pair "'" "'" :actions '(:rem insert)))

(sp-local-pair 'org-mode                 "'" "'" :actions '(:rem insert))
(sp-local-pair 'text-mode                "'" "'" :actions '(:rem insert))
(sp-local-pair 'minibuffer-inactive-mode "'" "'" :actions '(:rem insert))

;;; Org

(add-hook 'org-agenda-mode-hook (lambda () (smartparens-mode -1)))

;;; Rust

(sp-with-modes 'rust-mode
  (sp-local-pair "{" "}" :post-handlers '(:add sp/internal-and-external-padding))
  (sp-local-pair "'" "'" :actions '(:rem insert))
  )

;;; Haskell

(sp-with-modes '(haskell-mode inf-haskell-mode haskell-c-mode)
  (sp-local-pair "{" "}" :post-handlers '(:add sp/internal-and-external-padding))
  (sp-local-pair "(" ")" :post-handlers '(:add sp/external-padding))
  (sp-local-pair "[" "]" :post-handlers '(:add sp/external-and-external-padding))
  (sp-local-pair "`" "`" :post-handlers '(:add sp/external-padding))
  (sp-local-pair "'" "'" :actions '(:rem insert))
  )

;;; OCaml

(sp-with-modes '(tuareg-mode utop-mode)
  (sp-local-pair "\"" "\"" :post-handlers '(:add sp/ml-just-one-space))
  (sp-local-pair "{" "}"   :post-handlers '(:add sp/ml-just-one-space))
  (sp-local-pair "[" "]"   :post-handlers '(:add sp/ml-just-one-space))
  (sp-local-pair "(" ")"   :post-handlers '(:add sp/ml-just-one-space))
  (sp-local-pair "[|" "|]" :post-handlers '(:add sp/ml-just-one-space))
  (sp-local-pair "{<" ">}" :post-handlers '(:add sp/ml-just-one-space))
  (sp-local-pair "'" "'"   :actions '(:rem insert))
  (sp-local-pair "`" nil   :actions nil)
  )

;;; Coq

(sp-with-modes 'coq-mode
  (sp-local-pair "\"" "\"" :post-handlers '(:add sp/external-padding))
  (sp-local-pair "{" "}"   :post-handlers '(:add sp/external-padding))
  (sp-local-pair "[" "]"   :post-handlers '(:add sp/external-padding))
  (sp-local-pair "(" ")"   :post-handlers '(:add sp/external-padding))
  (sp-local-pair "'" "'"   :actions '(:rem insert))
  )

;;; F#

(sp-with-modes 'fsharp-mode
  (sp-local-pair "\"" "\"" :post-handlers '(:add sp/ml-just-one-space))
  (sp-local-pair "{" "}"   :post-handlers '(:add sp/ml-just-one-space))
  (sp-local-pair "[" "]"   :post-handlers '(:add sp/ml-just-one-space))
  (sp-local-pair "(" ")"   :post-handlers '(:add sp/ml-just-one-space))
  (sp-local-pair "[|" "|]" :post-handlers '(:add sp/ml-just-one-space))
  (sp-local-pair "[<" ">]" :post-handlers '(:add sp/ml-just-one-space))
  (sp-local-pair "'" "'"   :actions '(:rem insert))
  (sp-local-pair "`" nil   :actions nil)
  )

;;; Idris

(sp-with-modes '(idris-mode idris-repl-mode)
  (sp-local-pair "\"" "\"" :post-handlers '(:add sp/external-padding))
  (sp-local-pair "{" "}"   :post-handlers '(:add sp/internal-and-external-padding))
  (sp-local-pair "[" "]"   :post-handlers '(:add sp/internal-and-external-padding))
  (sp-local-pair "(" ")"   :post-handlers '(:add sp/external-padding))
  (sp-local-pair "`" "`"   :post-handlers '(:add sp/external-padding))
  (sp-local-pair "[|" "|]" :post-handlers '(:add sp/external-padding))
  (sp-local-pair "'" nil   :actions nil)
  (sp-local-pair "'" "'"   :actions '(:rem insert))
  )

;;; Lisp modes

(defvar sp/lisp-modes
  `(cider-repl-mode
    clojure-mode
    clojurescript-mode
    common-lisp-mode
    emacs-lisp-mode
    geiser-repl-mode
    inferior-emacs-lisp-mode
    inferior-lisp-mode
    inferior-scheme-mode
    lisp-mode
    repl-mode
    scheme-mode
    slime-mode
    slime-repl-mode))


(sp-with-modes sp/lisp-modes
  (sp-local-pair "\"" "\"" :post-handlers '(:add sp/lisp-just-one-space))
  (sp-local-pair "{" "}"   :post-handlers '(:add sp/lisp-just-one-space))
  (sp-local-pair "[" "]"   :post-handlers '(:add sp/lisp-just-one-space))
  (sp-local-pair "(" ")"   :post-handlers '(:add sp/lisp-just-one-space))
  (sp-local-pair "'" nil   :actions nil)
  )

;; Extend `sp-navigate-reindent-after-up' to all lisps.
(let ((ls (assoc 'interactive sp-navigate-reindent-after-up)))
  (setcdr ls (-uniq (-concat (cdr ls) sp/lisp-modes))))

;;; Markdown

(sp-with-modes 'markdown-mode
  (sp-local-pair "```" "```"))

;;; Python

(sp-with-modes '(python-mode inferior-python-mode)
  (sp-local-pair "{" "}" :post-handlers '(:add sp/external-padding)))

;;; Ruby

(require 'smartparens-ruby)

(after 'ruby-mode
  (modify-syntax-entry ?@ "w" ruby-mode-syntax-table)
  (modify-syntax-entry ?_ "w" ruby-mode-syntax-table)
  (modify-syntax-entry ?! "w" ruby-mode-syntax-table)
  (modify-syntax-entry ?? "w" ruby-mode-syntax-table))

(sp-with-modes '(ruby-mode inf-ruby-mode)
  (sp-local-pair "{" "}" :post-handlers '(:add sp/internal-and-external-padding))
  (sp-local-pair "[" "]" :pre-handlers '(sp-ruby-pre-handler))

  (sp-local-pair "%q{" "}" :when '(sp-in-code-p))
  (sp-local-pair "%Q{" "}" :when '(sp-in-code-p))
  (sp-local-pair "%w{" "}" :when '(sp-in-code-p))
  (sp-local-pair "%W{" "}" :when '(sp-in-code-p))
  (sp-local-pair  "%(" ")" :when '(sp-in-code-p))
  (sp-local-pair "%x(" ")" :when '(sp-in-code-p))
  (sp-local-pair  "#{" "}" :when '(sp-in-string-p))

  (sp-local-pair "|" "|"
                 :when '(sp/ruby-should-insert-pipe-close)
                 :unless '(sp-in-string-p)
                 :pre-handlers '(sp/ruby-sp-hook-space-before)
                 :post-handlers '(sp/ruby-sp-hook-space-after))

  (sp-local-pair "case" "end"
                 :when '(("SPC" "RET" "<evil-ret>"))
                 :unless '(sp-ruby-in-string-or-word-p)
                 :actions '(insert)
                 :pre-handlers '(sp-ruby-pre-handler)
                 :post-handlers '(sp-ruby-block-post-handler)))

;;; Swift

(sp-with-modes '(swift-mode)
  (sp-local-pair "{" "}" :post-handlers '(:add sp/internal-and-external-padding))
  (sp-local-pair "'" "'"   :actions '(:rem insert)))

;;; C

(sp-with-modes '(c-mode cc-mode c++-mode)
  (sp-local-pair "{" "}" :post-handlers '(:add sp/c-format-after-brace
                                               sp/external-and-external-padding))
  (sp-local-pair "(" ")" :post-handlers '(:add sp/c-format-after-paren)))