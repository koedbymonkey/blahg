Blahg [![build status][ci-image]][ci] [![code climate][cc-image]][cc]
=====================================================================

A simple blog.

## Development

```
$ git clone git@github.com/koedbymonkey/blahg.git
$ cd blahg
$ bundle
$ cp {sample,}.env                  # edit this file
$ cp Procfile.local{.sample,}       # edit this file
$ cp config/database.yml{.sample,}  # edit this file
$ foreman start -f Procfile.local
$ bundle exec rake db:setup
$ bundle exec rake db:test:prepare
$ bundle exec rspec spec
```

Environment variables are stored in ./.env

<!-- links -->
[cc]: https://codeclimate.com/github/koedbymonkey/blahg "code climate"
[ci]: http://travis-ci.org/koedbymonkey/blahg "build status"

<!-- images -->
[cc-image]: https://codeclimate.com/github/koedbymonkey/blahg.png
[ci-image]: https://secure.travis-ci.org/koedbymonkey/blahg.png
