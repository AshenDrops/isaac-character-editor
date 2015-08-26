NAME = charedit.out

DATAFILES = $(wildcard res/*/*)
OBJS = build/main.o

LIBS = -lsfml-graphics -lsfml-system -lsfml-window
DEBUG = -g
CFLAGS = -Wall -c $(DEBUG)
LFLAGS = -Wall $(LIBS) $(DEBUG)

CXX := g++

#---------

build/$(NAME): $(OBJS) res/nicalis/pnglist.txt
	$(CXX) $(LFLAGS) -o $@ $(OBJS)

build/main.o: src/main.cpp build/data.h
	$(CXX) $(CFLAGS) -o $@ src/main.cpp

build/data.h: $(DATAFILES)
	echo -n "" > $@
	for file in $(DATAFILES); do xxd -i $$file >> $@; done

# For git -- I'm not sure about uploading nicalis resources to github
res/nicalis/pnglist.txt:
	echo "The files that need to be in this folder are:" > $@
	for file in $(wildcard res/nicalis/*); do echo $$file | cut -d "/" -f 3 >> $@; done

#---------

clean:
	\rm build/*

install:
	cp $(NAME) /usr/bin/$(NAME)

uninstall:
	rm -f /usr/bin/$(NAME)
