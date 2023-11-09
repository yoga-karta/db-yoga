#!/bin/bash

# Nama file yang berisi daftar domain
file="domains.txt"

# Token API Telegram bot
telegram_bot_token="6660111588:AAF9vVIbm2tNCW_MJlJnMNXfs6BjbNWu7vM"

# ID grup Telegram tempat Anda ingin mengirimkan pesan
telegram_chat_id="-4029276804"

# Periksa apakah file ada
if [ ! -f "$file" ]; then
  echo "File $file tidak ditemukan."
  exit 1
fi

# Baca setiap baris dalam file dan periksa SSL untuk setiap domain
while IFS= read -r domain || [[ -n "$domain" ]]; do
  # Menangani spasi di awal atau akhir baris (trim)
  domain=$(echo "$domain" | xargs)
  
  # Periksa apakah domain kosong setelah trim
  if [ -n "$domain" ]; then
    echo "Checking SSL for domain: $domain"
    expiration_date=$(openssl s_client -connect "${domain}:443" -servername "${domain}" < /dev/null 2>/dev/null | openssl x509 -noout -dates 2>/dev/null | grep "notAfter" | cut -d'=' -f 2)

    if [ -n "$expiration_date" ]; then
      echo "Certificate expires on: $expiration_date"
      message="SSL certificate for $domain expires on: $expiration_date"
    else
      echo "Error: Unable to retrieve SSL certificate information for $domain"
      message="Error: Unable to retrieve SSL certificate information for $domain"
    fi

    # Mengirim pesan ke bot Telegram
    curl -s -X POST "https://api.telegram.org/bot$telegram_bot_token/sendMessage" \
      -d "chat_id=$telegram_chat_id" \
      -d "text=$message"

    echo "============================"
  fi
done < "$file"
