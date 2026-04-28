FROM python:3.12-slim

RUN apt-get update && apt-get install -y --no-install-recommends curl && rm -rf /var/lib/apt/lists/*

ENV PYTHONUNBUFFERED=1
ENV PORT=8001

WORKDIR /app

COPY pyproject.toml README.md ./
COPY src/ src/

RUN pip install --no-cache-dir ".[http]"

RUN useradd --system --no-create-home appuser
USER appuser

EXPOSE $PORT

ENTRYPOINT ["sh", "-c", "exec tp-mcp serve --transport sse --host 0.0.0.0 --port $PORT"]
