from django.urls import path
from api.router import CustomRouter
from rest_framework.routers import SimpleRouter
from api.views import *
from rest_framework_simplejwt.views import (
    TokenObtainPairView,
    TokenRefreshView,
)

from api import views
from users.views import CustomUserCreate


router = SimpleRouter()
router.register(r'api/v1/book', BookViewSet)
router_custom = CustomRouter()
router_custom.register(r'api/v1/basket', BasketViewSet, basename='basket')


api_patterns = [
    path('api/v1/create_user/', CustomUserCreate.as_view()),
    
    path('api/v1/random_quote/', views.RandomQuote.as_view()),
    
    path('auth/jwt/create/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    
    path('auth/jwt/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
    
]
api_patterns += router.urls
api_patterns += router_custom.urls