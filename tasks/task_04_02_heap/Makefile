CXX = clang++
CFLAGS = -std=c++20 -pedantic -pedantic-errors -Wall -Werror -Wextra
LDFLAGS = -lm
SOURCES = main.cpp
STYLE = Google

all: reformat main run

run:
	./main < tests/input_01.txt | diff tests/output_01.txt -
	./main < tests/input_02.txt | diff tests/output_02.txt -
	echo 'DONE!'

reformat:
	clang-format -i --style=$(STYLE) $(SOURCES)

main:
	$(CXX) $(CFLAGS) $(LDFLAGS) $(SOURCES) -o "$@"

main-debug: $(SRCS) $(HEADERS)
	$(CXX) $(CXXFLAGS) -O0 $(SRCS) -o "$@"

clean:
	rm -f main main-debug

.PHONY: main main-debug run all reformat
