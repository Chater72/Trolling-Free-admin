-- Создание меню
local Menu = Instance.new("ScreenGui")
Menu.Name = "ExploitMenu"
Menu.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Создание вкладок
local Tab = Instance.new("Frame")
Tab.Name = "Tab"
Tab.Parent = Menu
Tab.BackgroundColor3 = Color3.new(0, 1, 0) -- Цвет фона вкладок (зеленый)
Tab.Position = UDim2.new(0.5, -200, 0.5, -250) -- Позиция центрированного меню
Tab.Size = UDim2.new(0, 400, 0, 600) -- Увеличение размера вкладок
Tab.Active = true
Tab.ClipsDescendants = true
Tab.Visible = false -- Скрываем меню по умолчанию

-- Функция для перетаскивания
local function makeDraggable(frame)
    local dragToggle = nil
    local dragInput = nil
    local startPos = frame.Position

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragToggle = true
            dragInput = input
            local mousePos = UDim2.new(input.Position.X, 0, input.Position.Y, 0)

            while dragToggle do
                game:GetService("RunService").RenderStepped:Wait()
                local delta = mousePos - UDim2.new(0, input.Position.X, 0, input.Position.Y)
                frame.Position = startPos + UDim2.new(delta.X.Scale, delta.X.Offset, delta.Y.Scale, delta.Y.Offset)
            end
        end
    end)

    frame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragToggle = false
        end
    end)
end

makeDraggable(Tab) -- Делаем вкладки перетаскиваемыми

-- Кнопка для открытия/закрытия меню
local ToggleButton = Instance.new("TextButton")
ToggleButton.Parent = Menu
ToggleButton.Size = UDim2.new(0, 120, 0, 60) -- Увеличен размер кнопки
ToggleButton.Position = UDim2.new(1, -130, 0, 20) -- Перемещено в правый угол
ToggleButton.Text = "Меню"
ToggleButton.TextSize = 24 -- Увеличение размера текста
ToggleButton.BackgroundColor3 = Color3.new(0, 1, 0) -- Цвет кнопки открытия (зеленый)

-- Убираем перетаскивание у кнопки
-- makeDraggable(ToggleButton) -- Удалено, чтобы не перетаскивалось
ToggleButton.MouseButton1Click:Connect(function()
    Tab.Visible = not Tab.Visible
    ToggleButton.Text = Tab.Visible and "Закрыть" or "Открыть"
end)

-- Перехват клавиши Insert для открытия меню
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.Insert then
        Tab.Visible = not Tab.Visible
        ToggleButton.Text = Tab.Visible and "Закрыть" or "Открыть"
    end
end)

-- Функция для добавления кнопок
local function AddButton(Name, Command)
    local Button = Instance.new("TextButton")
    Button.Parent = Tab
    Button.Size = UDim2.new(0.4, 0, 0, 40) -- Увеличиваем высоту кнопки
    Button.Position = UDim2.new(0.05 + (0.45 * ((#Tab:GetChildren() - 1) % 2)), 0, 0, math.floor((#Tab:GetChildren() - 1) / 2) * 45) -- Изменено для двух колонок
    Button.Text = Name
    Button.TextSize = 22 -- Увеличение размера текста
    Button.BorderSizePixel = 2 -- Устанавливаем рамку вокруг кнопки
    Button.BackgroundColor3 = Color3.new(math.random(), math.random(), math.random()) -- Цвет фона кнопок (случайный)
    Button.BorderColor3 = Color3.new(0, 0, 0) -- Цвет рамки кнопок (по желанию)

    Button.MouseButton1Click:Connect(function()
        game.Players:Chat(Command)
    end)
end
-- Добавление новых кнопок с командами :clone и :poop
AddButton("Клон Амир", ":clone a")
AddButton("Клон Усман", ":clone f")
AddButton("Клон Толик", ":clone t")
AddButton("Клон Банан", ":clone b")
AddButton("Клон Лол", ":clone l")
AddButton("Срать Амир", ":poop a")
AddButton("Срать Толик", ":poop t")
AddButton("Срать Усман", ":poop f")
AddButton("Срать Банан", ":poop b")
AddButton("Срать Лол", ":poop l")
AddButton("режим бога", ":ff me ")
AddButton("Выйти из тюрьмы", ":unjail me")
AddButton("Без контроля", ":uncontrol me")
AddButton("R6", ":r6 me")
AddButton("R15", ":r15 me")
AddButton("ff off", ":unff me")
AddButton("Вылечить себя", ":heal me")
