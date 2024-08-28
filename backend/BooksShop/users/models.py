from django.db import models
from django.contrib.auth.models import AbstractUser

class CustomUser(AbstractUser):

    phone = models.CharField(
        blank=True, 
        null=True,
        max_length=11
    )

    def __str__(self):
        full_name = f'{self.last_name} {self.first_name}'.strip()
        result = full_name if len(full_name) > 0 else self.username
        return f'{result}'

