import os
import requests
from datetime import datetime

def send_telegram_message(token, chat_id, file_path, message):
    url = f"https://api.telegram.org/bot{token}/sendDocument"
    with open(file_path, 'rb') as doc:
        files = {'document': doc}
        data = {'chat_id': chat_id, 'caption': message}
        response = requests.post(url, files=files, data=data)
        print("✅ Telegram response:", response.text)  # Tambahkan debug
        return response.json()

# Ambil environment variable
telegram_token = os.getenv('TELEGRAM_BOT_TOKEN')
chat_id = os.getenv('TELEGRAM_CHAT_ID')
version_name = os.getenv('VERSION_NAME')

file_path = f'build/app/outputs/flutter-apk/app-release-{version_name}.apk'

# Validasi input penting
if not telegram_token or not chat_id or not version_name:
    print("❌ Missing environment variables.")
    exit(1)

if not os.path.exists(file_path):
    print(f"❌ File not found: {file_path}")
    exit(1)

# Informasi build
repository = os.getenv('GITHUB_REPOSITORY')
commit_sha = os.getenv('GITHUB_SHA')
commit_message = os.getenv('GITHUB_COMMIT_MESSAGE', '(no message)')
commit_date = datetime.now().strftime('%Y-%m-%d %H:%M:%S')

message = (
    f"📦 *APK Build Notification*\n\n"
    f"🧩 Repository: `{repository}`\n"
    f"🔖 Commit: `{commit_sha[:7] if commit_sha else 'unknown'}`\n"
    f"📝 Message: {commit_message}\n"
    f"📅 Date: {commit_date}\n"
    f"🏷️ Version: `{version_name}`"
)

send_telegram_message(telegram_token, chat_id, file_path, message)
