IMGCALL := utils/img-enumerate.py
TEMPLATE := resources/pen-slides.pptx
DISTFILES := slidefit.py CHANGES.rst README.rst


readme-see : README.html
README.html : README.rst
	rst2html $< $@; see $@

changes-see : CHANGES.html
CHANGES.html : CHANGES.rst
	rst2html $< $@; see $@

dist : $(DISTFILES)
	python3 setup.py sdist bdist_wheel

# ---------------- EXAMPLES ----------------

# requirements for slidefit is required for the examples

examples : example1 example2 example3 example4 example5 example6
images : imageflag

imageflag :
	$(IMGCALL) -n 12 -o img.png resources/profanity.png
	touch $@


# one image per slide as big as possible (7 images, 7 slides)
example1 : example1.pptx
example1.pptx : slidefit.py imageflag
	rm -f $@
	./slidefit.py -o $@ img0[1-7].png

# three images per slide (-m 1,3) (7 images, 3 slides)
example2 : example2.pptx
example2.pptx :  slidefit.py imageflag
	rm -f $@
	./slidefit.py -m 1,3 -o $@ img0[1-7].png

# three images per slide in one column (-m 3,1) on the left side (-x .,.)
example3 : example3.pptx
example3.pptx : slidefit.py imageflag
	rm -f $@
	./slidefit.py -m 3,1 -x 5,80 -o $@ img0[1-7].png

# use template (-t ...) and put 4 images on each page 2-4 (-p 2-4),
# give some room for the title and footer (-y .,.)
example4 : example4.pptx
example4.pptx : slidefit.py imageflag
	rm -f $@
	./slidefit.py -t $(TEMPLATE) -m 1,4 -y 20,10 -p 2-4 -o $@ img*.png

# use template and arrange to have a matrix 2,2 on pages 2 and 4 and a
# matrix 1,3 on page 3 by making two passes.
example5 : example5.pptx
example5.pptx : slidefit.py imageflag
	rm -f $@
	./slidefit.py -t $(TEMPLATE) -m 2,2 -x 65,5 -y 20,10 -p 2,4 -o tmp.pptx img0[1-4].png img0[8-9].png img1[0-1].png
	./slidefit.py -t tmp.pptx -m 1,3 -y 20,10 -p 3 -o $@ img0[5-7].png
	rm tmp.pptx

# same as 5 but not using special tmp.pptx by use of --force
example6 : example6.pptx
example6.pptx : slidefit.py imageflag
	rm -f $@
	./slidefit.py -t $(TEMPLATE) -m 2,2 -x 65,5 -y 20,10 -p 2,4 -o $@ img0[1-4].png img0[8-9].png img1[0-1].png
	./slidefit.py -f -t $@ -m 1,3 -y 20,10 -p 3 -o $@ img0[5-7].png

clean :
	rm -f *.png *.html *.pptx imageflag
	rm -rf dist build *egg-info
