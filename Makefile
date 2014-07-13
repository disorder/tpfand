DESTDIR=/

all: man

man: tpfand.8

tpfand.8: man/tpfand.pod
	pod2man --section=8 --release=Version\ `cat src/tpfand/build.py | grep "version = " | sed  -e "s/version = \"\(.*\)\"/\1/"` --center "" man/tpfand.pod > tpfand.8

clean:
	rm -f tpfand.8
	rm -f src/tpfand/*.pyc

install: all
	install -d $(DESTDIR)/usr/lib/python2.5/site-packages/tpfand
	install src/tpfand/* $(DESTDIR)/usr/lib/python2.5/site-packages/tpfand
	install -d $(DESTDIR)/usr/share/tpfand/
	install -d $(DESTDIR)/usr/share/tpfand/models
	install -d $(DESTDIR)/usr/share/tpfand/models/by-id
	install -d $(DESTDIR)/usr/share/tpfand/models/by-name
	install share/models/generic $(DESTDIR)/usr/share/tpfand/models
	install -d $(DESTDIR)/etc/dbus-1/system.d/
	install etc/dbus-1/system.d/* $(DESTDIR)/etc/dbus-1/system.d/
	install -d $(DESTDIR)/usr/sbin
	install wrappers/tpfand $(DESTDIR)/usr/sbin/
	install -d $(DESTDIR)/etc/init.d
	install etc/init.d/* $(DESTDIR)/etc/init.d/
	install -d $(DESTDIR)/etc/acpi/suspend.d
	install -m 755 etc/acpi/suspend.d/acpi-stop.sh $(DESTDIR)/etc/acpi/suspend.d/09-tpfand-stop.sh
	install -d $(DESTDIR)/etc/acpi/resume.d
	install -m 755 etc/acpi/resume.d/acpi-start.sh $(DESTDIR)/etc/acpi/resume.d/91-tpfand-start.sh
	install -d $(DESTDIR)/etc/modprobe.d
	install etc/modprobe.d/thinkpad_acpi.modprobe $(DESTDIR)/etc/modprobe.d/
	if [ ! -e $(DESTDIR)/etc/tpfand.conf ] ; then install etc/tpfand.conf $(DESTDIR)/etc/tpfand.conf ; fi
	echo Installation complete.
	echo You still need to create links to the init script. 

uninstall:
	rm -rf $(DESTDIR)/usr/lib/python2.5/site-packages/tpfand
	rm -rf $(DESTDIR)/usr/share/tpfand/
	rm -f $(DESTDIR)/usr/sbin/tpfand
	rm -f $(DESTDIR)/etc/init.d/tpfand
	rm -f $(DESTDIR)/etc/dbus-1/system.d/tpfand.conf
	rm -f $(DESTDIR)/etc/acpi/suspend.d/09-tpfand-stop.sh
	rm -f $(DESTDIR)/etc/acpi/resume.d/91-tpfand-start.sh
	rm -f $(DESTDIR)/etc/modprobe.d/thinkpad_acpi.modprobe
	rm -f $(DESTDIR)/etc/tpfand.conf



