#!/bin/bash

/usr/bin/Xvfb $DISPLAY > /dev/null 2>&1 &
xterm &
x11vnc -display $DISPLAY -forever -create > /dev/null 2>&1 &
java -jar /usr/bin/selenium-server-standalone.jar 

