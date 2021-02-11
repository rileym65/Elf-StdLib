PROJECT = stdlib

$(PROJECT).prg: $(PROJECT).asm
	rcasm -l -v -x -d1802 $(PROJECT) 2>&1 | tee $(PROJECT).lst

clean:
	-rm $(PROJECT).prg


