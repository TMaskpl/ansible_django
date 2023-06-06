from django.db import models
from django.core.validators import RegexValidator

numeric = RegexValidator(r'^[0-9]+', 'Only digit characters.')

# Create your models here.
class customer_tmaskpl(models.Model):
    customer_name = models.CharField('Pełna nazwa firmy', max_length=100)
    customer_skrot_firmy = models.CharField('Skrót firmy', null=True, max_length=50)
    customer_miasto = models.CharField('Miasto', blank=True, null=True, max_length=50)
    customer_kod_pocztowy = models.CharField('Kod pocztowy', blank=True, null=True, max_length=6)
    customer_ul = models.CharField('Nazwa ulicy', blank=True, null=True, max_length=50)
    customer_nr_lok = models.CharField('Numer lokalu', blank=True, null=True, max_length=50)
    customer_telefon = models.CharField('Telefon', null=True, max_length=50, validators=[numeric])
    customer_email = models.EmailField('Email', null=True, max_length=50)
    customer_github = models.CharField('Github', blank=True, null=True, max_length=250)
    customer_facebook = models.CharField('Facebook', blank=True, null=True, max_length=250)
    customer_linkedin = models.CharField('LinkedIn', blank=True, null=True, max_length=250)
    customer_opis = models.TextField('Opis', blank=True, default="")
    customer_data_wprowadzenia = models.DateTimeField('Data utworzenia', auto_now_add=True)
    customer_data_aktualizacji = models.DateTimeField('Data ostatniej aktualizacji', auto_now=True, null=True)
    customer_upload = models.FileField(upload_to ='%Y/%m/%d/', blank=True, null=True)
    
    class Meta:
        verbose_name = 'Customer TMaskPL'
        verbose_name_plural = "Customer"
    
    def __str__(self):
        return self.customer_name