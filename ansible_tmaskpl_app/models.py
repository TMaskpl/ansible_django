from django.db import models

# Create your models here.
class customer_tmaskpl(models.Model):
    
    customer_name = models.CharField(max_length=100)
    
    class Meta:
        verbose_name = 'Customer'
        verbose_name_plural = "Customer"
    
    def __str__(self):
        return self.customer_name