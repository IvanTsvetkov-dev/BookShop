from django.db import models

from users.models import CustomUser

class Book(models.Model):
    class GenreBook(models.TextChoices):
        ROMANCE = 'Rmnce', 'Romance'
        MYSTERY = 'Mystr', 'Mystery & Thriller'
        FANTASY = 'Fntsy', 'Fantasy'
        SELFHELP = 'Sf-HP', 'Self-help'
        HORROR = 'Hrrr', 'Horror'
        SCIENCEFICTION = 'SF', 'Science Fiction'
        CHILDRENBOOKS = 'CB', 'Children'
        BIOGRAPHY = 'B/A', 'Biography/Autobiography'
        HISTORICAL = 'HF', 'Historical Fiction'
        OTHER = 'OTHR', 'Other'
        
    
    
    
    
    title = models.CharField(
        max_length = 128,
        null=False
    )
    
    author = models.CharField(
        max_length = 128, 
        null=False
    )
    
    genre = models.CharField(
        max_length=50,
        null=True,
        choices=GenreBook.choices,
        default=GenreBook.OTHER
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
    
    image = models.ImageField(
        upload_to='books/',
        default=""
    )
    
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

class RandomQuote(models.Model):
    
    quote = models.CharField(
        max_length=96,
        null=False
    )
    
    author = models.CharField(
        max_length=15,
        null=False
    )
    
    date_usage = models.DateField(
        null=True,
        blank=True,
        default=None
    )
    
    active = models.BooleanField(
        default=False,
    )
    def __str__(self):
        return f"{self.quote} ©{self.author}"