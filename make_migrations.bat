@echo off
python .\backend\BooksShop\manage.py makemigrations
python .\backend\BooksShop\manage.py migrate
python .\backend\BooksShop\manage.py runserver