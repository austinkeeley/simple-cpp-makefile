CXX=g++
BOTHFLAGS= -g
DEFINES=
CXXFLAGS=${BOTHFLAGS} $(addprefix -D,$(DEFINES))
LDFLAGS=${BOTHFLAGS}
INCDIRS=./include/
INCLUDE=$(addprefix -I,$(INCDIRS))
OUT_DIR=./bin/
OBJ_DIR=./obj/
SRC_DIR=./src/
PROJECT=$(notdir $(PWD))

SRCS=$(wildcard $(addprefix $(SRC_DIR),*.cpp))
OBJS=$(patsubst %.cpp,%.o,$(subst $(SRC_DIR),$(OBJ_DIR),$(SRCS)))

binary: ${OBJS}
	$(CXX) $(OBJS) $(LDFLAGS) -o $(OUT_DIR)$(PROJECT)

# Global target
${OBJS}: $(OBJ_DIR)%.o : $(filter %$*.cpp,$(SRCS))
	$(CXX) $(CXXFLAGS) $(INCLUDE) -c $(filter %/$*.cpp,$(SRCS)) -o $(OBJ_DIR)$*.o

# Help
help:
	@echo "Make script"
	@echo "Targets:"
	@echo "	help			shows this message"
	@echo "	binary			compiles project binary"
	@echo "	${OBJ_DIR}<filename>.o	rebuilds object file"
	@echo "	clean			removes all .o's from ${OBJ_DIR}"
	@echo "	mrpwoper		executes clean and removes binary"

# Cleaning targets
clean:
	-rm -rvf $(OBJ_DIR)*
mrpwoper: clean
	-rm -rvf $(OUT_DIR)*

.PHONY: clean mrpwoper all help test
