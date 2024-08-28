from django.db import models

class Book(models.Model):
    
    title = models.CharField(
        max_length = 128,
        null=False
    )
    
    author = models.CharField(
        max_length = 128, 
        null=False
    )
    
    price = models.DecimalField(
        decimal_places=2,
        max_digits=6,
        null=False
    )
    
    count_in_storage = models.IntegerField(
        default=0,
        null=False
    )
    
    image = models.CharField(max_length=256, default='')
    
    def __str__(self):
        name = f"{self.author} {self.title}"
        return name
