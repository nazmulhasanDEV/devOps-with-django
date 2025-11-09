FROM python:3.11.14-alpine3.22

# Normally, when Python runs a script (like app.py or manage.py), it compiles it into bytecode — .pyc files — and stores them in a __pycache__ folder.

# Example:
# my_app/
# ├── app.py
# └── __pycache__/
#     └── app.cpython-311.pyc

#     These .pyc files are cached so that next time Python loads faster.

# However…
# in Docker containers, .pyc files don’t really help and can actually cause problems.
ENV PYTHONDONTWRITEBYTECODE=1



# When you run a Python program, its output (to stdout and stderr) is buffered by default.
# That means:
# Python doesn’t immediately print everything you print()
# It stores the output in memory (a buffer) and flushes it later (e.g., when full or program ends)
# This improves performance in normal scripts, but in Docker containers or logs, buffering causes delayed or missing log output.
ENV PYTHONUNBUFFERED=1



WORKDIR /app_v1

# copying the requirements file before other files so that the requirements file does not run and install all dependencies again if other files change
COPY ./app/requirements.txt ./app/requirements.txt
RUN --mount=type=cache,target=/root/.cache/pip \
    pip install --no-cache-dir -r ./app/requirements.txt

COPY . .

WORKDIR /app_v1/app

CMD [ "python3", "-u", "manage.py", "runserver", "0.0.0.0:8000"]