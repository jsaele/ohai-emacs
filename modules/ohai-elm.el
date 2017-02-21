
(require 'ohai-package)


(use-package elm-mode
  :commands elm-mode
  )

(with-eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-elm-setup))

(provide 'ohai-elm)
