Gui, Add, Picture, h600 w450 vBPicture, C:\Users\user\webapps\maybe-not-a-webapp-autoit-script\shiba-desktop\shiba.jpg
Gui, Show, h600 w450, Desktop Shiba
pleasure = 0

#persistent
coordmode, mouse, screen
settimer, check, 30
return
previousMouseX = 0
previousMouseY = 0

check:
mousegetpos, currentMouseX, currentMouseY
if (currentMouseX != previousMouseX && previousMouseY != currentMouseY || currentMouseX != previousMouseX || currentMouseY != previousMouseY) {
    previousMouseX := currentMouseX
    previousMouseY := currentMouseY
    pleasure += 1
    ; ToolTip, %pleasure% | currentMouseX: %currentMouseX% | previousMouseX: %previousMouseX% , 100, 150
} 

if (pleasure = 100) {
    whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    whr.Open("GET", "http://shibe.online/api/shibes?urls=true&httpsUrls=true", true)
    whr.Send()
    whr.WaitForResponse()
    shibaNoLeftBracket := StrReplace(whr.responseText, "[", "")
    shibaNoRightBracket := StrReplace(shibaNoLeftBracket, "]", "")
    shibaNoQuotes := StrReplace(shibaNoRightBracket, """", "")
    shiba := shibaNoQuotes
    UrlDownloadToFile, %shiba%, C:\Users\user\webapps\maybe-not-a-webapp-autoit-script\shiba-desktop\shiba.jpg
    GuiControl, -Redraw, BPicture
    GuiControl,, BPicture,  C:\Users\user\webapps\maybe-not-a-webapp-autoit-script\shiba-desktop\shiba.jpg
    GuiControl, +Redraw, BPicture
    pleasure = 0
} 
return

