from django.urls import path, include

from book import views


urlpatterns_api= [
    path('list/', views.BooksList.as_view()), #get book list
    
    path('<int:id>/', views.BookDetail.as_view()), #get book
]