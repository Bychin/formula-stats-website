from django.shortcuts import render
from django.views import generic

from .models import Race, Event, Driver, Team


#class HomeView(generic.ListView):
#    model = Race
#    template_name = '../templates/home.html'

#    def get_queryset(self):
#        return Race.objects.order_by('time', '-laps').all()


def home(request):
    return render(request, 'home.html', {'race_list': Race.objects.order_by('time', '-laps').all(), 'event_list': Event.objects.order_by('event_date').all()})


def drivers(request):
    return render(request, 'drivers.html', {'driver_list': Driver.objects.order_by('number').all()})


def driver_profile(request, driver_name):
    return render(request, 'driver_profile.html', {'driver_info': Driver.objects.filter(name=driver_name).all(),})


def teams(request):
    return render(request, 'teams.html', {'team_list': Team.objects.all()})


def team_profile(request, team_name):
    return render(request, 'team_profile.html', {'team_info': Team.objects.filter(name=team_name).all(),})
