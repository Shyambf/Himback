from django.contrib import admin
from .models import Service, Client, Visit

class ServiceAdmin(admin.ModelAdmin):
    list_display = ['id', 'name', 'cost', 'duration_minutes']
    list_filter = ['cost']

class ClientAdmin(admin.ModelAdmin):
    list_display = ['id', 'full_name', 'phone_number', 'category', 'email']
    list_filter = ['category']

class VisitAdmin(admin.ModelAdmin):
    list_display = ['id', 'client', 'service', 'date', 'time', 'service_rendered']
    list_filter = ['date', 'service']

admin.site.register(Service, ServiceAdmin)
admin.site.register(Client, ClientAdmin)
admin.site.register(Visit, VisitAdmin)
