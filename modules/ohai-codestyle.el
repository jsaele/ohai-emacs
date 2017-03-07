;;; -*- lexical-binding: t -*-
;;; ohai-codestyle.el --- This is where you apply your OCD.

;; Copyright (C) 2015 Bodil Stokke

;; Author: Bodil Stokke <bodil@bodil.org>

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Code:

(require 'ohai-package)

;; Tab indentation is a disease; a cancer of this planet.
;; Turn it off and let's never talk about this default again.
(set-default 'indent-tabs-mode nil)

;; The fact that we have to do this is also quite embarrassing.
(setq sentence-end-double-space nil)

;; Always indent after a newline.
(define-key global-map (kbd "RET") 'newline-and-indent)

;; Strict whitespace with ethan-wspace: highlight bad habits,
;; and automatically clean up your code when saving.
;; Use C-c c to instantly clean up your file.
;; Read more about ethan-wspace: https://github.com/glasserc/ethan-wspace
(use-package ethan-wspace
  :demand t
  :commands global-ethan-wspace-mode
  :config
  (global-ethan-wspace-mode 1)
  :bind ("C-c c" . ethan-wspace-clean-all)
  :diminish ethan-wspace-mode)

(setq mode-require-final-newline nil)
(setq require-final-newline nil)

;; Set default indentation for various languages (add your own!)
(setq-default tab-width 2)
;; Javascript
(setq-default js2-basic-offset 2)
;; JSON
(setq-default js-indent-level 2)
;; Coffeescript
(setq coffee-tab-width 2)
;; Typescript
(setq typescript-indent-level 2
      typescript-expr-indent-offset 2)
;; Python
(setq-default py-indent-offset 2)
;; XML
(setq-default nxml-child-indent 2)
;; C
(setq-default c-basic-offset 2)
;; HTML etc with web-mode
(setq-default web-mode-markup-indent-offset 2
              web-mode-css-indent-offset 2
              web-mode-code-indent-offset 2
              web-mode-style-padding 2
              web-mode-script-padding 2)

;; Set the default formatting styles for various C based modes.
;; Particularly, change the default style from GNU to Java.
;; rms, I love you, but your formatting style makes my eyes bleed.
(setq c-default-style
      '((awk-mode . "awk")
        (other . "java")))


;; Move this calc hours worked func somewhere else
(defun time-to-decimal (time) (+ (floor time) (/ (* 100 (- time (floor time))) 60)))

(defun calc-hours-worked ()
  (interactive)
  (setq line (buffer-substring-no-properties (line-beginning-position) (line-end-position)))
  (string-match "[0-9]\{2\}.[0-9]\{2\}" line)
  (setq start (string-to-number (match-string 0 line)))
  (string-match "[0-9]\{2\}.[0-9]\{2\}" line 10)
  (setq end (string-to-number (match-string 0 line)))
  (insert (format "\t-- %0.2f" (- (time-to-decimal end) (time-to-decimal start)))))

;;(global-set-key (kbd "C-c C-h") 'calc-hours-worked)


(defun my/return-time-diff-frac-hours ()
  (interactive)
  (let (begin-hh begin-mm end-hh end-mm diff)
    (save-excursion
      ;; $end-time      = (search back from pointer for previous instance of HHMM)
      ;; $begin-time    = (search for second previous instance of HHMM)
      (if (re-search-backward (concat "^\\([0-2][0-9]\\)\\([0-5][0-9]\\)"
                                      "\\(?:.*\n\\)"
                                      "\\([0-2][0-9]\\)\\([0-5][0-9]\\)"
                                      "\\(.*\n\\)"
                                      ) nil :noerror)
          (progn
            ;; $begin-hour    = $begin-time[0,1]
            ;; $begin-minute  = $begin-time[2,3]
            (setq begin-hh (string-to-number (match-string 1)))
            (setq begin-mm (string-to-number (match-string 2)))
            ;; $end-hour      = $end-time[0,1]
            ;; $end-minute    = $end-time[2,3]
            (setq end-hh (string-to-number (match-string 3)))
            (setq end-mm (string-to-number (match-string 4)))
            ;; $total-hours   = $end-hour - $begin-hour
            ;; $total-minutes = $end-minutes - $begin-minutes
            ;; return $total-hours + ($total-minutes * 0.01666666667)
            (setq diff (/ (- (+ end-mm  ; end minutes
                                (* 60 end-hh))
                             (+ begin-mm ; begin minutes
                                (* 60 begin-hh)))
                          60.0)))
        (message "Unable to find time strings on consecutive lines.")))
    (when diff
      (insert (number-to-string diff)))))

(global-set-key (kbd "C-c C-h") 'my/return-time-diff-frac-hours)

(provide 'ohai-codestyle)
