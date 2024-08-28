from pyexpat import model
from django.http import HttpResponse, JsonResponse
from book.serializer import BookSerializer
from rest_framework.decorators import api_view
from rest_framework.response import Response
from book import models

# API
# def books_list(request):
#     mymodel = models.Book.objects.all()
#     data = {
#         'data': list(mymodel.values('title', 'author', 'price')),  # Только необходимые поля
#     }
#     return JsonResponse(data)






@api_view(['GET'])
def books_list(request):
    
    if request.method == "GET":
        books = models.Book.objects.all()
        serializer = BookSerializer(books, many=True)
        return Response(serializer.data)

@api_view(['GET'])
def book_detail(request, id):
    if request.method == "GET":
        book = models.Book.objects.filter(id=id).first()
        serializer = BookSerializer(book)
        return Response(serializer.data)
    