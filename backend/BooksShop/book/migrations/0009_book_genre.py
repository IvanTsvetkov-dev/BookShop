# Generated by Django 4.2.13 on 2024-08-31 21:32

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('book', '0008_book_image'),
    ]

    operations = [
        migrations.AddField(
            model_name='book',
            name='genre',
            field=models.CharField(choices=[('Rmnce', 'Romance'), ('Mystr', 'Mystre & Thriller'), ('Fntsy', 'Fantasy'), ('Sf-HP', 'Self-help'), ('Hrrr', 'Horror'), ('SF', 'Science Fiction'), ('CB', 'Children'), ('BA', 'Biography/Autobiography'), ('HF', 'Historical Fiction')], max_length=50, null=True),
        ),
    ]
