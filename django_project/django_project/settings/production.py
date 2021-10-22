"""
The production settings file is meant to be used in production. Some settings,
like SECRET_KEY and the database password, are not included for security
reasons. To specify them, see local_example.py for instructions.

Checklist:  https://docs.djangoproject.com/en/3.2/howto/deployment/checklist/
"""

from .base import *

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = False

ALLOWED_HOSTS = ['hackgt.rostersnipoer.com']

SESSION_COOKIE_SECURE = True
CSRF_COOKIE_SECURE = True

# Redirect all non-HTTPS requests to HTTPS
SECURE_SSL_REDIRECT = True
SECURE_PROXY_SSL_HEADER = ('HTTP_X_FORWARDED_PROTOCOL', 'https')

# Database https://docs.djangoproject.com/en/3.2/ref/settings/#databases
DATABASES = {
	'default': {
		'ENGINE': 'django.db.backends.postgresql_psycopg2',
		'NAME': 'hackgt',
		'USER': 'hackgt',
		'PASSWORD': '## this should be overridden in local.py ##',
		'HOST': 'localhost',
		'PORT': '5432'
	}
}
