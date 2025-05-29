# MattisATM_Final Makefile 🧼

# Name of your Pascal file (without extension)
PROGRAM = MattisATM_Final

# Default build task
build:
	fpc $(PROGRAM).pas

# Run task (builds first if needed)
run: build
	./$(PROGRAM)

# Clean task to remove Pascal build artifacts
clean:
	rm -f $(PROGRAM) $(PROGRAM).o *.ppu *.compiled
