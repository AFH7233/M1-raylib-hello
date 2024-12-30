BIN = graphics

ASSEMBLER = as
LINKER = ld
ENTRYPOINT = _main
ARCH = arm64
LIB_SEARCH_PATH = System -syslibroot `xcrun -sdk macosx --show-sdk-path`
LIB_GRAPHICS =  -lraylib -framework OpenGL -framework GLUT -framework Cocoa -framework IOKit -framework CoreVideo

ODIR = obj
BDIR = bin
SDIR = src

BINPATH = $(BDIR)/$(BIN)

SRCS = $(wildcard $(SDIR)/*.s)
OBJS = $(patsubst $(SDIR)/%.s, $(ODIR)/%.o, $(SRCS))

$(shell mkdir -p $(ODIR) $(BDIR))

$(ODIR)/%.o: $(SDIR)/%.s
	$(ASSEMBLER) -o $@ $< -g

$(BINPATH): $(OBJS)
	$(LINKER) -o $(BINPATH) ${OBJS} -L$(SDIR) $(LIB_GRAPHICS) -l$(LIB_SEARCH_PATH) -e $(ENTRYPOINT) -arch $(ARCH)

.PHONY: clean

clean:
	rm -rf *~ $(ODIR) $(BDIR)
