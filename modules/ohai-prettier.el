
(require 'ohai-package)

(use-package prettier-js-mode
  :commands prettier-js-mode
  )

(add-hook 'js2-mode-hook 'prettier-js-mode)
(add-hook 'web-mode-hook 'prettier-js-mode)
;; (add-hook 'rjsx-mode-hook 'prettier-js-mode)

(provide 'ohai-prettier)
