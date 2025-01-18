# Use an official Python runtime as a parent image
FROM python:3.9-slim

USER root
# Set the working directory in the container
WORKDIR /app

# Copy the requirements.txt, .env file into the container at /app
COPY requirements.txt /tmp/requirements.txt
COPY sources.list /etc/apt/sources.list


# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates\
    openjdk-11-jdk-headless \
    wget \
    curl \
    gpg \
    python3 \
    python3-pip
    # apt-get clean 
    # rm -rf /var/lib/apt/lists/*
# apt-get clean 

# Install any needed packages specified in requirements.txt
RUN pip3 install --upgrade pip
RUN pip3 install --no-cache-dir -r /tmp/requirements.txt

# Expose Spark ports
EXPOSE 5000

# Default command
# CMD ["python", "app.py"]



