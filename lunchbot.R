#####Lunch Launcher to Help us Launch Lunch#######
library(telegram.bot)

bot_token <- Sys.getenv("TELEGRAM_BOT_TOKEN")

# Get the bot token from environment variables
bot_token <- Sys.getenv("TELEGRAM_BOT_TOKEN")
bot <- Bot(token = bot_token)

# Start polling
while (TRUE) {
  # Get updates from Telegram
  updates <- bot$getUpdates()
  
  # Process each update
  for (update in updates) {
    chat_id <- update$message$chat$id
    text <- update$message$text
    
    # Check if the message is "/start"
    if (text == "/start") {
      bot$sendMessage(chat_id, text = "Hello! I'm your Telegram bot. How can I help you?")
    }
  }
  
  # Add a delay to avoid excessive polling
  Sys.sleep(2)
}
