# sidekiq_web

Simple repo to deploy the WebUI for [sidekiq.cr](https://github.com/mperham/sidekiq.cr).

Works great on [dokku](https://github.com/dokku/dokku) (and probably Heroku, haven't tried).

## Usage

### Local

```bash
cp .env.example .env # and edit
shards
crystal src/sidekiq_web.cr
# or if you have Foreman installed
foreman start -f Procfile.dev
```

### Dokku

First create your app on the server
```bash
dokku apps:create sidekiq-web
dokku redis:link [your-redis] sidekiq-web
dokku config:set njus-sidekiq-web KEMAL_ENV=production \
  REDIS_PROVIDER=REDIS_URL \
  SECRET_TOKEN=sometoken \
  SIDEKIQ_USER=admin \
  SIDEKIQ_PASSWORD=CHANGEME
# ... add Let's Encrypt, domains and whatnot
```

Then deploy...

```bash
git remote add dokku dokku@yourserver:sidekiq-web
git push dokku master
```

and the `.buildpacks` and `Procfile` will take care of the rest!

## Contributing

1. Fork it (<https://github.com/joenas/sidekiq_web/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [joenas](https://github.com/joenas) joenas - creator, maintainer
