from django import forms
from django.contrib.auth.hashers import make_password
from django.contrib.auth.models import User


class CustomUserCreationForm(forms.ModelForm):
    password = forms.CharField(label='form-senha', widget=forms.PasswordInput)
    confirm_password = forms.CharField(label='confirm-password',
                                       widget=forms.PasswordInput)
    email = forms.EmailField(required=True)

    class Meta:
        model = User
        fields = ('username', 'email', 'password', 'confirm_password')

    def clean_confirm_password(self):
        password = self.cleaned_data.get('password')
        confirm_password = self.cleaned_data.get('confirm_password')
        
        if password and confirm_password and password != confirm_password:
            raise forms.ValidationError("As senhas não coincidem")
            
        return confirm_password

    def save(self, commit=True):
        print("Salvando usuário...")
        user = super().save(commit=False)
        user.email = self.cleaned_data['email']
        user.password = make_password(self.cleaned_data['password'])
        if commit:
            user.save()
        return user
