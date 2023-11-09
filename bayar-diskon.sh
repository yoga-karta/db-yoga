#!/bin/bash

# Meminta input dari pengguna
read -p "Masukkan jumlah teman: " jumlah_teman

# Inisialisasi total pembayaran sebelum diskon
total_pembayaran=0

# Inisialisasi variabel untuk menyimpan nama dan jumlah pembayaran teman
declare -A teman_pembayaran

# Meminta input nama dan pembayaran untuk setiap teman
for ((i=1; i<=$jumlah_teman; i++))
do
    read -p "Masukkan nama teman ke-$i: " nama
    read -p "Masukkan total pembayaran untuk $nama: " pembayaran

    # Menambahkan total pembayaran teman ke total_pembayaran
    total_pembayaran=$(echo "scale=2; $total_pembayaran + $pembayaran" | bc)

    # Menyimpan nama teman dan jumlah pembayarannya
    teman_pembayaran["$nama"]=$pembayaran
done

# Meminta input diskon
read -p "Masukkan persentase diskon (dalam persen): " diskon

# Menghitung total pembayaran setelah diskon
diskon_amount=$(echo "scale=2; $total_pembayaran * $diskon / 100" | bc)
total_setelah_diskon=$(echo "scale=2; $total_pembayaran - $diskon_amount" | bc)

# Mengirim hasil pembayaran ke bot Telegram
TELEGRAM_BOT_TOKEN="6269039385:AAFG8_BkyqVHKTIsq6qLgY1WeBMF_96z8xo"
TELEGRAM_CHAT_ID="-4029276804"

# Mengirim pesan ke bot Telegram dengan teks tebal (bold)
curl -s -X POST https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage -d chat_id=$TELEGRAM_CHAT_ID -d parse_mode=Markdown -d text="*Total jumlah bayar:* **Rp $total_pembayaran**"

format_diskon_amount=$(printf "Rp %'.2f" $diskon_amount)
curl -s -X POST https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage -d chat_id=$TELEGRAM_CHAT_ID -d text="*Total diskon:* **$format_diskon_amount**"

# Mengirim rincian pembayaran setiap orang ke bot Telegram dengan teks tebal (bold)
for nama in "${!teman_pembayaran[@]}"
do
    pembayaran_teman=$(echo "scale=2; ${teman_pembayaran[$nama]} - (${teman_pembayaran[$nama]} * $diskon / 100)" | bc)
    format_pembayaran_teman=$(printf "Rp %'.2f" $pembayaran_teman)
    curl -s -X POST https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage -d chat_id=$TELEGRAM_CHAT_ID -d parse_mode=Markdown -d text="*Untuk $nama harus bayar:* **$format_pembayaran_teman**"
done

# Mengirim pesan terakhir dengan teks tebal dan font mencolok (bold and underlined)
curl -s -X POST https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage -d chat_id=$TELEGRAM_CHAT_ID -d parse_mode=Markdown -d text="**_Selamat Menikmati! Awas jangan sampai tersedak!_**"
