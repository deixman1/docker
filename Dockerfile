RUN curl -L -o /tmp/meminfo.tar.gz https://github.com/BitOne/php-meminfo/archive/master.tar.gz \
    && tar zxpf /tmp/meminfo.tar.gz -C /tmp \
    && rm -r /tmp/meminfo.tar.gz \
    && cd /tmp/php-meminfo-master/extension/ && phpize && ./configure --enable-meminfo && make && make install \
    && rm -rf /tmp/php-meminfo-master \
    && printf "extension=meminfo.so\n" > $PHP_INI_DIR/conf.d/meminfo.ini

# install wget (for downloading memprof) and libjudy (dependency of memprof)
RUN apt-get update \
	&& apt-get install -y wget libjudy-dev

# install php-memprof
RUN cd ~ \
	&& mkdir php-memprof \
	&& cd php-memprof \
	&& wget --no-check-certificate --content-disposition https://github.com/arnaud-lb/php-memory-profiler/tarball/3.0.2  \
	&& tar -zxvf arnaud-lb-php-memory-profiler-3.0.2-0-gb751f1c.tar.gz \
    && cd arnaud-lb-php-memory-profiler-b751f1c \
	&& phpize \
	&& ./configure \
	&& make \
	&& make install \
    && printf "extension=memprof.so\n" > $PHP_INI_DIR/conf.d/memprof.ini
