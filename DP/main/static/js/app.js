const { createApp } = Vue;

const app = createApp({
    // Сменяме скобите на Vue, за да не пречат на Django шаблоните
    delimiters: ['[[', ']]'],
    data() {
        return {
            // По подразбиране отваряме Таблото
            currentTab: 'dashboard',

            // Данни
            cards: [],
            logs: [],

            // Статистики
            totalCards: 0,
            todayScans: 0,
            deniedAccess: 0,
            latestLogs: [],

            showAddCardForm: false, // Контролира видимостта на формата
            newCard: { uid: '', owner_name: '' }, // Данните за новата карта
            editingCard: null,  // За редактиране: ID на картата, която се редактира
            editedCard: { uid: '', owner_name: '', is_active: true },  // Данни за редактиране
   }
    },
    methods: {
        switchTab(tabName) {
            this.currentTab = tabName;
            this.fetchData(); // Опресняваме данните при всяка смяна
        },

        async fetchData() {
            this.fetchCards();
            this.fetchLogs();
        },

        async fetchCards() {
            try {
                const response = await axios.get('/api/cards/');
                this.cards = response.data;
                this.totalCards = this.cards.length;
            } catch (error) {
                console.error("Грешка при зареждане на картите:", error);
            }
        },

        async fetchLogs() {
            try {
                const response = await axios.get('/api/logs/');
                this.logs = response.data;

                // Взимаме само последните 5 събития за таблото
                this.latestLogs = this.logs.slice(0, 5);

                // Изчисляваме статистики за "днес"
                const today = new Date().toISOString().split('T')[0]; // Взимаме YYYY-MM-DD
                this.todayScans = this.logs.filter(log => log.timestamp.startsWith(today)).length;
                this.deniedAccess = this.logs.filter(log => log.event_type.includes('DENIED')).length;

            } catch (error) {
                console.error("Грешка при зареждане на логовете:", error);
            }
        },

        // Помощна функция за форматиране на датата
        formatDate(dateString) {
            const date = new Date(dateString);
            return date.toLocaleString('bg-BG');
        },

        // Метод за добавяне на нова карта
        async addCard() {
            try {
                const response = await axios.post('/api/cards/', this.newCard,
                    {headers: {
                            'X-CSRFToken': CSRF_TOKEN
                        }
                    });
                this.cards.push(response.data); // Добавяме новата карта локално
                this.newCard = { uid: '', owner_name: '' }; // Изчистваме полетата
                this.showAddCardForm = false; // Скриваме формата
                alert('Картата е добавена успешно!');
            } catch (error) {
                console.error("Грешка при добавяне на карта:", error);
                alert('Възникна грешка! Възможно е този UID вече да съществува в базата.');
            }
        },
        // Нов метод за стартиране на редактиране
        startEdit(card) {
            this.editingCard = card.id;
            this.editedCard = { ...card };  // Копираме данните за редактиране
        },

        // Метод за запазване на редактираната карта
        async saveEdit() {
            try {
                const response = await axios.patch(`/api/cards/${this.editingCard}/`, this.editedCard, {
                    headers: { 'X-CSRFToken': CSRF_TOKEN }
                });
                // Обновяваме локално
                const index = this.cards.findIndex(c => c.id === this.editingCard);
                if (index !== -1) {
                    this.cards[index] = response.data;
                }
                this.editingCard = null;  // Скриваме режима на редактиране
                alert('Картата е редактирана успешно!');
                this.fetchCards();  // Опресняваме
            } catch (error) {
                console.error("Грешка при редактиране:", error);
                alert('Възникна грешка при редактирането.');
            }
        },

        // Отмяна на редактиране
        cancelEdit() {
            this.editingCard = null;
        },

        // Метод за промяна на статуса (активна/блокирана)
        async toggleCardStatus(card) {
            try {
                const updatedStatus = !card.is_active;
                const response = await axios.patch(`/api/cards/${card.id}/`, {
                    is_active: updatedStatus
                }, {
                    headers: { 'X-CSRFToken': CSRF_TOKEN }
                });
                card.is_active = response.data.is_active; // Обновяваме статуса локално
            } catch (error) {
                console.error("Грешка при промяна на статуса:", error);
                alert('Неуспешна промяна на статуса.');
            }
        },

        // (Опционално) Метод за изтриване на карта
        async deleteCard(cardId) {
            if(confirm('Сигурни ли сте, че искате да изтриете тази карта?')) {
                try {
                    await axios.delete(`/api/cards/${cardId}/`, {
                    headers: { 'X-CSRFToken': CSRF_TOKEN }
                });
                    this.cards = this.cards.filter(c => c.id !== cardId); // Премахваме от списъка
                } catch (error) {
                    console.error("Грешка при изтриване:", error);
                }
            }
        }
    },
    mounted() {
        // При първоначално зареждане дърпаме всичко
        this.fetchData();

        // Опресняваме данните автоматично на всеки 5 секунди
        setInterval(() => {
            this.fetchData();
        }, 5000);
    }
});

app.mount('#app');