FROM python:3.9.20-alpine3.20

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN pip install --upgrade pip

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY ./backend/BooksShop/. .

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]