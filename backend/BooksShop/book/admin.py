from django.contrib import admin

from .models import Book, Basket, RandomQuote

admin.site.register(Book)
admin.site.register(Basket)
admin.site.register(RandomQuote)
# Register your models here.
