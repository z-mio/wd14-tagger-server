FROM python:3.11-slim
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/
WORKDIR /usr/src/app
COPY . .
RUN cp .env.exp .env
RUN sed -i 's|SERVER_HOST=127.0.0.1|SERVER_HOST=0.0.0.0|' .env
RUN apt-get update && apt-get install -y libgl1-mesa-glx libglib2.0-0 && rm -rf /var/lib/apt/lists/*
RUN uv venv && uv sync --frozen
CMD ["uv", "run", "main.py"]