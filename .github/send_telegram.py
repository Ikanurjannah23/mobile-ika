import os
import requests
from datetime import datetime

def send_telegram_message(token, chat_id, file_path, message):
    url = f"https://api.telegram.org/bot{token}/sendDocument"
    with open(file_path, 'rb') as file:
        files = {'document': file}
        data = {'chat_id': chat_id, 'caption': message}
        response = requests.post(url, files=files, data=data)
    return response.json()

def main():
    telegram_token = os.getenv('TELEGRAM_BOT_TOKEN')
    chat_id = os.getenv('TELEGRAM_CHAT_ID')
    version_name = os.getenv('VERSION_NAME')
    repository = os.getenv('GITHUB_REPOSITORY')
    commit_sha = os.getenv('GITHUB_SHA')
    commit_message = os.getenv('COMMIT_MESSAGE', 'No commit message available')
    commit_date = datetime.now().strftime('%Y-%m-%d %H:%M:%S')

    file_path = f'build/app/outputs/flutter-apk/app-release-{version_name}.apk'

    if not os.path.isfile(file_path):
        print(f"Error: APK file not found at {file_path}")
        exit(1)

    message = (
        f"Repository: {repository}\n"
        f"Commit: {commit_sha}\n"
        f"Message: {commit_message}\n"
        f"Date: {commit_date}\n"
        f"Version: {version_name}"
    )

    print("Sending message to Telegram...")
    result = send_telegram_message(telegram_token, chat_id, file_path, message)

    if result.get("ok"):
        print("Message sent successfully!")
    else:
        print("Failed to send message:", result)

if __name__ == "__main__":
    main()
