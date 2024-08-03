if not game:IsLoaded() then
    game.IsLoaded:Wait()
end
function String2Table(str)
  if type(str) == "string" then
  local length = #str
  local count = 1
  local String = {}
  while not (#String == length) do
    String[count] = str:sub(count, count)
        count = count + 1
  end
  return String
end
end
local Players = game:GetService("Players")
local LocalPlayer = game:GetService("Players").LocalPlayer


local Character = LocalPlayer.Character
if game:GetService("TextChatService").ChatVersion == Enum.ChatVersion.LegacyChatService then
    chat = "legacy"
        ChatBar = LocalPlayer.PlayerGui.Chat.Frame.ChatBarParentFrame.Frame.BoxFrame.Frame.ChatBar
    chatMain = game:GetService("Players").LocalPlayer.PlayerScripts.ChatScript.ChatMain
    
    lastText = ""
    function makeMessage(message)
        msg = tostring(message)
        game:GetService("StarterGui"):SetCore(
            "ChatMakeSystemMessage",
            {
                Text = msg,
                Color = Color3.fromRGB(255, 89, 98),
                Font = Enum.Font.GothamMedium,
                FontSize = 16
            }
        )
    end
    function makeWarn(message)
        msg = tostring(message)
        game:GetService("StarterGui"):SetCore(
            "ChatMakeSystemMessage",
            {
                Text = "[WARN]\n" .. msg,
                Color = Color3.fromHex("#fdfd96"),
                Font = Enum.Font.GothamMedium,
                FontSize = 16
            }
        )
    end
    function makeError(message)
        msg = tostring(message)
        game:GetService("StarterGui"):SetCore(
            "ChatMakeSystemMessage",
            {
                Text = "[ERROR]\n" .. msg,
                Color = Color3.fromRGB(125, 12, 23),
                Font = Enum.Font.GothamMedium,
                FontSize = 16
            }
        )
    end
    makeMessage("Protectio loaded.")
    if not game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents:FindFirstChild("SayMessageRequest") then
    makeError("Could not find SayMessageRequest, Please send a message in chat to fix this and prevent chat bans.")
    else
    SMR = game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents:FindFirstChild("SayMessageRequest")
    end
else
    chat = "tcs"
    function makeMessage(msg)
        msg = tostring(msg)
        if game:GetService("TextChatService").TextChannels:FindFirstChild("RBXGeneral") then
            game:GetService("TextChatService").TextChannels:FindFirstChild("RBXGeneral"):DisplaySystemMessage(msg)
        end
    end
    function makeWarn(msg)
        msg = tostring(msg)
        if game:GetService("TextChatService").TextChannels:FindFirstChild("RBXGeneral") then
            game:GetService("TextChatService").TextChannels:FindFirstChild("RBXGeneral"):DisplaySystemMessage(
                "[WARN] " .. msg
            )
        end
    end
    function makeError(msg)
        makeMessage("[ERROR]\n" .. msg)
    end
    makeMessage("Protectio loaded.")
end
local function gcs()
    if getcallingscript() ~= nil then
        return getcallingscript():GetFullName()
    else
        return "Unknown script"
    end
end
local r = true

Protectio = {
    AllowSendAsync = false,
    HttpOptions = {
    HttpGet = {Enabled = true, allowedURLs = {
      "https://scriptblox.com";
     }
    },
    HttpPost = {Enabled = false, allowedURLs = {}
    
    }
  },
    Request = {Enabled = false, allowedURLs = {}},
    AllowClientKick = false,
    AllowReportAbuse = false,
    AllowCaptureFocus = false,
    AllowSayMessageRequest = false,
    AllowAccessFriends = false,
    AllowKeyPresses = true
}

OnAttemptDeny = {
    CopyURLs = true,
    CopyReportAbuse = false
}

local hook
hook =
    hookmetamethod(
    game,
    "__namecall",
    function(Self, ...)
        local args, method = {...}, getnamecallmethod()
        if Protectio[1] == false and method == "SendAsync" and Self:IsA("TextChannel") then
            return makeWarn(gcs() .. " tried to SendAsync with the message " .. args[1] .. " in channel " .. Self.Name)
        end
        if
            not Protectio.HttpOptions.HttpGet.Enabled and method:find("HttpGet") then
            if OnAttemptDeny[1] == true then
                setclipboard(args[1])
            end
            
            return makeWarn(
                string.format(
          "%s called %s with the URL %s, HttpGet is not enabled and make sure to put the url in the HttpGet.allowedURLs table if you want to trust the url.", gcs(), method, args[1]
                )
            )
    elseif Protectio.HttpOptions.HttpGet.Enabled and method:find("HttpGet") then
      found = false
      local url = args[1]
      local spl = url:gsub("https://", ""):split("/")
      local dot = "https://" .. spl[1]
      
      for i, v in Protectio.HttpOptions.HttpGet.allowedURLs do
      if v:find(dot) then
       found = true
      end
      end
      if not found then
       if OnAttemptDeny[1] then setclipboard(url) end
      return makeWarn(
        string.format(
          "%s called %s with the URL %s, Attempt blocked as the URL was not found in the allowed urls table.\n"
        , gcs(), method, args[1]))
        end
      end
     
           if
            not Protectio.HttpOptions.HttpPost.Enabled and method:find("HttpPost") then
            if OnAttemptDeny[1] == true then
                setclipboard(args[1])
            end
            
            return makeWarn(
                string.format(
          "%s called %s with the URL %s, HttpPost is not enabled and make sure to put the url in the HttpPost.allowedURLs table if you want to trust the url.", gcs(), method, args[1]
                )
            )
    elseif Protectio.HttpOptions.HttpPost.Enabled and method:find("HttpPost") then
      found2 = false
      local url = args[1]
      local spl = url:gsub("https://", ""):split("/")
      local dot = "https://" .. spl[1]
      
      
      for i, v in Protectio.HttpOptions.HttpPost.allowedURLs do
      if v:find(dot) then
      found2 = true
      end
      end
      if not found2 then
        if OnAttemptDeny[1] == true then
        setclipboard(url)
       end
      return makeWarn(
        string.format(
          "%s called %s with the URL %s, Attempt blocked as the URL was not found in the allowed urls table.\n"
        , gcs(), method, args[1]))
        end
      end
        if method == "FireServer" and SMR == nil and not chatMain == nil and getcallingscript() == chatMain then
        SMR = Self
        makeMessage(
        "SayMessageRequest found disguised as "..Self.Name..", Anti Chat Ban should be working as expected now."
        )
        
        end
        if Protectio[3] == false and method == "Kick" and Self == LocalPlayer then
            return makeWarn(gcs() .. " tried to kick you, Protectio denied the attempt.")
        end
        if Protectio[4] == false and method == "ReportAbuse" then
            if OnAttemptDeny[3] then
                setclipboard(string.format("-- Latest Report Abuse call info: \nCalling Script: %s\nReason: %s\nPlayer: %s\nNote: %s", gcs(), args[1], args[2], args[3]))
            end
            return makeWarn(
                string.format("-- Latest Report Abuse call info: \nCalling Script: %s\nReason: %s\nPlayer: %s\nNote: %s", gcs(), args[1], args[2], args[3]))
        end
        if
            Protectio[5] == false and method == "CaptureFocus" and not getcallingscript() == chatMain and
                Self == ChatBar and
                chat == "legacy"
         then
            return makeWarn(gcs() .. " tried to CaptureFocus, Possible Force Chat attempt denied.")
        elseif chat == "tcs" and method == "CaptureFocus" and Protectio[5] == false then
            return makeWarn(gcs() .. " tried to call CaptureFocus, Attempt denied.")
        end
        if
            chat == "legacy" and Self == SMR and method == "FireServer" and lastText ~= args[1] and
                getcallingscript() ~= chatMain
         then
            return makeWarn(gcs() .. " tried to call SayMessageRequest")
        end
        if Protectio[AllowAccessFriends] == false and method == "GetFriendsAsync" then
        return makeWarn(string.format("%s tried to call GetFriendsAsync (checking your friend list), Attempt denied"), gcs())
        end
        if Protectio.AllowKeyPresses == false and method == "SendKeyEvent" then
      return makeWarn(string.format("%s tried to call SendKeyEvent %s, Attempt denied due to AllowKeyPresses being set to false.", gcs(), tostring(args[2])))
    end
    if method == 'PromptGamePassPurchase' or method == 'PromptBundlePurchase' or method == 'PromptPremiumPurchase' or method == 'PromptProductPurchase' or method == 'PromptPurchase' or method == 'PromptSubscriptionPurchase' then
      local x = ''
      for i, v in args do x = x .. i ..": " .. tostring(x) .. "\n" end
      return makeWarn(
      gcs()
      ..
      "called a robux stealing/draining method, Please do not re-execute the last script; If you haven't executed any scripts then this might be a game script, Arguements: \n" .. x)
    end
        return hook(Self, ...)
    end
)
if ChatBar ~= nil then
    ChatBar.Focused:Connect(
        function()
            repeat
                lastText = ChatBar.Text
            until ChatBar.Text == ""
        end
    )
end

hookfunction(
    error,
    newcclosure(
        function(...)
            if not stopped2 then
                local args = {...}
                for i, v in args do
                    makeError = (v)
                end
                stopped2 = true
                for i, v in args do
                    error(v)
                end
                stopped2 = false
            end
        end
    )
)
hookfunction(
    warn,
    newcclosure(
        function(...)
            if not stopped3 then
                local args = {...}
                for i, v in args do
                    makeWarn(v)
                end
                stopped3 = true
                for i, v in args do
                    warn(v)
                end
                stopped3 = false
            end
        end
    )
)

if Protectio[AllowKeyPresses] == false then
hookfunction(keypress, function(...)
local Args = {...}
return makeWarn(
gcs().. " Tried to keypress with the following code: "..Args[1])
end)
end
local request = (syn and syn.request or fluxus and fluxus.request) or request or Request
if not Protectio.Request.Enabled then
hookfunction(request, newcclosure(function(Args)
    found3 = false
    local x = Args.Url:gsub("https://", ""):split("/")[1]
    for i, v in Protectio.Request.allowedURLs do
    if v:find(x) then found3 = true end
    end
    if not found3 then
    makeWarn(gcs().. " tried to call request with the following arguements")
    local fullname = ''
    for _, Arg in Args do
       if type(Arg) == 'table' then
        for i, v in Arg do
        fullname = fullname .. tostring(i) .. ": " .. v .. "\n"
        end
       elseif type(Arg) == 'string' then
       fullname = fullname .. tostring(_) .. ": " .. Arg .. "\n"
     end
     end
     makeWarn(fullname)
     if OnAttemptDeny[CopyURLs] then setclipboard(Args.Url) end
    end
end))
end
