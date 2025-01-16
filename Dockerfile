# Use an official Python runtime as a parent image
FROM python:3.9-slim

USER root
# Set the working directory in the container
WORKDIR /app

# Copy the requirements.txt, .env file into the container at /app
COPY requirements.txt /app/
COPY .env /app/.env
COPY sources.list /etc/apt/sources.list

# Install any needed packages specified in requirements.txt
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates\
    openjdk-11-jdk-headless \
    wget \
    curl \
    gpg \
    python3 \
    python3-pip && \
    rm -rf /var/lib/apt/lists/*
# apt-get clean 


# Expose Spark ports
EXPOSE 5000

# Default command
CMD ["python", "app.py"]