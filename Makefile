BINDIR=$(HOME)/.local/bin
CACHEDIR=$(HOME)/.cache/mpv-ssh

install: mpv-ssh.sh
	cp ./mpv-ssh.sh $(BINDIR)/mpv-ssh
	chmod a+x $(BINDIR)/mpv-ssh
	mkdir $(CACHEDIR)

uninstall:
	rm $(BINDIR)/mpv-ssh
	rm -rf $(CACHEDIR)
