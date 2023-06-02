from django.contrib import admin
from . import models

# Register your models here.
class AnsibleAdminArea(admin.AdminSite):
    site_header = 'Ansibel Admin TMaskPL'
    
ansible_site = AnsibleAdminArea(name='AnsibleAdmin')

ansible_site.register(models.customer_tmaskpl)