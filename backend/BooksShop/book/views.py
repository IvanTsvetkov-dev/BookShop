from pyexpat import model
from django.http import HttpResponse, JsonResponse
from book.taskForQuote import activate_quote, get_actual_quote
from book.serializer import BasketSerializer, BookSerializer, RandomQuoteSerializer
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework.views import APIView
from book import models
from rest_framework.permissions import IsAuthenticated
from django.http import Http404
from rest_framework import status
from datetime import date, timedelta
from django.db.models import Q
from django.core.exceptions import *
from rest_framework import generics
from rest_framework.views import APIView
from users.serializers import UserSerializer
from users.models import CustomUser
from rest_framework.response import Response

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
        serializer = BasketSerializer(content_basket, many=True)
        return Response({"basket_content": serializer.data})
    
    def post(self, request):
        serializer = BasketSerializer(data=request.data)
        if serializer.is_valid(raise_exception=True):
            serializer.save(user_id=request.user.id)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        #return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class RandomQuote(APIView):
    def get(self, request):
        date_now = date.today() + timedelta(days=2)
        
        try:
            quote = models.RandomQuote.objects.get(active=True)
            
            if quote.date_usage == date_now: # if actual quote of the day
                serializer = RandomQuoteSerializer(quote)
                
                return Response({"random_quote": serializer.data})
            
            #deactive old quote
            quote.active = False
            
            quote.save()

        except ObjectDoesNotExist:
            pass
        
        actual_random_quote = get_actual_quote()

        if actual_random_quote:
            return Response({"random_quote": activate_quote(actual_random_quote, date_now)})

        return Response({}, status=status.HTTP_404_NOT_FOUND)

class CustomUserCreate(generics.CreateAPIView):
    queryset = CustomUser.objects.all()
    serializer_class = UserSerializer

    def post(self, request, *args, **kwargs):
        return self.create(request, *args, **kwargs)
        