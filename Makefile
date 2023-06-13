# Include .env file if it exists
-include .env
export

# Variables
SCRIPT=./mb_runner.sh

# Build rules
all: build

build:
	$(SCRIPT) build

test:
	$(SCRIPT) test

package:
	$(SCRIPT) package

clean:
	$(SCRIPT) clean

simulator:
	$(SCRIPT) simulator

push:
	$(SCRIPT) push
