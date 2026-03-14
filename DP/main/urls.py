from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import *

router = DefaultRouter()
router.register(r'cards', CardViewSet)
router.register(r'logs', AccessLogViewSet)

urlpatterns = [
    # Стандартни API маршрути за Vue.js (/api/cards/ и /api/logs/)
    path('api/', include(router.urls)),

    # Специален маршрут за хардуерния мост (/api/scan/)
    path('api/scan/', ScanCardView.as_view(), name='scan_card'),

    # Маршрути за уеб интерфейса
    path('login', login, name='login'),
    path('dashboard', dashboard, name='dashboard'),
]