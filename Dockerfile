FROM python:3.11-slim

WORKDIR /app

COPY Pipfile Pipfile.lock ./
RUN apt-get update && apt-get install -y python3.11

# Symlink python3.11 to python
RUN ln -s /usr/bin/python3.11 /usr/bin/python
RUN python -m pip install --upgrade pip

RUN pip install pipenv && pipenv install --dev --system --deploy && pipenv install python-dotenv

COPY . .

CMD ["pipenv", "run", "python", "app.py"]

