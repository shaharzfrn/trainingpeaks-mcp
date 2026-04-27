FROM python:3.12-slim

ENV PYTHONUNBUFFERED=1

WORKDIR /app

COPY pyproject.toml README.md ./
COPY src/ src/

RUN pip install --no-cache-dir ".[http]"

RUN useradd --system --no-create-home appuser
USER appuser

EXPOSE 8001

ENTRYPOINT ["tp-mcp", "serve", "--transport", "sse"]
CMD ["--host", "0.0.0.0", "--port", "8001"]
