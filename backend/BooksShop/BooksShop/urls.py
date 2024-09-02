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
from book import views
from rest_framework_simplejwt.views import (
    TokenObtainPairView,
    TokenRefreshView,
)
from book.urls import urlpatterns_api
from django.conf.urls.static import static
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
    
    path('book/', include(urlpatterns_api)),
    
    path('api/create_user/', views.CustomUserCreate.as_view()),
    
    path('api/basket/', views.BasketContent.as_view()),
    
    path('api/token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    
    path('api/token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
    
    path('api/random_quote/', views.RandomQuote.as_view()),
    
    path('admin/', admin.site.urls),
]
 
urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)