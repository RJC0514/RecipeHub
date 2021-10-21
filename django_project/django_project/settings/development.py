"""
The development settings file is meant to be used in development.
"""

from .base import *

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = '#*slf)^iu3qnvn!@6^2=zl11i_z=1x+5aj7b0&xi1w)f2g7#*o'

ALLOWED_HOSTS = ['localhost', '127.0.0.1']

# Custom setting, used in core.utils.full_reverse()
# Technically, I guess this is an origin because of the scheme and port
DEFAULT_HOST = 'http://localhost:8000'

# Database https://docs.djangoproject.com/en/3.2/ref/settings/#databases
DATABASES = {
	'default': {
		'ENGINE': 'django.db.backends.sqlite3',
		'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
	}
}
