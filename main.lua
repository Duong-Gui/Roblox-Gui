-- Chờ game load xong và người chơi xuất hiện
repeat wait() until game:IsLoaded() and game.Players.LocalPlayer

-- Chạy script BananaHub để mở menu hack, bọc trong pcall để bắt lỗi
pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/obiiyeuem/vthangsitink/main/BananaHub.lua"))()
end)

-- Lấy thông tin người chơi
local player = game.Players.LocalPlayer

-- Hàm che tên người chơi
local function cheTen(ten)
    if #ten <= 4 then
        return ten .. string.rep("*", 8)
    else
        return string.sub(ten, 1, 4) .. string.rep("*", 8)
    end
end

-- Hàm kiểm tra định dạng GUID hợp lệ
local function isValidGUID(id)
    local pattern = "^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$"
    return id:match(pattern) ~= nil
end

-- Hàm giải mã Base64 thành GUID
local function decodeBase64ToGUID(base64String)
    local success, result = pcall(function()
        -- Loại bỏ tiền tố "BananaCat-" nếu có
        local base64Data = base64String:gsub("BananaCat%-", "")
        -- Thay ký tự '_' bằng '/' để chuẩn hóa Base64
        base64Data = base64Data:gsub("_", "/")
        -- Giải mã Base64 thành dữ liệu nhị phân
        local decoded = game:GetService("HttpService"):Base64Decode(base64Data)
        -- Lấy 16 byte đầu tiên để tạo GUID
        if #decoded >= 16 then
            local bytes = {decoded:byte(1, 16)}
            -- Chuyển thành định dạng GUID: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
            return string.format("%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x-%02x%02x%02x%02x%02x%02x",
                bytes[1], bytes[2], bytes[3], bytes[4], bytes[5], bytes[6], bytes[7], bytes[8],
                bytes[9], bytes[10], bytes[11], bytes[12], bytes[13], bytes[14], bytes[15], bytes[16])
        end
    end)
    if success and result then
        return result
    else
        return nil
    end
end

-- Tạo giao diện (ScreenGui)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.Name = "GiaoDienHack"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

-- Tạo khung viền giả (màu vàng)
local KhungVien = Instance.new("Frame")
KhungVien.Size = UDim2.new(0, 304, 0, 134)
KhungVien.Position = UDim2.new(0.5, -152, 0.01, -2)
KhungVien.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
KhungVien.BorderSizePixel = 0
KhungVien.ZIndex = 100
local UICornerVien = Instance.new("UICorner")
UICornerVien.CornerRadius = UDim.new(0, 12)
UICornerVien.Parent = KhungVien
KhungVien.Parent = ScreenGui

-- Tạo khung chính
local Khung = Instance.new("Frame")
Khung.Size = UDim2.new(0, 300, 0, 130)
Khung.Position = UDim2.new(0.5, -150, 0.01, 0)
Khung.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Khung.BorderSizePixel = 0
Khung.ZIndex = 101
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = Khung
Khung.Parent = ScreenGui

-- Tạo khung thông báo
local ThongBaoFrame = Instance.new("Frame")
ThongBaoFrame.Size = UDim2.new(0, 250, 0, 50)
ThongBaoFrame.Position = UDim2.new(1, -10, 1, -10)
ThongBaoFrame.AnchorPoint = Vector2.new(1, 1)
ThongBaoFrame.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
ThongBaoFrame.BorderSizePixel = 2
ThongBaoFrame.BorderColor3 = Color3.fromRGB(255, 215, 0)
ThongBaoFrame.ZIndex = 102
local UICornerThongBao = Instance.new("UICorner")
UICornerThongBao.CornerRadius = UDim.new(0, 8)
UICornerThongBao.Parent = ThongBaoFrame
ThongBaoFrame.Parent = ScreenGui

-- Tạo nhãn thông báo
local ThongBaoLabel = Instance.new("TextLabel")
ThongBaoLabel.Size = UDim2.new(1, 0, 1, 0)
ThongBaoLabel.BackgroundTransparency = 1
ThongBaoLabel.Text = "Đã Nâng Cấp Giao Diện Mới Nhất"
ThongBaoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ThongBaoLabel.TextScaled = true
ThongBaoLabel.ZIndex = 103
ThongBaoLabel.Parent = ThongBaoFrame

-- Hàm hiển thị thông báo
local function hienThiThongBao(text, color, duration)
    ThongBaoLabel.Text = text
    ThongBaoFrame.BackgroundColor3 = color or Color3.fromRGB(50, 150, 255)
    ThongBaoFrame.Visible = true
    spawn(function()
        task.wait(duration or 5)
        ThongBaoFrame.Visible = false
    end)
end

-- Tự động ẩn thông báo khởi đầu
spawn(function()
    task.wait(5)
    ThongBaoFrame.Visible = false
end)

