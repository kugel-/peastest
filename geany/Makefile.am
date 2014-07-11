# Seed plugin loader

loaderdir = $(libdir)/libpeas-1.0/loaders

INCLUDES = \
	-I$(top_srcdir)			\
	$(PEAS_CFLAGS)			\
	$(GCOV_CFLAGS)			\
	$(WARN_CFLAGS)			\
	$(DISABLE_DEPRECATED)	\
	-Wno-missing-prototypes

loader_LTLIBRARIES = libgeanyloader.la

libgeanyloader_la_SOURCES = \
	peas-plugin-loader-geany.c 	\
	peas-plugin-loader-geany.h

libgeanyloader_la_LDFLAGS = $(LOADER_LIBTOOL_FLAGS) $(GCOV_LDFLAGS)
libgeanyloader_la_LIBADD = $(PEAS_LIBS)

gcov_sources = $(libgeanyloader_la_SOURCES)
include $(top_srcdir)/Makefile.gcov
