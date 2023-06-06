from django.contrib import admin
from .models import customer_tmaskpl 

# Register your models here.
class AnsibleAdminArea(admin.AdminSite):
    site_header = 'Ansibel Admin TMaskPL'
    
ansible_site = AnsibleAdminArea(name='AnsibleAdmin')

ansible_site.register(customer_tmaskpl)

# @admin.register(customer_tmaskpl)
# class AnsibleAdmin(admin.ModelAdmin):
#     # list_display = ["customer_name"]
#     list_filter = ("customer_miasto",)