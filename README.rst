slidefit
========

Fit images into slides. **slidefit** is a command (callable from a
terminal) to fit (a lot of) images into a deck of slides. A template
deck of slides can be used to base the fitting on.

python-pptx_ library is used to do the zipped xml hacking and the file
format typically named with the extension `.pptx` is what is
supported.

.. _python-pptx: http://github.com/scanny/python-pptx

Installation
============

One could just copy the file ``slidefit.py`` and put it somewhere in
the PATH and manually install the dependencies python-pptx_ and
docopt_, but otherwise those standard methods should do,

.. _python-pptx: http://github.com/scanny/python-pptx
.. _docopt: https://github.com/docopt/docopt

Typical install::

   pip install slidefit

Install from cloned repo::

    pip install .

After the standard way of installation, **slidefit** should be available
as a command::

  slidefit --help

**slidefit** was written in python and therefore python is required.

Examples
========

- *Example1* One image per slide as big as possible (7 images, 7 slides)

  Assuming 7 images is required::

    slidefit img0[1-7].png

  Produced slides are saved with a default name
  (``slidefit-output.pptx``). Use ``-o`` to name it something
  different::

    slidefit -o example1.pptx img0[1-7].png

  Existing files are not over-written.

  .. image:: resources/example1.png

- *Example2* Three images per slide in a row (7 images, 3 slides)

  Use the ``--matrix`` option (``-m 1,3``) to specify layout as
  ``rows,cols``::

    slidefit -m 1,3 -o example2.pptx img0[1-7].png

  .. image:: resources/example2.png

- *Example3* Three images per slide in one column on the left side

  Use the ``--hspace`` (``-x``) to reserve some horizontal space on the
  left and/or right side as ``left,right``::

    slidefit -m 3,1 -x 5,80 -o example3.pptx img0[1-7].png

  The space is given as a percentage of available space.

  .. image:: resources/example3.png

- *Example4* Template with a title slide and 3 more slides with headings

  Use the ``--template`` option to specify a template slide deck. Put 4
  images in a row on each slide but not the first::

    slidefit -t resources/pen-slides.pptx -m 1,4 -y 20,10 -p 2-4 -o example4.pptx img*.png

  The ``--pages`` option (``-p``) is used to specify what pages to put
  images on.

  .. image:: resources/example4.png

- *Example5* Template as above, use different layout on slides

  For example a matrix 2,2 squeezed to the right on pages 2 and 4 and a
  matrix 1,3 on page 3. More than one pass is required to have different
  layouts on slides::

    slidefit -t resources/pen-slides.pptx -m 2,2 -x 65,5 -y 20,10 -p 2,4 -o tmp.pptx img0[1-4].png img0[8-9].png img1[0-1].png
    slidefit -t tmp.pptx -m 1,3 -y 20,10 -p 3 -o example5.pptx img0[5-7].png
    rm tmp.pptx

  .. image:: resources/example5.png

Other than adding images to slides, **slidefit** is not supposed to do
anything with the slides. A blank slide layout is chosen when no
template is given.

Use the ``--help`` option to see help.
