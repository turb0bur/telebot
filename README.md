# Telebot
My first GoLang based [Telegram bot](http://t.me/turb0bur_bot)

Before using please add `TELE_TOKEN` to the .env


Example of build with setting custom version
```bash
go build -ldflags "-X=github.com/turb0bur/telebot/cmd.appVersion=v1.0.0"
```