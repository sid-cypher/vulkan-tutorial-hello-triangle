CFLAGS = -std=c++17
LDFLAGS = -lglfw -lvulkan -ldl -lpthread -lX11 -lXxf86vm -lXrandr -lXi

.PHONY: test clean .FORCE

.FORCE:

helloTriangleNDebug: main.cpp .FORCE
	g++ $(CFLAGS) -o helloTriangle -DNDEBUG main.cpp $(LDFLAGS)

helloTriangle: main.cpp
	g++ $(CFLAGS) -o helloTriangle main.cpp $(LDFLAGS)

test: helloTriangle
	./helloTriangle

run: helloTriangleNDebug
	./helloTriangle

clean:
	rm -f helloTriangle
	
install:
	install -t ${out} helloTriangle
