from rest_framework import serializers
from .models import Card, AccessLog

class CardSerializer(serializers.ModelSerializer):
    class Meta:
        model = Card
        fields = '__all__'

class AccessLogSerializer(serializers.ModelSerializer):
    # Добавяме информация за картата, за да е по-лесно на Vue.js фронтенда
    card_info = CardSerializer(source='card', read_only=True)

    class Meta:
        model = AccessLog
        fields = '__all__'