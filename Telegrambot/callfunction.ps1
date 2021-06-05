


$params = @{Name="Nathanael"}

# Sandbox function
Invoke-RestMethod -Uri "https://telegramnasatest23.azurewebsites.net/api/HttpTrigger1?code=lKrBfIUUIC2zoqbBJc6gVso1RZMhvFOzNyTWDXOYO/jgK9lUUNv6jA==" -Body ($params|ConvertTo-Json) -ContentType "application/json" -Method Post

# function in nasa unico
$params = @{Name="Osterhase"}
$FunctionLink = "https://telegrambod.azurewebsites.net/api/listener?code=leQqaK0YPLSMJ/q6foz3n7lZM6nCcHWHhncsrWvOaZ1EKDkNiOibjA=="
Invoke-RestMethod -Uri $FunctionLink -Body ($params|ConvertTo-Json) -ContentType "application/json" -Method Post


# telegram call:
$Telegramtoken = "1743757698:AAHaO-aC8s7InTalgbLai1CE3DhaUmkkyQ4"
$TelegramApiLink = "https://api.telegram.org/bot$($Telegramtoken)"

Invoke-RestMethod -Uri "https://api.telegram.org/bot$($Telegramtoken)/getMe"
# or
Invoke-RestMethod -Uri "$($TelegramApiLink)/getMe"

# https://api.telegram.org/bot<AccessToken>/getMe

# calls telegram api to set webook on functionlink
Invoke-RestMethod -Uri "$($TelegramApiLink)/setWebhook" -Body @{"url"=$FunctionLink} -Method Post
# verify url is correct: 
Invoke-RestMethod -Uri "$($TelegramApiLink)/getWebhookInfo"



# function to send messages:
function Send-Telegram {
    Param(
        [Parameter(Mandatory=$true)]
        [String]$Message
        )
    $Telegramtoken = "1743757698:AAHaO-aC8s7InTalgbLai1CE3DhaUmkkyQ4"
    $Telegramchatid = "29042198"
   # [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $Response = Invoke-RestMethod -Uri "https://api.telegram.org/bot$($Telegramtoken)/sendMessage?chat_id=$($Telegramchatid)&text=$($Message)"
}