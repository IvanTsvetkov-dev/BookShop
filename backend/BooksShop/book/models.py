from django.db import models

from users.models import CustomUser

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

class Basket(models.Model): #One to many
    
    user = models.ForeignKey(
        CustomUser, 
        on_delete=models.CASCADE #If User del, all the rows cascade with him will be deleted from table "basket"
    )
    
    book_id = models.IntegerField(
        
    )
    
    count = models.IntegerField(
        default=0,
        null=False
    )
    
    def __str__(self):
        user = CustomUser.objects.get(id=self.user.id)
        book = Book.objects.get(id=self.book_id)
        return f"{user} : {book}"