from book.models import Book, Basket
from rest_framework import serializers

class BookSerializer(serializers.ModelSerializer):
    class Meta:
        model = Book
        fields = ['id', 'title', 'author', 'price', 'count_in_storage']

class BasketSerializer(serializers.ModelSerializer):
    class Meta:
        model = Basket
        fields = ['user', 'book_id', 'count']