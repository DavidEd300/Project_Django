from django.urls import path
from .views import login_view, signup_view, home_view, logout_view, edit_user_view

urlpatterns = [
    path('login/', login_view, name='login'),
    path('signup/', signup_view, name='signup'),
    path('home/', home_view, name='home'),
    path('logout/', logout_view, name='logout'),
    path('edit_user/', edit_user_view, name='edit_user'),
    path('', login_view, name='login'), 
]
