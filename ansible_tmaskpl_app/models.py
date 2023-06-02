from django.db import models


# Create your models here.
class customer_tmaskpl(models.Model):
    
    customer_name = models.CharField(max_length=100)
    customer_skrot_firmy = models.CharField('Skrót firmy', null=True, max_length=50)
    customer_miasto = models.CharField('Miasto', null=True, max_length=50)
    customer_kod_pocztowy = models.CharField('Kod pocztowy', null=True, max_length=6)
    customer_ul = models.CharField('Nazwa ulicy', null=True, max_length=50)
    customer_nr_lok = models.CharField('Numer lokalu', null=True, max_length=50)
    customer_opis = models.TextField('Opis', null=True, default="")
    customer_data_wprowadzenia = models.DateTimeField('Data utworzenia', null=True)
    customer_data_aktualizacji = models.DateTimeField('Data ostatniej aktualizacji', auto_now_add=True, null=True)
    
    
    class Meta:
        verbose_name = 'Customer'
        verbose_name_plural = "Customer"
    
    def __str__(self):
        return self.customer_name