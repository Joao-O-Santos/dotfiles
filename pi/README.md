# Pi Sych private overlay

This tracked, secret-free directory configures the local Pi supervisor. Pi
loads `npm:pi-sych` for its workbench, Plannotator integration, and shared
skills, plus `npm:pi-auch` for passive quota visibility. Do not configure
Plannotator separately.

`pi/pi-sych/config.json` selects the worker-agent directory and model catalog,
enables custom compaction at 100k, and uses Plannotator review.
`pi/pi-sych/models.json` keeps Luna as the routine workhorse, reserves Claude
primarily for scientific writing and review, and offers Kimi K3 for selective
independent perspective. Private skills cover the user's writing-style overlay
and signed-Git workflow.

Credentials, model stores, sessions, worker state, installed packages, and
runtime artifacts remain ignored or outside Git. Update Pi Sych with
`pi update npm:pi-sych`; the public package does not depend on this overlay.
