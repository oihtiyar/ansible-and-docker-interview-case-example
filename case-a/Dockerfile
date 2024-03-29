# MongoDB Dockerfile for a 3-node replica set cluster

# Base image
FROM mongo:latest

# Create a keyfile for intra-cluster authentication
RUN mkdir -p /usr/local/var/mongodb/pki/
RUN openssl rand -base64 741 > /usr/local/var/mongodb/pki/replicaset-keyfile
RUN chmod 400 /usr/local/var/mongodb/pki/replicaset-keyfile

# Copy node-specific configuration files
COPY node1.conf /etc/mongod.conf
COPY node2.conf /etc/mongod_node2.conf
COPY node3.conf /etc/mongod_node3.conf

# Expose MongoDB ports
EXPOSE 27017

# Start MongoDB with replica set name
CMD ["mongod", "--config", "/etc/mongod.conf"]