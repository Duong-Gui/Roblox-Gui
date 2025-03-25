-- Chờ game load xong và người chơi xuất hiện
repeat wait() until game:IsLoaded() and game.Players.LocalPlayer

-- Chạy script BananaHub để mở menu hack, bọc trong pcall để bắt lỗi
pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/obiiyeuem/vthangsitink/main/BananaHub.lua"))()
end)

-- Lấy thông tin người chơi
local player = game.Players.LocalPlayer
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")

-- Hàm để che tên người chơi
local function cheTen(ten)
    return string.sub(ten, 1, 4) .. string.rep("*", 8)
end

-- Tạo giao diện chính
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = player:WaitForChild("PlayerGui")
ScreenGui.Name = "GiaoDienHack"

-- Tạo khung chính
local Khung = Instance.new("Frame")
Khung.Size = UDim2.new(0, 300, 0, 130)
Khung.Position = UDim2.new(0.5, -150, 0.01, 0)
Khung.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Khung.BorderSizePixel = 0
Khung.ZIndex = 10 -- Luôn nằm trên
Khung.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = Khung

-- Tạo khung thông báo (luôn nằm dưới)
local ThongBaoFrame = Instance.new("Frame")
ThongBaoFrame.Size = UDim2.new(0, 200, 0, 50)
ThongBaoFrame.Position = UDim2.new(1, -10, 1, -10)
ThongBaoFrame.AnchorPoint = Vector2.new(1, 1)
ThongBaoFrame.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
ThongBaoFrame.BorderSizePixel = 2
ThongBaoFrame.BorderColor3 = Color3.fromRGB(255, 215, 0)
ThongBaoFrame.ZIndex = 5 -- Nằm dưới khung chính
ThongBaoFrame.Parent = ScreenGui

local UICornerThongBao = Instance.new("UICorner")
UICornerThongBao.CornerRadius = UDim.new(0, 8)
UICornerThongBao.Parent = ThongBaoFrame

local ThongBaoLabel = Instance.new("TextLabel")
ThongBaoLabel.Size = UDim2.new(1, 0, 1, 0)
ThongBaoLabel.BackgroundTransparency = 1
ThongBaoLabel.Text = "Đã Nâng Cấp Giao Diện Mới Nhất"
ThongBaoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ThongBaoLabel.TextScaled = true
ThongBaoLabel.Parent = ThongBaoFrame

spawn(function()
    task.wait(5)
    ThongBaoFrame.Visible = false
end)

-- Tạo nhãn "Tên" hiển thị tên đã che
local NhanTen = Instance.new("TextLabel")
NhanTen.Size = UDim2.new(1, 0, 0, 30)
NhanTen.Position = UDim2.new(0, 0, 0, 10)
NhanTen.BackgroundTransparency = 1
NhanTen.Text = "Tên: " .. cheTen(player.Name)
NhanTen.TextColor3 = Color3.fromRGB(255, 255, 0)
NhanTen.TextScaled = true
NhanTen.Parent = Khung

-- Tạo ô nhập "Đơn"
local ODon = Instance.new("TextBox")
ODon.Size = UDim2.new(0, 150, 0, 30)
ODon.Position = UDim2.new(0, 60, 0, 50)
ODon.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ODon.TextColor3 = Color3.fromRGB(255, 255, 255)
ODon.Text = "TUSHITA"
ODon.TextScaled = true
ODon.Parent = Khung

-- Lưu nội dung "Đơn" vào file
local tenFile = "DonText_" .. player.Name .. ".json"
local function luuNoiDungDon()
    pcall(function()
        writefile(tenFile, HttpService:JSONEncode({don = ODon.Text}))
    end)
end

ODon:GetPropertyChangedSignal("Text"):Connect(luuNoiDungDon)

-- Tải dữ liệu "Đơn" từ file
pcall(function()
    if isfile(tenFile) then
        local data = HttpService:JSONDecode(readfile(tenFile))
        ODon.Text = data.don or "TUSHITA"
    end
end)

-- Nút "Chuyển Server"
local NutChuyen = Instance.new("TextButton")
NutChuyen.Size = UDim2.new(0, 70, 0, 30)
NutChuyen.Position = UDim2.new(0, 220, 0, 90)
NutChuyen.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
NutChuyen.Text = "Chuyển"
NutChuyen.TextColor3 = Color3.fromRGB(255, 255, 255)
NutChuyen.TextScaled = true
NutChuyen.Parent = Khung

NutChuyen.MouseButton1Click:Connect(function()
    local serverId = ODon.Text
    if serverId and serverId ~= "" then
        TeleportService:TeleportToPlaceInstance(game.PlaceId, serverId, player)
    else
        warn("Vui lòng nhập ID Server hợp lệ!")
    end
end)

print("Hack Blox Fruits đã chạy! Menu BananaHub đã được mở.")
