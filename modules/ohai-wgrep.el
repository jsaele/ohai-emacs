
(require 'ohai-package)

(use-package wgrep
  :commands wgrep
  )

(autoload 'wgrep-ag-setup "wgrep-ag")
(add-hook 'ag-mode-hook 'wgrep-ag-setup)

(provide 'ohai-wgrep-ag)
