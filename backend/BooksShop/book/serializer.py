from book.models import Book, Basket, RandomQuote
from rest_framework import serializers

class BookSerializer(serializers.ModelSerializer):
    class Meta:
        model = Book
        fields = ['id', 'title', 'author', 'image', 'price', 'count_in_storage']

class BasketSerializer(serializers.ModelSerializer):
    class Meta:
        model = Basket
        fields = ['book_id', 'count']
        
class RandomQuoteSerializer(serializers.ModelSerializer):
    class Meta:
        model = RandomQuote
        fields = ['author', 'quote']