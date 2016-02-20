#
# The *linux-helper-install-scripts package* by **peter1000** <https://github.com/peter1000> is licensed under the GPLv2 License
# and adapted from [arch-install-scripts dated 2015-07-04](https://projects.archlinux.org/arch-install-scripts.git) - GPLv2 License
#
#   This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public 
#   License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any 
#   later version.
# 
#   This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied 
#   warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
#

VER=15

PREFIX = /usr/local

BINPROGS = \
	linux-chroot \
	genfstab

BASH = bash

all: $(BINPROGS)

V_GEN = $(_v_GEN_$(V))
_v_GEN_ = $(_v_GEN_0)
_v_GEN_0 = @echo "  GEN     " $@;

edit = $(V_GEN) m4 -P $@.in >$@ && chmod go-w,+x $@

%: %.in common
	$(edit)

clean:
	$(RM) $(BINPROGS)

check: all
	@for f in $(BINPROGS); do bash -O extglob -n $$f; done
	@r=0; for t in test/test_*; do $(BASH) $$t || { echo $$t fail; r=1; }; done; exit $$r

install: all
	install -dm755 $(DESTDIR)$(PREFIX)/bin
	install -m755 $(BINPROGS) $(DESTDIR)$(PREFIX)/bin

uninstall:
	for f in $(BINPROGS); do $(RM) $(DESTDIR)$(PREFIX)/bin/$$f; done

.PHONY: all clean install uninstall
