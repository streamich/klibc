/*
 * stddef.h
 */

#ifndef _STDDEF_H
#define _STDDEF_H

#ifndef __KLIBC__
# error "__KLIBC__ not defined, compiler invocation error!"
#endif

#include <bitsize/stddef.h>

#undef NULL
#ifdef __cplusplus
# define NULL 0
#else
# define NULL ((void *)0)
#endif

#undef offsetof
#define offsetof(t,m) ((size_t)&((t *)0)->m)

#endif				/* _STDDEF_H */
