# --------------------------
# Stage 1: Builder
# --------------------------
FROM python:3.12 AS builder

WORKDIR /app

# Install build tools
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy files
COPY ./app/requirements.txt .

# Install dependencies (build wheels)
RUN pip wheel --no-cache-dir --wheel-dir /wheels -r requirements.txt


# --------------------------
# Stage 2: Final Runtime Image
FROM python:3.12-slim AS final


WORKDIR /app

# Install only runtime dependencies ==> rm -rf /var/lib/apt/lists/* this is removing cache, metadata of apt to reduce image size. when we install packages using apt-get, it downloads package lists and metadata to /var/lib/apt/lists/. after installation, this data is no longer needed.
RUN apt-get update && apt-get install -y libpq-dev && rm -rf /var/lib/apt/lists/*

# Copy pre-built wheels
COPY --from=builder /wheels /wheels
COPY --from=builder /app/requirements.txt .

# Install using wheels
RUN pip install --no-cache /wheels/*

# Copy Django project code
COPY ./app .

# Expose port
EXPOSE 8000

CMD ["python3", "-u", "manage.py", "runserver", "0.0.0.0:8000"]
