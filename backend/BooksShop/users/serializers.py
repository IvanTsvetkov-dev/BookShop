from users.models import CustomUser
from rest_framework import serializers

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomUser
        fields = ['first_name', 'last_name', 'phone', 'email', 'password']
    def create(self, validated_data):
        validated_data['username'] = validated_data['email']
        user = CustomUser(**validated_data)
        user.set_password(validated_data['password'])  # Храним пароль в зашифрованном виде
        user.save()
        return user