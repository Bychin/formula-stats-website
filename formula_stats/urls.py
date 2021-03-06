from django.conf.urls import url
from . import views
from django.conf import settings
from django.conf.urls.static import static
from django.views.generic import RedirectView

urlpatterns = [
    url(r'^$', views.home, name='home'),
    url(r'^drivers$', views.drivers, name='drivers'),
    url(r'^teams$', views.teams, name='teams'),
    url(r'^stats$', views.stats, name='stats'),
    url(r'^drivers/(?P<driver_name>\w+-\w+)/$', views.driver_profile, name='driver_profile'),
    url(r'^teams/(?P<team_name>\w+-?\w*-?\w*)/$', views.team_profile, name='team_profile'),
    url(r'^favicon\.ico$', RedirectView.as_view(url='/static/img/favicon.ico'), name='favicon'),
] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
