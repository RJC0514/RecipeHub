from django.core.management.base import BaseCommand
from core.models import *

name = 'Peanut Butter Bars'
url = 'https://www.iheartnaptime.net/wp-content/uploads/2013/02/No-bake-peanut-butter-bars.jpg'
ingredients = '''1 cup - butter
1 cup - peanut butter
1 3/4 cups - powdered sugar 
2 cups - Graham Crackers
1 1/2 cups - chocolate chips'''
instructions = '''If you’re looking for a super simple no bake dessert then look no further than these super chocolatey peanut butter bars! Not only are they made with quite possibly the best food combo ever (hello peanut butter and chocolate) but they are super quick and easy to make and taste just like your favorite peanut butter cups. Yes, they are that good!

Line a 8x8 or 9x9 dish with parchment paper or foil.

Crush graham crackers in a ziploc bag using a rolling pin or blitz using a food processor.

Melt butter in a large bowl add peanut butter and mix until smooth.

Beat in powdered sugar then fold in the crumbs. Transfer to lined dish and smooth.

Melt chocolate and peanut butter, pour over the peanut butter base, smooth then chill for at least 90 minutes.
Cut into bars and enjoy.

Credit: Preppy Kitchen'''


class Command(BaseCommand):
	def handle(self, *args, **options):
		r = Recipe(name=name, image_url=url, instructions=instructions)
		r.save()

		for ing in ingredients.split('\n'):
			amount, ing_name = ing.title().split(' - ')

			i, _ = Ingredient.objects.get_or_create(name=ing_name)

			RecipeIngredients(ingredient=i, recipe=r, measurement=f'{amount} {ing_name}').save()

		r.save()
