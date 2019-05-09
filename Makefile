# Copyright 2019 Grama Nicolae

.PHONY: gitignore clean memory beauty run
.SILENT: beauty clean memory gitignore

# Compilation variables
CC = g++
CFLAGS = -Wno-unused-parameter -Wall -Wextra -pedantic -g -03 -std=c++11
EXE = main
SRC = $(wildcard */*.cpp)
OBJ = $(SRC:.cpp=.o)

# Compiles the program
build: $(OBJ)
	$(info Compiling code...)
	@$(CC) -o $(EXE) $^ $(CFLAGS) ||:
	$(info Compilation successfull)
	-@rm -f *.o ||:
	@$(MAKE) -s gitignore ||:

%.o: %.cpp
	$(CC) -o $@ -c $< $(CFLAGS) 

# Executes the binary
run: build
	./$(EXE)

# Deletes the binary and object files
clean:
	rm -f $(EXE) $(OBJ)
	echo "Deleted the binary and object files"

# Automatic coding style, in my personal style
beauty-development:
	clang-format -i -style=file */*.cpp
	clang-format -i -style=file */*.h

# Checks the memory for leaks
MFLAGS = --leak-check=full --show-leak-kinds=all --track-origins=yes
memory:build
	valgrind $(MFLAGS) ./$(EXE)

# Adds and updates gitignore rules
gitignore:
	@echo "$(EXE)" >> .gitignore ||:
	@echo "sources/*.o" >> .gitignore ||:
	@echo ".vscode*" >> .gitignore ||:	
	echo "Updated .gitignore"