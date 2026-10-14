# Stalker

Rails engine that exposes, as JSON, the versions of everything an application runs on: OS, database, Redis, search servers, Ruby, gems and Node packages. It is meant to be polled by a monitoring server to track outdated dependencies across a fleet of applications.

## Installation

Add the gem to your application's Gemfile:

```ruby
gem 'stalker', git: 'https://github.com/opsone/stalker-rails'
```

Then run:

```bash
bundle
rails generate stalker:install
```

The generator creates `config/initializers/stalker.rb`.

Mount the engine in `config/routes.rb`:

```ruby
mount Stalker::Engine => '/stalker'
```

Set the access token in the application credentials (`rails credentials:edit`):

```yaml
stalker_token: myMagicSecurityToken
```

## Usage

```bash
curl -H 'Authorization: Bearer myMagicSecurityToken' https://example.com/stalker/dependencies
```

The token can also be passed as a query parameter (`/stalker/dependencies?token=...`), but the header keeps it out of access logs.

Response (cached for 5 minutes):

```json
[
  { "name": "debian", "dep_type": "os", "version": "12.8" },
  { "name": "postgresql", "dep_type": "db_server", "version": "16.4" },
  { "name": "redis", "dep_type": "db_server", "version": "7.2.4" },
  { "name": "ruby", "dep_type": "ruby", "version": "3.3.6" },
  { "name": "bundler", "dep_type": "bundler", "version": "2.5.22" },
  { "name": "rails", "dep_type": "ruby_gem", "version": "7.2.2" },
  { "name": "node", "dep_type": "node", "version": "22.11.0" },
  { "name": "yarn", "dep_type": "yarn", "version": "1.22.22" },
  { "name": "@hotwired/turbo", "dep_type": "node_module", "version": "8.0.12" }
]
```

### Authentication

| `access_token` | Behaviour |
|---|---|
| A string | Requests must provide this token |
| `nil` or blank (e.g. missing credential) | Every request is denied (401) |
| `false` | Authentication is disabled |

## What is detected

| Probe | Detected when | Source |
|---|---|---|
| OS | `/etc/os-release` exists | `/etc/debian_version` on Debian, `/etc/os-release` otherwise |
| PostgreSQL, MySQL/MariaDB, SQLite | Matching Active Record adapter (`postgresql`, `mysql2`/`trilogy`, `sqlite3`) | SQL query on the primary database |
| Redis | `redis_url` is set | `redis-client` or `redis` gem when loaded, `redis-cli` otherwise |
| Elasticsearch | `elasticsearch_url` is set and the server answers | HTTP API |
| Meilisearch | `meilisearch_url` is set and the server answers | HTTP API |
| Ruby, Bundler, gems | Always | Gems listed in the Gemfile (not their dependencies) |
| npm | `package-lock.json` exists | `node -v`, `npm -v`, `npm list` |
| Yarn (v1) | `yarn.lock` exists | `node -v`, `yarn -v`, `yarn list` |
| Bun | `bun.lock` or `bun.lockb` exists | `bun -v`, `bun pm ls` |

Node packages are limited to those declared in `package.json`. Files are looked up in `Rails.root`, external commands time out after 5 seconds and network calls after 1 second. A failing probe is skipped and logged with a `[Stalker]` prefix, so it never breaks the whole response.

## Configuration

All options are set in `config/initializers/stalker.rb`:

```ruby
Stalker.configure do |config|
  config.access_token = Rails.application.credentials.stalker_token
end
```

| Option | Default | Description |
|---|---|---|
| `access_token` | `nil` | See [Authentication](#authentication) |
| `redis_url` | `ENV['REDIS_URL']` | Redis server to query |
| `elasticsearch_url` | `ENV['ELASTICSEARCH_URL']` | `https://` enables TLS, credentials can be given in the URL (`https://user:password@host:9200`) |
| `elasticsearch_ca_file` | `ENV['ELASTICSEARCH_CA_FILE']` | CA of a self-signed Elasticsearch certificate |
| `meilisearch_url` | `ENV['MEILISEARCH_URL']` | Meilisearch server to query |
| `meilisearch_api_key` | `ENV['MEILISEARCH_API_KEY']` | Only needed when Meilisearch runs with a master key |
| `node_bin`, `npm_bin`, `yarn_bin`, `bun_bin`, `redis_bin` | `node`, `npm`, `yarn`, `bun`, `redis-cli` | Executables, resolved from the `PATH` of the application process |

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
