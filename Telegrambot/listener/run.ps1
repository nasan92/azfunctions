using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

# Write to the Azure Functions log stream.
Write-Host "PowerShell HTTP trigger function processed a request."

# Interact with query parameters or the body of the request.

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


Write-Host ($Request.Body | Convertto-Json)
#Write-Host ($Request.Body.message.text | Convertto-Json)
$text = ($Request.Body.message.text | Convertto-Json)
Write-Host $text

if($text -match "Spast"){
    Send-Telegram -Message "Ja das bisch spast"
}

if($text -match "dogfact"){
    $RandomNumber = Get-Random -Maximum 430
    $dogfact = Invoke-RestMethod -Uri "https://dog-facts-api.herokuapp.com/api/v1/resources/dogs?index=$($RandomNumber)"
    Send-Telegram -Message "$($dogfact)"
}
$body = "This HTTP triggered function executed successfully. Pass a name in the query string or in the request body for a personalized response."



<#

$name = $Request.Query.Name
if (-not $name) {
    $name = $Request.Body.Name
}

if ($name) {
    $outputMsg = $name
   # Push-OutputBinding -name msg -Value $outputMsg

    $status = [HttpStatusCode]::OK
    $body = "He $name. This HTTP triggered function executed successfully."
}else {
    $status = [HttpStatusCode]::BadRequest
    $body = "Please pass a name on the query string or in the request body."
}
Write-Host $body
Write-Host ($Request.Body | Convertto-Json)

# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = $status
    Body = $body
    
})

#>