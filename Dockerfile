# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set environment variables
ENV PYTHONUNBUFFERED 1

# Set working directory in the container
WORKDIR /app

# Copy requirements.txt file to the container
COPY requirements.txt /app/

# Install system dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    gcc \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --upgrade pip \
    && pip install -r requirements.txt

# Copy the current directory contents into the container at /app
COPY . /app/

# Optionally, you can create a virtual environment
RUN python -m venv venv

# Activate virtual environment
SHELL ["/bin/bash", "-c", "source venv/bin/activate"]

# Install wordpresslib (replace 'wordpresslib' with the actual package name)
RUN pip install wordpresslib

# Run your application
CMD ["python", "wordpresslib.py"]
