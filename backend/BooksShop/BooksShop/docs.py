from django.urls import path
from drf_yasg.views import get_schema_view
from drf_yasg import openapi
from rest_framework.permissions import *

schema_view = get_schema_view(
   openapi.Info(
      title="Books API",
      default_version='v1',
      description="Test description",
   ),
   public=True,
   permission_classes=[AllowAny],
)

docurl_patterns = [
    # re_path(
    #     r'^swagger(?P\.json|\.yaml)$',
    #     schema_view.without_ui(cache_timeout=0),
    #     name='schema-json'
    # ),
    # path(
    #     'redoc/',
    #     schema_view.with_ui('redoc', cache_timeout=0),
    #     name='schema-redoc'
    # ),
    path('',schema_view.with_ui('swagger', cache_timeout=0), name='schema-swagger-ui'),
]
