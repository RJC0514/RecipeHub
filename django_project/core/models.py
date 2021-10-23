from django.db import models

class Ingredient(models.Model):
    name = models.CharField(max_length=25)

class Recipe(models.Model):
    ingredients = models.ManyToManyField(Ingredient, through='RecipeIngredients')
    instructions = models.TextField()

class RecipeIngredients(models.Model):
    ingredient = models.ForeignKey(Ingredient, on_delete=models.CASCADE)
    recipe = models.ForeignKey(Recipe, on_delete=models.CASCADE)
