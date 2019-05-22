


(require 'ohai-package)

(use-package csharp-mode
  :commands csharp-mode
  )


(defun my-csharp-mode-hook ()
  (omnisharp-mode)
  ;; enable the stuff you want for C# here
  (electric-pair-mode 1)       ;; Emacs 24
  (electric-pair-local-mode 1) ;; Emacs 25
  )
(add-hook 'csharp-mode-hook 'my-csharp-mode-hook)
;; (add-hook 'csharp-mode-hook 'omnisharp-mode)

(provide 'ohai-csharp)
