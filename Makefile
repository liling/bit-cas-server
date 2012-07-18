all: clean package

package:
	mvn package

clean:
	mvn clean
