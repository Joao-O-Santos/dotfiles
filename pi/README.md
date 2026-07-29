# Pi Sych private overlay

This tracked, secret-free directory configures the local Pi supervisor. It loads Pi Sych from npm (`npm:pi-sych`), stores the user-ranked worker model catalog and private skills, and keeps credentials outside tracked files. Pi Sych provides its own Plannotator integration; do not configure Plannotator separately.

Credentials, model stores, sessions, worker state, installed packages, and runtime artifacts remain ignored or outside Git. Update the package with `pi update npm:pi-sych`; the public package does not depend on this overlay.
