from django.core.exceptions import *
from book.serializer import RandomQuoteSerializer
from book import models

def get_actual_quote():
    try:
        return models.RandomQuote.objects.filter(active=False).order_by("date_usage").first()
    except ObjectDoesNotExist:
        return None
    
def activate_quote(quote, date_now):
    quote.active = True
    quote.date_usage = date_now
    quote.save()
    return RandomQuoteSerializer(quote).data