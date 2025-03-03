#####Lunch Launcher to Help us Launch Lunch#######
library(telegram.bot)

# Get the bot token from environment variables
bot_token <- Sys.getenv("TELEGRAM_BOT_TOKEN")
bot <- Bot(token = bot_token)

# Initialize the last processed update_id
last_update_id <- 0

#randomize a lunch option
lunch_bot <- function(){
  lunch_list = c( "KFC", "McDonald's","Porridge","Chicken Rice","Prata","Chicken Rice", 
                  "Stuffd", "Guzman y Gomez",
                 "Wanton Mee", "CRAVE Nasi Lemak", "Ya Kun",
                 "Sushi", "Mos Burger", "Cook at Home", "Duck Rice", 
                 "Saizeriya","The Larder","Subway", "Oyster Omelette", "Pokebowl" )
  x <- sample.int(length(lunch_list), 1)
  lunch_list[x]
}

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
      bot$sendMessage(chat_id, text = lunch_bot())
      
      # Update the last processed update_id
      last_update_id <- update_id
    }
  }
  
  # Add a delay to avoid excessive polling
  Sys.sleep(2)
}
