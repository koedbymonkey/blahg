Dev Fu! Base [![build status][ci-image]][ci] [![code climate][cc-image]][cc]
==================================================================================

A template for creating rails 3.2 applications.

## Development

```
git clone git@github.com/devfu/base.git
cd base
bundle
# edit .env (see sample.env)
cp Procfile.local{.sample,}
foreman start -f Procfile.local
bundle exec rake db:setup
bundle exec rake db:test:prepare
rspec spec
```

Environment variables are stored in ./.env

<!-- links -->
[cc]: https://codeclimate.com/github/devfu/base "code climate"
[ci]: http://travis-ci.org/devfu/base "build status"

<!-- images -->
[cc-image]: https://codeclimate.com/github/devfu/base.png
[ci-image]: https://secure.travis-ci.org/devfu/base.png
