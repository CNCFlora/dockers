FROM cncflora/java8

RUN apt-get update && apt-get install -y xvfb iceweasel && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN curl -sSL -o /usr/bin/selenium-server-standalone.jar http://selenium-release.storage.googleapis.com/2.45/selenium-server-standalone-2.45.0.jar

ENV DISPLAY :99

EXPOSE 4444

ADD start.sh /root/start.sh

CMD ["/root/start.sh"]

