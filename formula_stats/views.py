from django.shortcuts import render
from django.views import generic

from .models import Race, Event, Driver, Team, MostSuccessfulDrivers, MostSuccessfulTeams


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
    driver_name = str(driver_name)   # sergio-perez
    true_name = ' '.join(driver_name.split('-')).title()  # Sergio Perez
    return render(request, 'driver_profile.html', {'driver_info': Driver.objects.filter(name=true_name).all(), })


def teams(request):
    return render(request, 'teams.html', {'team_list': Team.objects.all()})


def team_profile(request, team_name):
    driver_name = str(team_name)  # red-bull-racing
    true_name = ' '.join(driver_name.split('-')).title()  # Red Bull Racing
    print(true_name)
    return render(request, 'team_profile.html', {'team_info': Team.objects.filter(name=true_name).all(), })


def stats(request):
    return render(request, 'stats.html', {'driver_stats': MostSuccessfulDrivers.objects.order_by('-podiums').all(),
                                          'team_stats':  MostSuccessfulTeams.objects.order_by('-podiums').all()})
