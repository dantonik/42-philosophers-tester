# Makefile for test program

# Set the name of the test program
TEST_PROGRAM = main

# Set the name of the source file that contains the custom malloc and free functions
FT_MALLOC_FILE = ft_malloc.c

# Set the name of the header file that defines the ft_malloc and ft_free macros
FT_MALLOC_HEADER = ft_malloc.h

# Set the name of the Makefile in the parent folder
PARENT_MAKEFILE = ../../Makefile

# Set the CFLAGS and LDFLAGS variables to include the custom malloc and free functions
CFLAGS += -I. -include $(FT_MALLOC_HEADER)
LDFLAGS += $(FT_MALLOC_FILE)

# Default target: build the test program
$(TEST_PROGRAM): $(FT_MALLOC_FILE) $(FT_MALLOC_HEADER)
	$(MAKE) -C .. $(TEST_PROGRAM) CFLAGS="$(CFLAGS)" LDFLAGS="$(LDFLAGS)"

# Clean target: clean the test program and run the clean target in the parent folder
clean:
	rm -f $(TEST_PROGRAM)
	$(MAKE) -C .. clean

.PHONY: clean

# gcc test_program.c ft_malloc.c -o test_program