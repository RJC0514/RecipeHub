import json

from django.core.management.base import BaseCommand
from core.models import *   

nam = 'Chef John\'s Chicken Spaghetti'
url = "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fi.pinimg.com%2Foriginals%2Fd1%2F7a%2F6a%2Fd17a6ab748ae5c14f9f7c400773b85b2.jpg&f=1&nofb=1"
ing = '''spaghetti - 1 (4.5 pound) whole chicken
tomato sauce - 1 (24 ounce) jar tomato sauce
water - 6 cups water
anchovy - 2 anchovy fillets
red pepper flakes - 1/2 teaspoon red pepper flakes, or to taste
salt - 2 teaspoons salt, plus more to taste
spaghetti - 1 (16 ounce) package spaghetti
basil - 1/4 cup thinly sliced basil leaves
Pecorino Romano cheese - 1/2 cup grated Pecorino Romano cheese
butter - 1 tablespoon cold butter (Optional)
Pecorino Romano cheese - 1 tablespoon grated Pecorino Romano cheese '''
ins = '''Place chicken in a pot and pour marinara sauce on top. Add water and anchovies. Bring to a simmer, uncovered, over high heat. Reduce heat to medium-low. Cover and simmer, without stirring, for 1 hour and 15 minutes.
Transfer chicken to a bowl using tongs. Let cool to the touch.
Meanwhile, bring sauce to a simmer over medium-high heat. Cook, skimming off the fat from the surface, until sauce is reduced by at least half, 20 to 35 minutes.
Tear off chicken meat by hand and transfer to a bowl, breaking the pieces into your desired size.
Add the chicken, red pepper flakes, and salt to the reduced sauce. Cook and stir until chicken is heated through, about 2 minutes. Keep on low heat while you cook the pasta.
Bring a large pot of lightly salted water to a boil. Cook spaghetti in the boiling water according to package instructions, reducing time by 1 minute, about 11 minutes. Drain and return to the pot; reduce heat to low.
Add the chicken sauce and Pecorino Romano to the pasta. Sprinkle in basil and add butter. Stir until butter melts, about 1 minute. Turn off the heat and add remaining Pecorino Romano cheese. Cover and let sit for 1 minute. Stir and serve.

Credit: AllRecipes
'''

class Command(BaseCommand):
    def handle(self, *args, **options):
        r = Recipe(name = nam, image_url = url, instructions = ins)
        r.save()

        for x in ing.split('\n'):
            ingName, amount = x.title().split(' - ')
            if not Ingredient.objects.filter(name = ingName).exists():
                Ingredient(name = ingName).save()
            
            i = Ingredient.objects.get(name = ingName)
            RecipeIngredients(ingredient = i, recipe = r, measurement = amount).save()

        r.save()
