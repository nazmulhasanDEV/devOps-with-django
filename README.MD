# ADD vs COPY

# COPY → just copies files/folders (recommended in most cases).

# ADD → does the same plus extra features: 
    # Can automatically extract tar archives (e.g., ADD app.tar.gz /app)
    # Can download files from URLs (e.g., ADD https://example.com/file /tmp/file)


# Use:

==> ARG for build-time configs (like dependency versions).

ENV for runtime configs (like ports, environment modes, API keys).

✅ Summary:

ENV = runtime environment variables.

They persist in the running container.

Can be overridden at docker run with -e.

Best practice: set defaults with ENV and let users override with -e.


