from django.urls import path

from . import views


urlpatterns = [
	path('', views.home, name='home'),
	path('about/', views.about, name='about'),

	path('api/get_recipes/', views.get_recipes, name='get_recipes'),
	path('api/search_recipes/', views.search_recipes, name='search_recipes'),
]
