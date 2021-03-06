CITYHASH_VER=1.1.1
CITYHASH_URL=http://cityhash.googlecode.com/files/cityhash-$(CITYHASH_VER).tar.gz

CITYHASH_SRC=cityhash-$(CITYHASH_VER)
CITYHASH_HEADER=-I$(CITYHASH_SRC)/src

LUA_HEADER="-I/usr/include/luajit-2.0"

all:cityhash.so

cityhash.so:lcityhash.o $(CITYHASH_SRC)/src/.libs/city.o
	g++ -ggdb -Wall -fPIC -shared $^ -o cityhash.so

lcityhash.o:lcityhash.cpp
	g++ -ggdb -Wall -c $< -o $@ -fPIC $(CITYHASH_HEADER) $(LUA_HEADER)

prepare:
	rm -rf cityhash-1.1.1
	curl -sq $(CITYHASH_URL) | tar -zxv
	cd cityhash-1.1.1 && ./configure --enable-shared && make

clean:
	rm -f lcityhash.o cityhash.so
