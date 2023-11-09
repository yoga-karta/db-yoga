#!/bin/bash

# Token bot Telegram Anda
TOKEN="6269039385:AAFG8_BkyqVHKTIsq6qLgY1WeBMF_96z8xo"

# User ID pengguna yang akan di-mention
USER_ID_TO_MENTION="yogayogad"

# ID grup di mana bot akan mengirimkan pesan
GROUP_ID="-1001617318616"

# Pesan yang ingin dikirimkan
MESSAGE="Selamat malam ndan @$USER_ID_TO_MENTION, semoga semangat dan sehat selalu..!!"

# Kirim pesan ke grup dengan mention ke pengguna yang ditentukan
curl -s -X POST "https://api.telegram.org/bot$TOKEN/sendMessage" -d "chat_id=$GROUP_ID&text=$MESSAGE&parse_mode=Markdown&disable_web_page_preview=true" -d "entities=[{'type':'mention', 'offset':25, 'length':${#USER_ID_TO_MENTION}}]"
