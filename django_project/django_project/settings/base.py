"""
The base settings file is meant to be imported by the dev/prod settings files.
"""

import os

# Not an actual setting, only used to build paths eg os.path.join(BASE_DIR, ...)
BASE_DIR = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

# Application definition
INSTALLED_APPS = [
	# stackoverflow.com/a/34214067
	'core.apps.CoreConfig',

	'crispy_forms',

	'django.contrib.admin',
	'django.contrib.auth',
	'django.contrib.contenttypes',
	'django.contrib.sessions',
	'django.contrib.messages',
	'django.contrib.staticfiles'
]

MIDDLEWARE = [
	'django.middleware.security.SecurityMiddleware',
	'django.contrib.sessions.middleware.SessionMiddleware',
	'django.middleware.common.CommonMiddleware',
	'django.middleware.csrf.CsrfViewMiddleware',
	'django.contrib.auth.middleware.AuthenticationMiddleware',
	'django.contrib.messages.middleware.MessageMiddleware',
	'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

ROOT_URLCONF = 'django_project.urls'

TEMPLATES = [{
	'BACKEND': 'django.template.backends.django.DjangoTemplates',
	'DIRS': [],
	'APP_DIRS': True,
	'OPTIONS': {
		'context_processors': [
			'django.template.context_processors.debug',
			'django.template.context_processors.request',
			'django.contrib.auth.context_processors.auth',
			'django.contrib.messages.context_processors.messages',
		]
	},
}]

WSGI_APPLICATION = 'django_project.wsgi.application'

# Password validation
# https://docs.djangoproject.com/en/3.2/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
	{'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator'},
	{'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator'},
	{'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator'},
	{'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator'},
]

DEFAULT_AUTO_FIELD = 'django.db.models.AutoField'

# Internationalization
# https://docs.djangoproject.com/en/3.2/topics/i18n/

LANGUAGE_CODE = 'en-us'
TIME_ZONE = 'UTC'
USE_I18N = True
USE_L10N = True
USE_TZ = True

# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/3.2/howto/static-files/

# Where collectstatic files are placed
STATIC_ROOT = os.path.join(BASE_DIR, 'static')
# URL that static files are served from
STATIC_URL = '/static/'

CRISPY_TEMPLATE_PACK = 'bootstrap4'