-- Tạo nhãn "Tên"
local NhanTen = Instance.new("TextLabel")
NhanTen.Size = UDim2.new(1, 0, 0, 30)
NhanTen.Position = UDim2.new(0, 0, 0, 10)
NhanTen.BackgroundTransparency = 1
NhanTen.Text = "Tên: " .. cheTen(player.Name)
NhanTen.TextColor3 = Color3.fromRGB(255, 255, 0)
NhanTen.TextScaled = true
NhanTen.ZIndex = 104
NhanTen.Parent = Khung

-- Tạo nhãn và ô "Đơn"
local NhanDon = Instance.new("TextLabel")
NhanDon.Size = UDim2.new(0, 50, 0, 30)
NhanDon.Position = UDim2.new(0, 10, 0, 50)
NhanDon.BackgroundTransparency = 1
NhanDon.Text = "Đơn:"
NhanDon.TextColor3 = Color3.fromRGB(255, 255, 0)
NhanDon.TextScaled = true
NhanDon.ZIndex = 105
NhanDon.Parent = Khung

local ODon = Instance.new("TextBox")
ODon.Size = UDim2.new(0, 150, 0, 30)
ODon.Position = UDim2.new(0, 60, 0, 50)
ODon.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ODon.TextColor3 = Color3.fromRGB(255, 255, 255)
ODon.Text = "TUSHITA"
ODon.TextScaled = true
ODon.ZIndex = 106
ODon.Parent = Khung

local NutXoa = Instance.new("TextButton")
NutXoa.Size = UDim2.new(0, 70, 0, 30)
NutXoa.Position = UDim2.new(0, 220, 0, 50)
NutXoa.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
NutXoa.Text = "Xóa"
NutXoa.TextColor3 = Color3.fromRGB(255, 255, 255)
NutXoa.TextScaled = true
NutXoa.BorderSizePixel = 2
NutXoa.BorderColor3 = Color3.fromRGB(255, 255, 255)
NutXoa.ZIndex = 107
local UICornerXoa = Instance.new("UICorner")
UICornerXoa.CornerRadius = UDim.new(0, 8)
UICornerXoa.Parent = NutXoa
NutXoa.Parent = Khung

-- Hiệu ứng hover cho nút "Xóa"
local originalColorXoa = NutXoa.BackgroundColor3
NutXoa.MouseEnter:Connect(function()
    NutXoa.BackgroundColor3 = Color3.fromRGB(220, 20, 20)
end)
NutXoa.MouseLeave:Connect(function()
    NutXoa.BackgroundColor3 = originalColorXoa
end)

-- Tạo nhãn và ô "Server ID"
local NhanServer = Instance.new("TextLabel")
NhanServer.Size = UDim2.new(0, 100, 0, 30)
NhanServer.Position = UDim2.new(0, 10, 0, 90)
NhanServer.BackgroundTransparency = 1
NhanServer.Text = "Server ID:"
NhanServer.TextColor3 = Color3.fromRGB(255, 255, 0)
NhanServer.TextScaled = true
NhanServer.ZIndex = 108
NhanServer.Parent = Khung

local OServer = Instance.new("TextBox")
OServer.Size = UDim2.new(0, 120, 0, 30)
OServer.Position = UDim2.new(0, 110, 0, 90)
OServer.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
OServer.TextColor3 = Color3.fromRGB(255, 255, 255)
OServer.Text = ""
OServer.PlaceholderText = "Nhập ID hoặc mã Base64"
OServer.TextScaled = true
OServer.ZIndex = 109
OServer.Parent = Khung

-- Tạo nút "Dán"
local NutDan = Instance.new("TextButton")
NutDan.Size = UDim2.new(0, 60, 0, 30)
NutDan.Position = UDim2.new(0, 235, 0, 90)
NutDan.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
NutDan.Text = "Dán"
NutDan.TextColor3 = Color3.fromRGB(255, 255, 255)
NutDan.TextScaled = true
NutDan.BorderSizePixel = 2
NutDan.BorderColor3 = Color3.fromRGB(255, 255, 255)
NutDan.ZIndex = 110
local UICornerDan = Instance.new("UICorner")
UICornerDan.CornerRadius = UDim.new(0, 8)
UICornerDan.Parent = NutDan
NutDan.Parent = Khung

-- Hiệu ứng hover cho nút "Dán"
local originalColorDan = NutDan.BackgroundColor3
NutDan.MouseEnter:Connect(function()
    NutDan.BackgroundColor3 = Color3.fromRGB(255, 185, 20)
end)
NutDan.MouseLeave:Connect(function()
    NutDan.BackgroundColor3 = originalColorDan
end)

