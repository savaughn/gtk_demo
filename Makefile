# Compiler
CC = gcc

# Compiler flags
CFLAGS = `pkg-config --cflags gtk+-3.0`

# Linker flags
LDFLAGS = `pkg-config --libs gtk+-3.0`

# Target executable
TARGET = build/main

# Source files
SRCS = $(wildcard src/*.c)

# Object files
OBJS = $(patsubst src/%.c, build/%.o, $(SRCS))

# include directories
INCLUDES = -Iinclude

# Default target
all: build_dir $(TARGET)

# Create build directory if it doesn't exist
build_dir:
	@mkdir -p build

# Link the target executable
$(TARGET): $(OBJS)
	@$(CC) $(OBJS) -o $(TARGET) $(INCLUDES) $(LDFLAGS)
	@rm -f build/*.o
	@echo "Build complete! Run with ./$(TARGET)"

# Compile source files to object files
build/%.o: src/%.c
	@$(CC) -c $< -o $@ $(CFLAGS) $(INCLUDES)

# Clean up build files
clean:
	rm -f build/*.o $(TARGET)

.PHONY: all clean build_dir
