# Copyright 2019 Grama Nicolae

.PHONY: gitignore clean memory beauty run
.SILENT: beauty clean memory gitignore

# Compilation variables
CC = g++
CFLAGS = -Wno-unused-parameter -Wall -Wextra -pedantic -g -O3 -std=c++11
EXE = bin/main
SRC = $(wildcard */*.cpp)
OBJ = $(SRC:.cpp=.o)

# Compiles the program
build: $(OBJ)
	$(info Compiling code...)
	@if [ ! -d "./bin" ]; then mkdir ./bin; fi ||:
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

# Automatic coding style
beauty:
	clang-format -i -style=file sources/*.cpp
	clang-format -i -style=file headers/*.h

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