-- Tạo nút "Chuyển Server"
local NutChuyen = Instance.new("TextButton")
NutChuyen.Size = UDim2.new(0, 60, 0, 30)
NutChuyen.Position = UDim2.new(0, 165, 0, 90)
NutChuyen.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
NutChuyen.Text = "Chuyển"
NutChuyen.TextColor3 = Color3.fromRGB(255, 255, 255)
NutChuyen.TextScaled = true
NutChuyen.BorderSizePixel = 2
NutChuyen.BorderColor3 = Color3.fromRGB(255, 255, 255)
NutChuyen.ZIndex = 111
local UICornerChuyen = Instance.new("UICorner")
UICornerChuyen.CornerRadius = UDim.new(0, 8)
UICornerChuyen.Parent = NutChuyen
NutChuyen.Parent = Khung

-- Hiệu ứng hover cho nút "Chuyển"
local originalColorChuyen = NutChuyen.BackgroundColor3
NutChuyen.MouseEnter:Connect(function()
    NutChuyen.BackgroundColor3 = Color3.fromRGB(20, 220, 20)
end)
NutChuyen.MouseLeave:Connect(function()
    NutChuyen.BackgroundColor3 = originalColorChuyen
end)

-- Lưu trữ dữ liệu "Đơn"
local HttpService = game:GetService("HttpService")
local tenFileDon = "DonText_" .. player.Name .. ".json"

-- Hàm lưu nội dung "Đơn"
local function luuNoiDungDon()
    local noiDung = ODon.Text
    pcall(function()
        writefile(tenFileDon, HttpService:JSONEncode({don = noiDung}))
    end)
end

-- Hàm tải nội dung "Đơn"
local function taiNoiDungDon()
    local noiDung = "TUSHITA"
    pcall(function()
        if isfile(tenFileDon) then
            local data = HttpService:JSONDecode(readfile(tenFileDon))
            noiDung = data.don or "TUSHITA"
        end
    end)
    ODon.Text = noiDung
end

-- Sự kiện thay đổi "Đơn"
ODon:GetPropertyChangedSignal("Text"):Connect(function()
    luuNoiDungDon()
end)

-- Sự kiện nút "Xóa"
NutXoa.MouseButton1Click:Connect(function()
    ODon.Text = ""
    luuNoiDungDon()
end)

-- Sự kiện nút "Dán"
NutDan.MouseButton1Click:Connect(function()
    local clipboard = game:GetService("UserInputService"):GetClipboard() or ""
    OServer.Text = clipboard
    if clipboard:find("BananaCat%-") then
        local guid = decodeBase64ToGUID(clipboard)
        if guid and isValidGUID(guid) then
            hienThiThongBao("Đã dán mã Base64, GUID: " .. guid, Color3.fromRGB(0, 255, 0), 3)
        else
            hienThiThongBao("Mã Base64 không hợp lệ", Color3.fromRGB(255, 0, 0), 3)
        end
    elseif isValidGUID(clipboard) then
        hienThiThongBao("Đã dán GUID hợp lệ: " .. clipboard, Color3.fromRGB(0, 255, 0), 3)
    else
        hienThiThongBao("ID không đúng định dạng", Color3.fromRGB(255, 0, 0), 3)
    end
end)

-- Sự kiện nút "Chuyển"
local TeleportService = game:GetService("TeleportService")
NutChuyen.MouseButton1Click:Connect(function()
    local input = OServer.Text
    if input == "" then
        hienThiThongBao("Vui lòng nhập Server ID", Color3.fromRGB(255, 0, 0), 3)
        return
    end

    local serverId
    if input:find("BananaCat%-") then
        serverId = decodeBase64ToGUID(input)
        if not serverId or not isValidGUID(serverId) then
            hienThiThongBao("Mã Base64 không hợp lệ", Color3.fromRGB(255, 0, 0), 3)
            return
        end
    elseif isValidGUID(input) then
        serverId = input
    else
        hienThiThongBao("Server ID không hợp lệ", Color3.fromRGB(255, 0, 0), 3)
        return
    end

    -- Thử TeleportService trước
    hienThiThongBao("Đang chuyển đến server: " .. serverId, Color3.fromRGB(0, 255, 0), 3)
    local success, err = pcall(function()
        TeleportService:TeleportToPlaceInstance(game.PlaceId, serverId, player)
    end)
    if not success then
        -- Nếu TeleportService thất bại, thử InvokeServer
        hienThiThongBao("Teleport thất bại, thử InvokeServer...", Color3.fromRGB(255, 165, 0), 3)
        pcall(function()
            game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer("teleport", serverId)
        end)
    end
end)

-- Tải nội dung "Đơn" khi khởi động
taiNoiDungDon()

print("Hack Blox Fruits đã chạy! Menu BananaHub đã được mở.")
