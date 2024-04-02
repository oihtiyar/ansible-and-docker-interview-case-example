# Use the official Python image as base image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the Python script into the container
COPY binance_exchange_rates.py .

# Install requests module
RUN pip install requests

# Run the Python script when the container launches
CMD ["python", "binance_exchange_rates.py"]
