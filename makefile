SHELL := /bin/bash

update-source:
	# Updates the source files by copying the symlinks in the
	# source-symlinks folder (which point to files in the XLToolbox project)
	# to the source folder by dereferencing the symlinks, thereby
	# putting real files into the source folder.
	cp -L source-symlinks/* source/

vbagettextdemo.zip: vbagettextdemo/
	zip -r vbagettextdemo vbagettextdemo -x \*/.backup/\* \*~

upload-demo-zip: vbagettextdemo.zip
	rsync -rv vbagettextdemo.zip bovender@frs.sourceforge.net:/home/frs/project/vbagettext/

vbagettext.zip: source/
	mkdir -p tmp/vbagettext ; \
	cd tmp/vbagettext ; \
	cp -s ../../source/* . ; \
	cp -s ~/Documents/XLToolbox/develop/release/xltoolbox*.dll . ; \
	cd .. ; \
	zip -r ../vbagettext vbagettext -x \*/.git/\* ; \
	cd .. ; \
	rm -rf tmp

upload-zip: vbagettext.zip
	rsync -rv vbagettext.zip bovender@frs.sourceforge.net:/home/frs/project/vbagettext/
