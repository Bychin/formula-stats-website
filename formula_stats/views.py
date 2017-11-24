from django.shortcuts import render
from django.views import generic

from .models import Race


class HomeView(generic.ListView):
    model = Race
    template_name = '../templates/home.html'

    def get_queryset(self):
        return Race.objects.order_by('time', '-laps').all()


#def home(request):
#    return render(request, 'home.html')
