'''
from django.db import models
from django.contrib.auth.models import User

class UserProfile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    data_nascimento = models.DateField(null=True, blank=True)
    endereco = models.CharField(max_length=255, null=True, blank=True)

    def __str__(self):
        return self.user.username
    
    '''

