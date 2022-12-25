#ifndef FT_MALLOC_H
#define FT_MALLOC_H

#include <stdio.h>
#include <stdlib.h>

#define malloc ft_malloc
#define free ft_free

extern size_t total_allocated;
extern size_t total_freed;

// #define ft_malloc(size) ({ \
//   void *ptr = malloc(size); \
//   total_allocated += size; \
//   ptr; \
// })

// #define ft_free(ptr) free(ptr)

#endif