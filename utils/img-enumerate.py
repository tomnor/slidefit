#! /usr/bin/env python3
"""MAKE A SERIES OF NUMBERED IMAGES

Write a big number on each image.

Usage: img-enumerate.py [-h -o IMG -f FONT -n CNT] IMG

Options:
    -o, --basename IMG
                    Basename of output files including extension.
                    [default: img.png]. First image will be named
                    img001.png
    -n, --count CNT
                    The number of enumerated images to produce.
                    [default: 4]
    -f, --font FONT
                    Font to use for the images.
                    [default: /usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf]

    -h, --help      Show this help and exit.

Arguments:
    IMG             The input image.

"""
import os

from PIL import Image, ImageDraw, ImageFont
import docopt


def main(args):

    base = Image.open(args['IMG'])
    width, height = base.size
    font = ImageFont.truetype(args['--font'], 400)
    location = (0, 0.1 * height)

    fmt = '%s%s%s'
    left, ext = os.path.splitext(args['--basename'])

    for n in range(int(args['--count'])):
        copy = base.copy()
        drawable = ImageDraw.Draw(copy)
        drawable.text(location, str(n + 1), font=font, fill='black')
        copy.save(fmt % (left, str(n + 1).zfill(2), ext))


if __name__ == '__main__':
    args = docopt.docopt(__doc__)
    main(args)
