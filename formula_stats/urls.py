from django.conf.urls import url
from . import views
from django.conf import settings
from django.conf.urls.static import static
from django.views.generic import RedirectView

urlpatterns = [
    url(r'^$', views.home, name='home'),
    url(r'^favicon\.ico$', RedirectView.as_view(url='/static/img/favicon.ico'), name='favicon'),
] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
