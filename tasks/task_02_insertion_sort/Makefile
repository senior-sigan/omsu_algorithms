CXX = clang++
CFLAGS = -std=c++20 -pedantic -pedantic-errors -Wall -Werror -Wextra
LDFLAGS = -lm
SOURCES = main.cpp
STYLE = Google

all: build run

run:
	./main < tests/input_01.txt | diff tests/output_01.txt -
	./main < tests/input_02.txt | diff tests/output_02.txt -
	./main < tests/input_03.txt | diff tests/output_03.txt -

reformat:
	clang-format -i --style=$(STYLE) $(SOURCES)

build:
	$(CXX) $(CFLAGS) $(LDFLAGS) $(SOURCES) -o main

.PHONY = build run all reformat
