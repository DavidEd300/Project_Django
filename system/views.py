from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login
from .forms import CustomUserCreationForm
from django.contrib.auth.models import User
from django.contrib.auth.decorators import login_required
from django.contrib.auth import logout
from django.contrib import messages

def login_view(request):
    if request.method == 'POST':
        username = request.POST['username']
        password = request.POST['password']

        user = authenticate(request=request, username=username, password=password)

        if user is not None:
            login(request, user)
            # Redirect to the home page or other relevant page
            return redirect('home')
        else:
            # Display an error message
            error_message = 'Usuário ou senha inválidos.'
            context = {
                'error_message': error_message,
            }
            return render(request, 'login.html', context)

    context = {
        'title': 'Tela de Login',
        'login_title': 'Bem-vindo',
    }
    return render(request, 'login.html', context)


def signup_view(request):
    if request.method == 'POST':
        form = CustomUserCreationForm(request.POST)
        if form.is_valid():
            print("Formulário válido") 
            
            user = form.save()
            login(request, user)
            return redirect('home')



        else:
            print("Formulário inválido") 
            print(form.errors)
            error_message = form.errors

        context = {
            'title': 'Tela de Cadastro',
            'register_title': 'Criar Conta',
            'register_button_text': 'Cadastrar',
            'error_message': error_message,
            'form': form,
        }
        return render(request, 'signup.html', context)

    context = {
        'title': 'Tela de Cadastro',
        'register_title': 'Criar Conta',
        'register_button_text': 'Cadastrar',
        'form': CustomUserCreationForm(),
    }
    return render(request, 'signup.html', context)

@login_required
def home_view(request):
    context = {
        'title': 'Página Inicial',
        'welcome_message': f'Bem-vindo, {request.user.username}!',
    }
    return render(request, 'home.html', context)

def logout_view(request):
    logout(request)
    messages.info(request, 'Você foi desconectado.')
    return redirect('login')