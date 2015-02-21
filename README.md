# lita-pugbomb

**lita-pugbomb** is a handler for [Lita](https://github.com/jimmycuadra/lita) that displays an arbitrary number of images of pugs or doges, via [pugme.herokuapp.com](http://pugme.herokuapp.com) or [http://dogeme.rowanmanning.com](http://dogeme.rowanmanning.com/).

Sometimes you'd just rather see an array of pugs or doges than whatever else is currently in chat.

## Installation

Add `lita-pugbomb` to your Lita instance's Gemfile:
``` ruby
gem "lita-pugbomb"
```

### Usage
`Lita: (pug|doge) me` - display a single pug/doge.

`Lita: (pug|doge) bomb` - display five pugs/doges. Alternate syntax: `Lita: (pugbomb|dogebomb)`

`Lita: (pug|doge) bomb n` - display n pugs/doges, where n is an integer.

`Lita: how many (pugs|doges) are there` - you can figure it out


