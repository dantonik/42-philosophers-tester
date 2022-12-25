#include "ft_malloc.h"

void *ft_malloc(size_t size) {
  // Allocate memory using the system malloc function
  void *ptr = malloc(size);

  // Increment total allocated memory
  total_allocated += size;

  return ptr;
}

// Custom implementation of free
void ft_free(void *ptr) {
  // Free the memory using the system free function
  free(ptr);
}

int main(int argc, char **argv) {
  // Allocate some memory
  char *str = ft_malloc(10);

  // Free the memory
  ft_free(str);

  // Check if total allocated memory is zero
  if (total_allocated == 0) {
    printf("Everything was successfully freed.\n");
  } else {
    printf("Error: Not all memory was freed.\n");
  }

  return 0;
}