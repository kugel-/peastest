VALAC = valac
VALACFLAGS = -v \
	--vapidir .\
	--vapidir ../libpeas.git/libpeas \
	--vapidir ../libpeas.git/libpeas-gtk \
	--pkg gobject-introspection-1.0 \
	--pkg libpeas-1.0 --pkg gtk+-3.0 --pkg libpeas-gtk-1.0 \
	--Xcc=-I. --Xcc=-I../libpeas.git/libpeas

DEBUG = -g --save-temps

.PHONY: vapi typelib cfiles

all: main
vapi: Peasy-1.0.vapi
typelib: Peasy-1.0.typelib

VALA_SRC = \
	main.vala \
	Greeter.vala \
	PeasGeany.vala

VALA_OBJ = ${VALA_SRC:%.vala=%.o}

LDFLAGS = $(shell pkg-config --libs-only-other glib-2.0 gio-2.0 gtk+-3.0 libpeas-1.0 libpeas-gtk-1.0)
LDLIBS = $(shell pkg-config --libs glib-2.0 gio-2.0 gtk+-3.0 libpeas-1.0 libpeas-gtk-1.0)

main: main.o Greeter.o pluginprovider.o

Greeter.o main.o: $(VALA_SRC)
	$(VALAC) $(DEBUG) $(VALACFLAGS) -c $^

pluginprovider.o: pluginprovider.c
	$(CC) -I../libpeas.git/libpeas $(shell pkg-config --cflags glib-2.0) -c $^

Peasy-1.0.vapi: main.vala Greeter.vala
	$(VALAC) $(VALACFLAGS) --vapi Peasy-1.0.vapi $^

Peasy-1.0.typelib: main.vala Greeter.vala
	$(VALAC) $(VALACFLAGS) --library Peasy --gir Peasy-1.0.gir $^
	g-ir-compiler -o Peasy-1.0.typelib Peasy-1.0.gir

clean:
	rm -f *.o $(VALA_SRC:%.vala=%.c) main
