from django.db import models

class Card(models.Model):
    # Уникален идентификатор, който четем от Arduino (напр. "de 05 c2 1b")
    uid = models.CharField(max_length=50, unique=True, verbose_name="UID на картата")
    # Име на притежателя (може да е празно, ако картата не е разпределена)
    owner_name = models.CharField(max_length=100, blank=True, null=True, verbose_name="Притежател")
    # Статус на картата (активна или блокирана)
    is_active = models.BooleanField(default=True, verbose_name="Активна")
    # Кога е регистрирана в системата
    created_at = models.DateTimeField(auto_now_add=True, verbose_name="Дата на регистрация")

    def __str__(self):
        return f"{self.uid} - {self.owner_name or 'Неизвестен'}"

    class Meta:
        verbose_name = "Карта"
        verbose_name_plural = "Карти"


class AccessLog(models.Model):
    EVENT_CHOICES = (
        ('GRANTED', 'Достъпът е разрешен'),
        ('DENIED_INACTIVE', 'Отказан достъп (Блокирана карта)'),
        ('DENIED_UNKNOWN', 'Отказан достъп (Непозната карта)'),
    )

    # Връзка към картата. Ако картата е непозната, може да е null
    card = models.ForeignKey(Card, on_delete=models.SET_NULL, null=True, blank=True, related_name='logs')
    # В случай на непозната карта, запазваме UID-то тук, за да знаем кой се е опитал да влезе
    unknown_uid = models.CharField(max_length=50, blank=True, null=True)
    # Точен час на чекиране
    timestamp = models.DateTimeField(auto_now_add=True, verbose_name="Време на събитието")
    # Тип на събитието
    event_type = models.CharField(max_length=20, choices=EVENT_CHOICES, verbose_name="Резултат")

    def __str__(self):
        uid_display = self.card.uid if self.card else self.unknown_uid
        return f"[{self.timestamp.strftime('%Y-%m-%d %H:%M')}] {uid_display} - {self.get_event_type_display()}"

    class Meta:
        verbose_name = "Лог на достъп"
        verbose_name_plural = "Логове на достъп"
        ordering = ['-timestamp'] # Най-новите записи да излизат първи
