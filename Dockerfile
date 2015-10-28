FROM java:8

RUN apt-get update
#RUN apt-get install -y wget
RUN apt-get install -y supervisor

COPY ./package.json /OpeneUI/package.json
COPY ./bower.json /OpeneUI/bower.json

# to avoid download of the alfresco installer you can copy one from your docker context
COPY ./alfresco-community-5.0.d-installer-linux-x64.bin /tmp/alfresco-community-5.0.d-installer-linux-x64.bin
RUN chmod 755 /tmp/alfresco-community-5.0.d-installer-linux-x64.bin
WORKDIR /tmp
RUN ./alfresco-community-5.0.d-installer-linux-x64.bin --mode unattended --prefix /alfresco --alfresco_admin_password admin


COPY ./install.sh /tmp/install.sh
RUN chmod 755 /tmp/install.sh
RUN /tmp/install.sh

COPY ./init.sh /alfresco/init.sh
RUN chmod 755 /alfresco/init.sh

VOLUME /alfresco/alf_data
VOLUME /alfresco/tomcat/logs

EXPOSE 21 137 138 139 445 7070 8080 8000
WORKDIR /alfresco
CMD /usr/bin/supervisord -c /etc/supervisor/supervisord.conf -n
