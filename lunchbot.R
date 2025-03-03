#####Lunch Launcher to Help us Launch Lunch#######
library(telegram.bot)

# Get the bot token from environment variables
bot_token <- Sys.getenv("TELEGRAM_BOT_TOKEN")
bot <- Bot(token = bot_token)

# Initialize the last processed update_id
last_update_id <- 0

# Start polling
while (TRUE) {
  # Get updates from Telegram, starting from the last processed update_id + 1
  updates <- bot$getUpdates(offset = last_update_id + 1)
  
  # Process each update
  for (update in updates) {
    chat_id <- update$message$chat$id
    text <- update$message$text
    update_id <- update$update_id
    
    # Check if the message is "/start" and hasn't been processed yet
    if (text == "/start" && update_id > last_update_id) {
      bot$sendMessage(chat_id, text = "Hello! I'm your Telegram bot. How can I help you?")
      
      # Update the last processed update_id
      last_update_id <- update_id
    }
  }
  
  # Add a delay to avoid excessive polling
  Sys.sleep(2)
}
