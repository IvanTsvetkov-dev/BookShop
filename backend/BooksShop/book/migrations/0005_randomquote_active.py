# Generated by Django 4.2.13 on 2024-08-30 18:59

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('book', '0004_randomquote_remove_book_image'),
    ]

    operations = [
        migrations.AddField(
            model_name='randomquote',
            name='active',
            field=models.BooleanField(default=False),
        ),
    ]
