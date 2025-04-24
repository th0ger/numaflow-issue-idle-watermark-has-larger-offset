FROM python:3.11-slim-bullseye

ENV PYTHONFAULTHANDLER=1 \
  PYTHONUNBUFFERED=1 \
  PYTHONHASHSEED=random \
  PIP_NO_CACHE_DIR=on \
  PIP_DISABLE_PIP_VERSION_CHECK=on \
  POETRY_VIRTUALENVS_IN_PROJECT=true \
  POETRY_NO_INTERACTION=1 \
  VENV_PATH="/app/.venv"

ENV PATH="$VENV_PATH/bin:$PATH"

RUN apt-get update \
    && apt-get install --no-install-recommends -y dumb-init \
    && apt-get clean && rm -rf /var/lib/apt/lists/* \
    && pip install poetry==1.8.3

WORKDIR /app
COPY pyproject.toml poetry.lock /app/
RUN poetry install --no-cache --no-root
ADD . /app

ENTRYPOINT ["dumb-init", "--", "python", "main.py"]
CMD []

EXPOSE 5000
