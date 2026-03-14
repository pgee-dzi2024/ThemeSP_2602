from rest_framework import viewsets, status
from rest_framework.views import APIView
from rest_framework.response import Response
from .models import Card, AccessLog
from .serializers import CardSerializer, AccessLogSerializer

from django.shortcuts import render


# 1. Изгледи за фронтенда (Vue.js)
class CardViewSet(viewsets.ModelViewSet):
    queryset = Card.objects.all()
    serializer_class = CardSerializer


class AccessLogViewSet(viewsets.ReadOnlyModelViewSet):
    # Логовете само се четат, не се трият или редактират от потребителя
    queryset = AccessLog.objects.all()
    serializer_class = AccessLogSerializer


# 2. Изглед за хардуера (Python скрипта, свързан с Arduino)
class ScanCardView(APIView):
    def post(self, request):
        uid = request.data.get('uid')

        if not uid:
            return Response({"error": "Липсва UID"}, status=status.HTTP_400_BAD_REQUEST)

        # Почистваме евентуални излишни интервали
        uid = uid.strip()

        try:
            # Търсим картата в базата
            card = Card.objects.get(uid=uid)

            if card.is_active:
                event = 'GRANTED'
                message = "Достъпът е разрешен"
                status_code = status.HTTP_200_OK
            else:
                event = 'DENIED_INACTIVE'
                message = "Отказан достъп: Картата е блокирана"
                status_code = status.HTTP_403_FORBIDDEN

            # Записваме в лога
            AccessLog.objects.create(card=card, event_type=event)

        except Card.DoesNotExist:
            # Картата не съществува в базата
            event = 'DENIED_UNKNOWN'
            message = "Отказан достъп: Непозната карта"
            status_code = status.HTTP_404_NOT_FOUND

            # Записваме опита на непознатата карта
            AccessLog.objects.create(unknown_uid=uid, event_type=event)

        return Response({"status": event, "message": message}, status=status_code)

# **************************************************
#    потребителски интерфейс
# **************************************************

def login(request):
    return render(request, 'main/login.html')

def dashboard(request):
    return render(request, 'main/dashboard.html')
