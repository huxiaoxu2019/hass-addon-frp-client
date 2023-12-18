ARG BUILD_FROM
FROM $BUILD_FROM

ARG BUILD_ARCH

COPY bootstrap.sh /
COPY run.sh /

RUN chmod a+x /bootstrap.sh
RUN chmod a+x /run.sh

RUN /bootstrap.sh $BUILD_ARCH

CMD ["/run.sh"]
