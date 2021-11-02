# Step 01: Instantiate a Linux OS image. Here Fedora is the that will
# be used. At Docker Hub (https://hub.docker.com) it is possible to
# search for other images.
FROM fedora:latest

# Step 02: Mapping the volumes (container directories) where the
# tests (inputs) and results (outputs) will be placed.
VOLUME /opt/robotframework/reports
VOLUME /opt/robotframework/tests

# Step 03: The sequence of commands bellow will install everything that
# project needs to run in this Linux container.
### Step 03.1 - Update Fedora and install python38.
RUN dnf upgrade -y && dnf install -y python38
### Step 03.2 - Update pip to avoid package install problems
### (https://stackoverflow.com/a/53929808).
RUN pip3 install --upgrade pip
### Step 03.3 - Copy local requirements.txt file to another requirements.txt
### file located inside the container image.
COPY requirements.txt requirements.txt
### Step 03.4 - Install Robot Framework and all requirements that the
### project demands.
RUN pip3 install --user -r requirements.txt
