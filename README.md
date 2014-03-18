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


