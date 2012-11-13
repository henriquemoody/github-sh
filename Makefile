SCRIPT="bin/githsh"
default: compile man-pages

compile:
	@echo "Building script $(SCRIPT)"
	cat bin/githsh.sh | sed -nE '1,/^source/p' | egrep -v '^source' > $(SCRIPT)
	egrep '^source' bin/githsh.sh | cut -d '/' -f 3- | sed 's/"//g' | while read file_name; do cat $${file_name} | sed -E '/^ *#.+$$/d' | sed '/^$$/d' >> $(SCRIPT) && echo >> $(SCRIPT); done;
	cat bin/githsh.sh | sed -nE '/^source/,$$p' | sed -E '/^ *#.+$$/d' | egrep -v '^source' >> $(SCRIPT)
	chmod +x $(SCRIPT)

man-pages:
	@echo "Building man pages"
	find ./man -name '*.md' | xargs -n 1 ronn --roff

install: compile man-pages
	sudo cp $(SCRIPT) /usr/local/$(SCRIPT)
	sudo ln -s /usr/local/$(SCRIPT) /usr/local/bin/git-hsh
	find ./man -type f | grep -v '.md' | while read file_name; do echo sudo cp $$file_name $$(echo $$file_name | sed 's#^\.#/usr/local/share#g'); done