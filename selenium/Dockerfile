FROM cncflora/java8

RUN apt-get update && apt-get install -y xvfb x11vnc iceweasel && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN curl -sSL -o /usr/bin/selenium-server-standalone.jar http://selenium-release.storage.googleapis.com/2.46/selenium-server-standalone-2.46.0.jar

ENV DISPLAY :99

EXPOSE 4444
EXPOSE 5900

ADD start.sh /root/start.sh

CMD ["/root/start.sh"]

