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
                    mixins.DestroyModelMixin,
                    mixins.UpdateModelMixin,
                    viewsets.GenericViewSet):
    permission_classes = [IsAuthenticated]
    
    serializer_class = BasketSerializer
    
    def get_queryset(self):
        return models.Basket.objects.filter(user_id=self.request.user.id)
    def perform_create(self, serializer):
        serializer.save(user=self.request.user)
    def destroy(self, request, pk=None):
        basket_item = self.get_queryset().filter(book_id=pk).first()
        if not basket_item:
            return Response(status=status.HTTP_404_NOT_FOUND)
        self.perform_destroy(basket_item)
        return Response(status=status.HTTP_204_NO_CONTENT)
    def update(self, request, pk, *args, **kwargs):
        partial = kwargs.pop('partial', False)
        instance = self.get_queryset().filter(book_id=pk).first()
        serializer = self.get_serializer(instance, data=request.data, partial=partial)
        serializer.is_valid(raise_exception=True)
        self.perform_update(serializer)

        if getattr(instance, '_prefetched_objects_cache', None):
            instance._prefetched_objects_cache = {}

        return Response(serializer.data)
    
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