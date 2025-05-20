# Stalker
Short description and motivation.

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'stalker', git: 'https://github.com/opsone/stalker-gem'
```

And then execute:
```bash
$ bundle
```

After that, execute:
```bash
$ rails generate stalker:install
```

Add the route to the module in the file `config/routes.rb`:
```ruby
mount Stalker::Engine => "/stalker"
```

To finish, add the security token in your credentials file:
```bash
$ rails credentials:show 
EDITOR='code --wait' rails credentials:edit
```

Set your token as the value of `stalker_token`
```
stalker_token: myMagicSecurityToken
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
