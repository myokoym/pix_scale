# pix\_scale

A command line tool for scale of pix.

## Requirements

* Ruby/GdkPixbuf2 in
  [Ruby-GNOME2](http://ruby-gnome2.sourceforge.jp/)

## Installation

    gem install pix_scale

## Official supported format

* PNG
* JPEG

## Usage

### rate

    % ls -l
    -rw-rw-r-- 1 you you 46643 2013-06-27 20:00 foo.png

    % pix_scale foo.png 0.5

    % ls -l
    -rw-rw-r-- 1 you you 46643 2013-06-27 20:00 foo.png
    -rw-rw-r-- 1 you you 18539 2013-06-27 20:01 foo-0.5.png

### width/height

    % ls -l
    -rw-rw-r-- 1 you you 46643 2013-06-27 20:00 foo.png

    % pix_scale foo.png 200_200  # width_height

    % ls -l
    -rw-rw-r-- 1 you you 46643 2013-06-27 20:00 foo.png
    -rw-rw-r-- 1 you you 18539 2013-06-27 20:01 foo-200_200.png

#### width only (Height maintains a ratio.)

    % pix_scale foo.png 200

#### height only (Width maintains a ratio.)

    % pix_scale foo.png _200

### multiple files

    % ls -l
    -rw-rw-r-- 1 you you 46643 2013-06-27 20:00 foo.png
    -rw-rw-r-- 1 you you 31438 2013-06-27 20:00 bar.png

    % pix_scale *.png 0.5

    % ls -l
    -rw-rw-r-- 1 you you 46643 2013-06-27 20:00 foo.png
    -rw-rw-r-- 1 you you 18539 2013-06-27 20:01 foo-0.5.png
    -rw-rw-r-- 1 you you 31438 2013-06-27 20:00 bar.png
    -rw-rw-r-- 1 you you 16462 2013-06-27 20:01 bar-0.5.png

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
