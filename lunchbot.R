#####Lunch Launcher to Help us Launch Lunch#######
library(tidyverse)
library(dplyr)
library(telegram.bot)

lunch_bot <- function(){
  lunch_list = c( "KFC", "McDonald's","Porridge","Chicken Rice","Prata","Chicken Rice", 
                  "Stuffd", "Guzman y Gomez",
                 "Wanton Mee", "CRAVE Nasi Lemak", "Ya Kun",
                 "Sushi", "Mos Burger", "Cook at Home", "Duck Rice", 
                 "Saizeriya","The Larder","Subway", "Oyster Omelette", "Pokebowl" )
  x <- sample.int(length(lunch_list), 1)
  lunch_list[x]
}

lunch_bot()

#How to see messages sent to your bot using updater
bot <- Bot(token ="1802438055:AAHF45tZMJilIXb3-2ObDNaiuWqmHWoPj7s")
print(bot$getMe())
updates <- bot$getUpdates()
updates


#Mei's
mei_chat_id <- updates[[3]]$message$chat$id # you can retrieve it from bot$getUpdates() after sending a message to the bot

#YW's
yw_chat_id <- updates[[1]]$message$chat$id

bot_updater <- Updater(token = "1802438055:AAHF45tZMJilIXb3-2ObDNaiuWqmHWoPj7s")


#/start command handler
start <- function(bot, update)
{
  bot$sendMessage(chat_id = update$message$chat_id,
                  text = lunch_bot())
                    #sprintf("Hello %s!",
                                 #update$message$from$first_name))
}
start_handler <- CommandHandler("start", start)
bot_updater <- bot_updater + start_handler

bot$sendMessage(chat_id = mei_chat_id, text = "Indeed :(")

#start polling
bot_updater$start_polling()

#pick lunch command handler
pick <- function(bot, update)
{
  bot$sendMessage(chat_id = update$message$chat_id, text = lunch_bot())
}

lunch_handler <- MessageHandler(pick_lunch, MessageFilters$text)
bot_updater <- bot_updater + start_handler + lunch_handler

#start polling
bot_updater$start_polling()


?MessageHandler
?sample.int
