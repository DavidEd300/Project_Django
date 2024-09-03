from django import forms
from django.contrib.auth.models import User
from django.contrib.auth.forms import UserCreationForm, PasswordChangeForm
from django.contrib.auth.password_validation import validate_password
from django.core.exceptions import ValidationError
from django.contrib.auth.hashers import make_password



from django.contrib.auth.forms import PasswordChangeForm


class CustomUserCreationForm(forms.ModelForm):
    password = forms.CharField(label='form-senha', widget=forms.PasswordInput)
    confirm_password = forms.CharField(label='confirm-password',widget=forms.PasswordInput)
    email = forms.EmailField(required=True)
    is_superuser = forms.BooleanField(required=False, label='É Superusuário?')

    class Meta:
        model = User
        fields = ('username', 'email', 'password', 'confirm_password','is_superuser')

    def clean_confirm_password(self):
        password = self.cleaned_data.get('password')
        confirm_password = self.cleaned_data.get('confirm_password')
        
        if password and confirm_password and password != confirm_password:
            raise forms.ValidationError("As senhas não coincidem")
            
        return confirm_password

    def save(self, commit=True):
        user = super().save(commit=False)
        user.email = self.cleaned_data['email']
        user.password = make_password(self.cleaned_data['password'])
        if self.cleaned_data.get('is_superuser'):
            user.is_superuser = True
            user.is_staff = True  # Necessário para superusuários
        if commit:
            user.save()
        return user


class EditUserForm(forms.ModelForm):
    class Meta:
        model = User
        fields = ['username', 'email']

    def __init__(self, *args, **kwargs):
        super(EditUserForm, self).__init__(*args, **kwargs)
        self.fields['username'].widget.attrs.update({'placeholder': 'Novo nome de usuário'})
        self.fields['email'].widget.attrs.update({'placeholder': 'Novo email'})
        self.fields['username'].widget.attrs.update({'class': 'form-control'})
        self.fields['email'].widget.attrs.update({'class': 'form-control'})

class CustomPasswordChangeForm(PasswordChangeForm):
    def __init__(self, *args, **kwargs):
        super(CustomPasswordChangeForm, self).__init__(*args, **kwargs)
        self.fields['old_password'].widget.attrs.update({'placeholder': 'Senha atual', 'class': 'form-control'})
        self.fields['new_password1'].widget.attrs.update({'placeholder': 'Nova senha', 'class': 'form-control'})
        self.fields['new_password2'].widget.attrs.update({'placeholder': 'Confirme a nova senha', 'class': 'form-control'})