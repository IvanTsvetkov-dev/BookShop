"""
URL configuration for BooksShop project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include, re_path
from users.views import *
from BooksShop import settings
from users.views import CustomUserCreate
from django.conf.urls.static import static
from drf_yasg.views import get_schema_view
from drf_yasg import openapi
from rest_framework.permissions import *
from rest_framework.routers import DefaultRouter, SimpleRouter
from api.urls import api_patterns


schema_view = get_schema_view(
   openapi.Info(
      title="Books API",
      default_version='v1',
      description="Test description",
   ),
   public=True,
   permission_classes=[AllowAny],
)

# router = SimpleRouter()
# router.register(r'book', BookViewSet)
# #router.register(r'auth', TokenObtainPairView, basename="auth")
# router_custom = CustomRouter()
# router_custom.register(r'basket', BasketViewSet, basename='basket')


urlpatterns = [
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
    
    path('', include(api_patterns)),
    
    # path('api/random_quote/', views.RandomQuote.as_view()),
    
    path('admin/', admin.site.urls),
]
# print(router.urls)
urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)