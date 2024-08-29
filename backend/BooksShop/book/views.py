from pyexpat import model
from django.http import HttpResponse, JsonResponse
from book.serializer import BasketSerializer, BookSerializer
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework.views import APIView
from book import models
from rest_framework.permissions import IsAuthenticated

# API
# def books_list(request):
#     mymodel = models.Book.objects.all()
#     data = {
#         'data': list(mymodel.values('title', 'author', 'price')),  # Только необходимые поля
#     }
#     return JsonResponse(data)
class BooksList(APIView):
    def get(self, request, format=None):
        books = models.Book.objects.all()
        serializer = BookSerializer(books, many=True)
        return Response(serializer.data)
class BookDetail(APIView):
    def get(self, request, id):
        book = models.Book.objects.filter(id=id).first()
        serializer = BookSerializer(book)
        return Response(serializer.data)
    
class BasketContent(APIView): #Auth
    permission_classes = [IsAuthenticated]
    def get(self, request):
        user_id = request.user.id
        content_basket = models.Basket.objects.filter(user_id=user_id)
        print(content_basket)
        serializer = BasketSerializer(content_basket, many=True)
        return Response({"basket_content": serializer.data})
        
    #def post(self, request):
        





# @api_view(['GET'])
# def books_list(request):
    
#     if request.method == "GET":
#         books = models.Book.objects.all()
#         serializer = BookSerializer(books, many=True)
#         return Response(serializer.data)

# @api_view(['GET'])
# def book_detail(request, id):
#     if request.method == "GET":
#         book = models.Book.objects.filter(id=id).first()
#         serializer = BookSerializer(book)
#         return Response(serializer.data)
    