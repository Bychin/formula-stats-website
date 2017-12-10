from django.contrib import admin
from .models import *


admin.site.register(Team)
admin.site.register(Driver)
admin.site.register(Race)
admin.site.register(Event)
admin.site.register(MostSuccessfulDrivers)  # view
admin.site.register(MostSuccessfulTeams)  # view
admin.site.register(DriverRaces)  # view
