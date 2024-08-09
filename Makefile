PREFIX = /usr/local

asv: asv.sh asv.awk asv.tsv
	cat asv.sh > $@
	echo 'exit 0' >> $@
	echo '#EOF' >> $@
	tar czf - asv.awk asv.tsv >> $@
	chmod +x $@

test: asv.sh
	shellcheck -s sh asv.sh

clean:
	rm -f asv

install: asv
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f asv $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/asv

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/asv

.PHONY: test clean install uninstall
