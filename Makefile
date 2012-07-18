all: clean package

package:
	mvn package

clean:
	mvn clean

upload:
	scp target/cas.war root@10.0.6.9:/opt/tomcat7-cas/webapps/
