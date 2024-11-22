CC = gcc
CFLAGS = -O3 -g

TARGET = test mandel

all: $(TARGET)

libppm.so: ppm.c  # Compile PPM lib to libppm.so
	$(CC) $(CFLAGS) -fpic -shared ppm.c -o libppm.so


test: main.c libppm.so  # Compile test executable
	$(CC) $(CFLAGS) $(LDFLAGS) main.c -lppm -L. -o $@ -lm -Wl,-rpath,.

mandel: mandel.c libppm.so  # Compile mandelbrot code source
	$(CC) $(CFLAGS) $(LDFLAGS) $< -lppm -L. -o $@ -lm -Wl,-rpath,.  

.PHONY: clean
clean:
	rm -fr $(TARGET) *.so 
