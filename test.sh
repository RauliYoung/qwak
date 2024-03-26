#!/bin/bash

# Ensure script is executable
chmod u+x qwak.sh

# Template for Dockerfile
DOCKERFILE_TEMPLATE=$(cat <<EOF
FROM ubuntu:latest

RUN apt-get update && apt-get install -y gawk

COPY qwak.sh /usr/local/bin/
RUN echo '#!/bin/bash' > /usr/local/bin/qwak \
    && echo '/usr/local/bin/qwak.sh "\$@"' >> /usr/local/bin/qwak \
    && chmod +x /usr/local/bin/qwak
ENTRYPOINT ["/bin/bash"]
EOF
)

# Write Dockerfile to a temporary file
echo "$DOCKERFILE_TEMPLATE" > Dockerfile

# Build Docker image from Dockerfile
docker build -t qwak .

# Run the Docker container
docker run -it --rm --name qwak qwak

# Remove execute permissions from the script
chmod -x qwak.sh