# lita-pugbomb

**lita-pugbomb** is a handler for [Lita](https://github.com/jimmycuadra/lita) that displays an arbitrary number of images of pugs, via [this single-serving Heroku app](http://pugme.herokuapp.com).

Sometimes you'd just rather see an array of pugs than whatever else is currently in chat.

## Installation

Add `lita-pugbomb` to your Lita instance's Gemfile:
``` ruby
gem "lita-pugbomb"
```

### Usage
`Lita: pug me` - display a single pug.

`Lita: pug bomb` - display five pugs. Alternate syntax: `Lita: pugbomb`

`Lita: pug bomb n` - display n pugs, where n is an integer.

`Lita: how many pugs are there` - you can figure it out

### Optional `MAX_PUGS` environment variable

You can optionally set a `MAX_PUGS` environment variable. This variable will limitate how many pugs the command 'pug bomb' will send.

For example:

- With `MAX_PUGS='3'`
  - `pug bomb` will respond with 3 pugs
  - `pug bomb 2` will respond with 2 pugs
  - `pug bomb 10` will respond wih 3 pugs


- Without `MAX_PUGS` value
  - `pug bomb` will respond with 5 pugs
  - `pug bomb 2` will respond with 2 pugs
  - `pug bomb 10` will respond wih 10 pugs
