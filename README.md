# Blacksmith

Blacksmith uses FontForge to build fonts from SVG graphics.

## Installation

Add this line to your application's Gemfile:

    gem 'blacksmith'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install blacksmith


## Usage

Generating fonts with Blacksmith is easy. After installing the gem create a new project
directory:

    $ blacksmith init name

This will generate the basic directory structure and a basic Forgefile.

    name/
    name/Forgefile
    name/build/
    name/source/

Put your glyphs into the `source` directory. Use a seperate SVG file for each glyph. Afterwards add them to your font by referencing the glyph in the Forgefile:

    glyph 'star.svg', :code => 0x0061

To compile your font run `blacksmith` (without any arguments) in your projects root directory. This will generate a TTF, EOT, WOFF, and SVG version of your font as well as CSS and HTML files.

### Forgefile

There is a set of options available to customize the generation of your font:

    name         (Default: <family> <weight>)
    family       (Default: Blacksmith Font)
    weight       (Default: Regular)
    ascent       (Default: 800)
    descent      (Default: 200)
    version      (Default: 1.0)
    copyright
    baseline
    scale
    offset

When adding glyphs you may pass these additional options:

    :code                (Required)
    :name
    :left_side_bearing   (Default: 15)
    :right_side_bearing  (Default: 15)
    :scale
    :offset


## Pitfalls

### SVG Viewport

Make sure that all your SVGs contain a `viewBox` definition. Otherwise, weird
things might happen.

### OS X and ttfautohint

If you don't have `ttfautohint` installed and don't want to compile it from
source, you can grab a precompiled version from
[SourceForge](http://sourceforge.net/projects/freetype/files/ttfautohint/).


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
