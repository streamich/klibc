# -*- makefile -*-
#
# arch/arm/Makefile.inc
#
# Special rules for this architecture.  Note that this is actually
# included from the main Makefile, and that pathnames should be
# accordingly.
#

KLIBCARCHOBJS = \
	arch/arm/syscall.o \
	arch/arm/vfork.o \
	libgcc/__udivmodsi4.o \
	libgcc/__divdi3.o \
	libgcc/__moddi3.o \
	libgcc/__udivdi3.o \
	libgcc/__umoddi3.o \
	libgcc/__udivmoddi4.o \

ifeq ($(THUMB),y)
KLIBCLIBGCC   :=
KLIBCARCHOBJS += arch/arm/setjmp-thumb.o \
	libgcc/__divsi3.o \
	libgcc/__modsi3.o \
	libgcc/__udivsi3.o \
	libgcc/__umodsi3.o \

else
KLIBCARCHOBJS += arch/arm/setjmp-arm.o
endif

arch/arm/sysstubs.a: arch/arm/sysstubs.pl
	mkdir -p arch/arm/sysstubs
	$(PERL) $< arch/arm/sysstubs
	$(MAKE) $(patsubst %.S,%.o,$(wildcard arch/arm/sysstubs/*.S))
	-rm -f $@
	$(AR) cq $@ arch/arm/sysstubs/*.o
	$(RANLIB) $@

archclean:
	-rm -rf arch/arm/sysstubs
	-rm -f arch/arm/sysstubs.a