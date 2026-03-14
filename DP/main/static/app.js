const { createApp } = Vue;

const app = createApp({
    delimiters: ['[[', ']]'], // Указва на Vue да ползва тези скоби, за да не пречи на Django
    data() {
        return {
            // Контролира коя секция се вижда: 'dashboard', 'cards' или 'logs'
            currentTab: 'dashboard',

            // Данни от API-то
            cards: [],
            logs: [],

            // Статистики за таблото
            totalCards: 0,
            todayScans: 0
        }
    },
    methods: {
        // Метод за смяна на активната секция
        switchTab(tabName) {
            this.currentTab = tabName;

            // Зареждаме свежи данни според това кой таб отваряме
            if (tabName === 'cards') this.fetchCards();
            if (tabName === 'logs') this.fetchLogs();
            if (tabName === 'dashboard') {
                this.fetchCards();
                this.fetchLogs();
            }
        },

        // Взимане на картите от бекенда
        async fetchCards() {
            try {
                const response = await axios.get('/api/cards/');
                this.cards = response.data;
                this.totalCards = this.cards.length;
            } catch (error) {
                console.error("Грешка при зареждане на картите:", error);
            }
        },

        // Взимане на логовете от бекенда
        async fetchLogs() {
            try {
                const response = await axios.get('/api/logs/');
                this.logs = response.data;
                // Тук може да филтрираш само днешните за статистиката todayScans
                this.todayScans = this.logs.length;
            } catch (error) {
                console.error("Грешка при зареждане на логовете:", error);
            }
        },

        // Метод за добавяне на нова карта
        async addCard() {
            try {
                // Предполагаме, че имаш обект newCard в data() { return { newCard: { uid: '', owner_name: '' } } }
                const response = await axios.post('/api/cards/', this.newCard);
                this.cards.push(response.data); // Добавяме новата карта директно в списъка
                this.newCard = { uid: '', owner_name: '' }; // Изчистваме формата
                alert('Картата е добавена успешно!');
            } catch (error) {
                console.error("Грешка при добавяне на карта:", error);
                alert('Възникна грешка при добавянето.');
            }
        },
        
        // Метод за промяна на статуса (активна/блокирана)
        async toggleCardStatus(card) {
            try {
                const updatedStatus = !card.is_active;
                const response = await axios.patch(`/api/cards/${card.id}/`, {
                    is_active: updatedStatus
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
                    await axios.delete(`/api/cards/${cardId}/`);
                    this.cards = this.cards.filter(c => c.id !== cardId); // Премахваме от списъка
                } catch (error) {
                    console.error("Грешка при изтриване:", error);
                }
            }
        }
    },
    mounted() {
        // Когато страницата се зареди, автоматично дърпаме данните за таблото
        this.fetchCards();
        this.fetchLogs();
    }
});

// Закачаме Vue приложението към елемент с id="app" в HTML-а
app.mount('#app');