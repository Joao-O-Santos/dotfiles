# Pi Sych private overlay

This tracked, secret-free directory configures the local Pi supervisor. Pi
loads Pi Sych for its workbench, Plannotator integration, and shared skills,
plus Pi Auch for passive quota visibility. Do not configure Plannotator
separately.

`pi/pi-sych/config.json` selects the worker-agent directory and model catalog,
enables custom compaction at 100k, and uses Plannotator review.
`pi/pi-sych/models.json` keeps Luna as the routine workhorse, reserves Claude
primarily for scientific writing and review, and offers Kimi K3 for selective
independent perspective. Private skills cover the user's writing-style overlay
and signed-Git workflow.

Credentials, model stores, sessions, worker state, installed packages, and
runtime artifacts remain ignored or outside Git. The configured Pi Sych and Pi
Auch packages currently use Git sources so release candidates can be tested
before publication to npm; third-party packages should remain npm sources in
`pi/settings.json`. Update the configured packages with
`pi update --extensions --no-approve`; the public packages do not depend on
this overlay. The `--no-approve` flag keeps this maintenance command scoped to
these configured packages rather than project-local package settings.
