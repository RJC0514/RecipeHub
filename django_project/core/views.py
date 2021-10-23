from django.shortcuts import render
from django.http import JsonResponse

from django.db.models import Count, Q, Value
from django.db.models.functions import Concat

from .models import *


def home(request):
	return render(request, 'home.html')


def about(request):
	return render(request, 'about.html')


def get_recipes(request):

	ingredients = Ingredient.objects.filter(
		name__in=request.GET.get('ingredients').split('_')
	)

	recipe_ids = RecipeIngredients.objects.filter(
		ingredient_id__in=ingredients
	).annotate(
		icount=Count('ingredient')
	).filter(
		icount__gte=1
	).order_by('icount').values_list('recipe', flat=True)

	recipes = list(
		Recipe.objects.filter(id__in=recipe_ids).values()
	)

	for r in recipes:
		r['ingredients'] = list(
			RecipeIngredients.objects.filter(
				recipe=r['id']
			).values_list(
				'measurement', flat=True
			)
		)

	return JsonResponse(list(recipes), safe=False)


def search_recipes(request):

	query = Q()
	if name := request.GET.get('name'):
		for word in name.split(' '):
			query &= Q(name__icontains=word)

	recipes = list(
		Recipe.objects.filter(query).values()
	)

	for r in recipes:
		r['ingredients'] = list(
			RecipeIngredients.objects.filter(
				recipe=r['id']
			).values_list('measurement', flat=True)
		)

	return JsonResponse(
		list(recipes),
		safe=False
	)
