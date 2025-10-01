import os

from django.core.asgi import get_asgi_application

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "devops_with_djagno.settings")

application = get_asgi_application()
