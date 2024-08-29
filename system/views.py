from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth import authenticate, login, logout, update_session_auth_hash
from .forms import CustomUserCreationForm
from django.contrib.auth.models import User
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from .forms import EditUserForm, CustomPasswordChangeForm



def login_view(request):
    if request.method == 'POST':
        username = request.POST['username']
        password = request.POST['password']

        user = authenticate(request, username=username, password=password)

        if user is not None:
            login(request, user)
            return redirect('home')
        else:
            # Verifica se o usuário já está cadastrado
            if not User.objects.filter(username=username).exists():
                messages.error(request, 'Usuário não cadastrado.')
            else:
                messages.error(request, 'Senha inválida.')
            
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

            return redirect('login')
        else:
            print("Formulário inválido") 
            print(form.errors)
            error_message = form.errors
            messages.info(request, 'As senhas não são iguais.')

        context = {
            'title': 'Tela de Cadastro',
            'register_title': 'Criar Conta',
            'register_button_text': 'Cadastrar',
            'error_message': error_message,
            'form': CustomUserCreationForm(),
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
    all_users = User.objects.all()
    context = {
        'title': 'Página Inicial',
        'welcome_message': f'Bem-vindo, {request.user.username}!',
        'all_users': all_users,
    }
    return render(request, 'home.html', context)

def logout_view(request):
    logout(request)
    messages.info(request, 'Você foi desconectado.')
    return redirect('login')

@login_required
def edit_user_view(request):
    if request.method == 'POST':
        user_form = EditUserForm(request.POST, instance=request.user)
        password_form = CustomPasswordChangeForm(user=request.user, data=request.POST)

        if user_form.is_valid() and password_form.is_valid():
            user_form.save()
            password_form.save()
            update_session_auth_hash(request, password_form.user)  # Mantém o usuário logado após mudar a senha
            messages.success(request, 'Seus dados foram atualizados com sucesso!')
            return redirect('home')
        else:
            messages.error(request, 'Por favor, corrija os erros abaixo.')

    else:
        user_form = EditUserForm(instance=request.user)
        password_form = CustomPasswordChangeForm(user=request.user)

    context = {
        'user_form': user_form,
        'password_form': password_form,
    }
    return render(request, 'edit_user.html', context)

@login_required
def delete_user_view(request, user_id):
    user = get_object_or_404(User, id=user_id)

    if request.user == user or request.user.is_superuser:
        print(f"Deletando usuário: {user.username}")
        user.delete()
        messages.success(request, 'Usuário deletado com sucesso.')
    else:
        print(f"Permissão negada para deletar: {user.username}")
        messages.error(request, 'Você não tem permissão para deletar este usuário.')
    
    return redirect('home')