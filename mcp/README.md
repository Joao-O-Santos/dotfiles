# Shared MCP configuration

`mcp.json` is the secret-free global configuration consumed by Pi Sych's scoped
remote-research workers through `pi-mcp-adapter`. It contains only Context7,
OpenAlex, and Scholar Gateway. The adapter uses one lazy proxy tool and does
not register individual MCP tools in every session.

API variables are read only from ignored `~/.config/pi/secrets.env` by the
shell `pi` wrapper. Scholar Gateway uses the adapter's explicit OAuth flow;
its OAuth state is stored in the private worker runtime profile rather than in
this configuration or the secret environment file. Do not add credentials,
host-specific imports, or extra servers here: remote-research workers reject
any configuration other than the three approved servers.
