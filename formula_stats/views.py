from django.shortcuts import render
from django.views import generic

from .models import Race, Event


#class HomeView(generic.ListView):
#    model = Race
#    template_name = '../templates/home.html'

#    def get_queryset(self):
#        return Race.objects.order_by('time', '-laps').all()


def home(request):
    return render(request, 'home.html', {'race_list': Race.objects.order_by('time', '-laps').all(), 'event_list': Event.objects.order_by('event_date').all()})
