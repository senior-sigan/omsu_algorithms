CXX = clang++
CFLAGS = -std=c++20 -pedantic -pedantic-errors -Wall -Werror -Wextra
LDFLAGS = -lm
SOURCES = main.cpp
STYLE = Google

all: build run

run:
	./main < tests/input_01.txt | diff tests/output_01.txt -
	./main < tests/input_02.txt | diff tests/output_02.txt -
	echo 'DONE!'

reformat:
	clang-format -i --style=$(STYLE) $(SOURCES)

build:
	$(CXX) $(CFLAGS) $(LDFLAGS) $(SOURCES) -o main

.PHONY = build run all reformat
