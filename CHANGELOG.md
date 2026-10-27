# Changelog

## Unreleased

- **OS: report the Debian point release again** (`/etc/debian_version`), e.g. `13.4` instead of `13`: reverts 0.10.1

## 0.10.1

- **OS: report the major release** (`VERSION_ID` from `/etc/os-release`), e.g. `13` instead of `13.4` on Debian

## 0.10.0

- Accept the token in an `X-Stalker-Token` header, for sites behind HTTP basic auth
- Depend on `railties`, `actionpack`, `activerecord` and `activesupport` instead of the `rails` meta-gem

## 0.9.0

- Accept the token in an `Authorization: Bearer` header (`?token=` still works)
- `client_ip_header` has had no effect since 0.3.0; it is still accepted so that existing initializers keep booting
- Complete the README and the gemspec description

## 0.8.1

- npm: parse the ASCII tree printed when the locale is not UTF-8 (e.g. under systemd), dependencies were missing in that case
- Node packages: keep prerelease versions (`8.0.0-beta.1`)
- Bun: detect `bun.lock`, the default lockfile since Bun 1.2
- Databases: read the adapter from the configuration, support `trilogy`
- **MariaDB is now reported as `mariadb`** (was `mysql`), versions without distribution suffix (`10.11.6` instead of `10.11.6-MariaDB-0+deb12u1`)

## 0.8.0

- External commands run without a shell, from `Rails.root`, with a 5 second timeout
- Redis: use the `redis-client` or `redis` gem when loaded, `redis-cli` as a fallback (credentials passed through `REDISCLI_AUTH`)
- New `meilisearch_api_key` option
- Elasticsearch over TLS: `https://` URLs, credentials in the URL, new `elasticsearch_ca_file` option

## 0.7.1

- Replace the `inifile` dependency with a built-in `/etc/os-release` parser; `VERSION_ID` is always a string

## 0.7.0

- **Requests are denied when `access_token` is `nil` or blank** (e.g. missing credential); set it to `false` to disable authentication
- No crash when the initializer is missing
- 1 second timeouts on Elasticsearch and Meilisearch calls
- A failing probe is logged and skipped instead of breaking the whole response
- Require Ruby >= 3.3 and Rails >= 7.0

Earlier versions: see the git history.
