local ui = loadstring(game:HttpGet("https://raw.githubusercontent.com/joshy-5/Milk-script/refs/heads/main/ui-init.lua"))()

ui.FOV.ValueDisplay.Text.InputChanged:Connect(function(value)
  print(value)
end)
