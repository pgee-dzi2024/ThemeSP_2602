import serial
import time
import requests
import configparser
import sys
import os


def load_config():
    """Чете конфигурацията от config.ini файла."""
    config = configparser.ConfigParser()
    config_file = 'config.ini'

    if not os.path.exists(config_file):
        print(f"ГРЕШКА: Файлът {config_file} не е намерен!")
        print("Моля, създай го в същата директория със съответните настройки.")
        sys.exit(1)

    config.read(config_file)

    try:
        # Извличане на настройките за Arduino
        serial_port = config['Arduino']['Port']
        baud_rate = config['Arduino'].getint('BaudRate')

        # Извличане на настройките за API
        api_host = config['API']['Host']
        api_port = config['API']['Port']
        api_endpoint = config['API']['Endpoint']

        # Сглобяване на пълния URL адрес
        # Напр: http://127.0.0.1:8000/api/scan/
        api_url = f"http://{api_host}:{api_port}{api_endpoint}"

        return serial_port, baud_rate, api_url

    except KeyError as e:
        print(f"ГРЕШКА: Липсва ключ в config.ini: {e}")
        sys.exit(1)
    except ValueError as e:
        print(f"ГРЕШКА: Невалидна стойност в config.ini: {e}")
        sys.exit(1)


def send_to_django(uid, api_url):
    """Изпраща прочетения UID към Django API-то."""
    payload = {'uid': uid}

    try:
        response = requests.post(api_url, data=payload)

        if response.status_code == 200:
            print(f"  -> Сървър: {response.json().get('message')} (ЗЕЛЕН СВЕТОФАР)")
        elif response.status_code == 403:
            print(f"  -> Сървър: {response.json().get('message')} (ЧЕРВЕН СВЕТОФАР - Блокирана)")
        elif response.status_code == 404:
            print(f"  -> Сървър: {response.json().get('message')} (ЧЕРВЕН СВЕТОФАР - Непозната)")
        else:
            print(f"  -> Неочаквана грешка от сървъра: {response.status_code}")

    except requests.exceptions.ConnectionError:
        print(f"  -> ГРЕШКА: Не мога да се свържа с {api_url}! Работи ли сървърът?")


def main():
    # 1. Зареждане на конфигурацията
    serial_port, baud_rate, api_url = load_config()

    print(f"--- НАСТРОЙКИ ЗАРЕДЕНИ УСПЕШНО ---")
    print(f"Arduino Порт : {serial_port} ({baud_rate} baud)")
    print(f"Django API   : {api_url}")
    print(f"----------------------------------")
    print("Опит за свързване с четеца...\n")

    try:
        # 2. Отваряне на серийната връзка
        ser = serial.Serial(serial_port, baud_rate, timeout=1)
        time.sleep(2)  # Изчакване за рестарт на платката
        print("Връзката е успешна! Очаквам сканиране на карти...\n")

        while True:
            if ser.in_waiting > 0:
                line = ser.readline().decode('utf-8').strip()

                if line.startswith("UID:"):
                    uid = line.replace("UID:", "").strip()
                    print(f"\n[!] Прочетена карта: {uid}")

                    # Изпращаме данните и подаваме сглобения URL
                    send_to_django(uid, api_url)

    except serial.SerialException as e:
        print(f"ГРЕШКА със серийния порт: {e}")
        print(f"Увери се, че портът {serial_port} е правилен и свободен (затвори Serial Monitor-а).")
    except KeyboardInterrupt:
        print("\nСкриптът е спрян ръчно.")
    finally:
        if 'ser' in locals() and ser.is_open:
            ser.close()


if __name__ == '__main__':
    main()