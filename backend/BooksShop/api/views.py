from datetime import date, timedelta
from api.serializers import BasketSerializer, BookSerializer, RandomQuoteSerializer
from rest_framework import mixins
from api.taskForQuote import activate_quote, get_actual_quote
from book import models
from django.core.exceptions import *
from rest_framework import viewsets
from rest_framework.permissions import *
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status

class BookViewSet(mixins.ListModelMixin,
                  mixins.RetrieveModelMixin,
                  viewsets.GenericViewSet):
    serializer_class = BookSerializer
    
    queryset = models.Book.objects.all()

class BasketViewSet(mixins.RetrieveModelMixin,
                    mixins.CreateModelMixin,
                    mixins.ListModelMixin,
                    viewsets.GenericViewSet):
    permission_classes = [IsAuthenticated]
    
    serializer_class = BasketSerializer
    
    def get_queryset(self):
        return models.Basket.objects.filter(user_id=self.request.user.id)
    
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