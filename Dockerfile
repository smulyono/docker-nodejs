# Using alpine edge
FROM smulyono/base-image:latest

MAINTAINER Sanny Mulyono <smulyono@me.com>

# Install nodejs development dependencies
# nodejs, npm, bower, grunt, yeoman
RUN apk add nodejs bash && \ 
	if [ -x /usr/bin/npm ]; \
	then \
	npm install -g grunt grunt-cli && \ 
	npm install -g bower && \
	npm install -g yo && \
	npm install -g n ; \
	fi

CMD ["/bin/bash"]