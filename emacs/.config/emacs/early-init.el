;; This fixes an issue with MacOS 27. It may not be needed after a few months. Added 10/13/2026
(when (eq system-type 'darwin)
  (setenv "MACOSX_DEPLOYMENT_TARGET"
          (string-trim
           (shell-command-to-string "sw_vers -productVersion"))))
