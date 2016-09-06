# Using alpine edge
FROM smulyono/base-image:latest

MAINTAINER Sanny Mulyono <smulyono@me.com>

ENV NODEJS_VERSION=v5.5.0 NPM_VERSION=3
# Install nodejs development dependencies
# nodejs, npm, bower, grunt, yeoman

RUN apk add --update curl make gcc g++ binutils-gold python linux-headers paxctl libgcc libstdc++ && \
	curl -sSL https://nodejs.org/dist/${NODEJS_VERSION}/node-${NODEJS_VERSION}.tar.gz | tar -xz && \
	cd /node-${NODEJS_VERSION} && \
	./configure --prefix=/usr --without-snapshot --fully-static && \
	make -j$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && \
	make install && \
	paxctl -cm /usr/bin/node && \
	cd / && \
	if [ -x /usr/bin/npm ]; then \
	npm install -g npm@${NPM_VERSION} && \
	npm install -g bower && \
	npm install -g grunt-cli && \
	npm install -g yo && \
	find /usr/lib/node_modules/npm -name test -o -name .bin -type d | xargs rm -rf; \
	fi && \
	apk del curl make gcc g++ binutils-gold python linux-headers paxctl libgcc libstdc++ && \
	rm -rf /etc/ssl /node-${NODEJS_VERSION} /usr/include \
	/usr/share/man /tmp/* /var/cache/apk/* /root/.npm /root/.node-gyp \
	/usr/lib/node_modules/npm/man /usr/lib/node_modules/npm/doc /usr/lib/node_modules/npm/html

CMD ["/bin/ash"]