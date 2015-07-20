#!/bin/bash

/usr/bin/Xvfb $DISPLAY > /dev/null 2>&1 & 
java -jar /usr/bin/selenium-server-standalone.jar

