# pix\_scale

A command line tool for scale of pix.

## Requirements

* Ruby/GdkPixbuf2 in
  [Ruby-GNOME2](http://ruby-gnome2.sourceforge.jp/)

## Installation

    gem install pix_scale

## Usage

    % ls -l
    -rw-rw-r-- 1 you you 46643  6 27 20:00 foo.png
    -rw-rw-r-- 1 you you 31438  6 27 20:00 bar.png

    % pix_scale *.png 0.5

    % ls -l
    -rw-rw-r-- 1 you you 46643  6 27 20:00 foo.png
    -rw-rw-r-- 1 you you 18539  6 27 20:01 foo-0.5.png
    -rw-rw-r-- 1 you you 31438  6 27 20:00 bar.png
    -rw-rw-r-- 1 you you 16462  6 27 20:01 bar-0.5.png

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
