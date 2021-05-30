from django.urls import path
from .import views



urlpatterns = [
    # Leave as empty string for base url
    path('', views.store, name="store"),
    path('cart/', views.cart, name="cart"),
    path('checkout/', views.checkout, name="checkout"),
    path('login/', views.login, name="login"),
    path('signUp/', views.signUp, name="signUp"),
    path('logout/',views.logoutUser, name="logout" ),

    path('update_item/', views.updateItem, name="update_item"),
    path('processOrder/', views.processOrder, name="processOrder"),


]
