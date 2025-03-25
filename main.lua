-- Chờ game load xong và người chơi xuất hiện
repeat wait() until game:IsLoaded() and game.Players.LocalPlayer

-- Chạy script BananaHub để mở menu hack, bọc trong pcall để bắt lỗi
pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/obiiyeuem/vthangsitink/main/BananaHub.lua"))()
end)

-- Lấy thông tin người chơi
local player = game.Players.LocalPlayer

-- Hàm để che tên người chơi (ví dụ: "toan********")
local function cheTen(ten)
    if #ten <= 4 then
        return ten .. string.rep("*", 8) -- Nếu tên ngắn, thêm dấu sao
    else
        return string.sub(ten, 1, 4) .. string.rep("*", 8) -- Hiện 4 chữ đầu, còn lại là dấu sao
    end
end

-- Tạo giao diện (ScreenGui)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.Name = "GiaoDienHack"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling -- Đảm bảo ZIndex hoạt động đúng
ScreenGui.ResetOnSpawn = false -- Không reset GUI khi người chơi respawn

-- Tạo khung viền giả (màu vàng, lớn hơn khung chính)
local KhungVien = Instance.new("Frame")
KhungVien.Size = UDim2.new(0, 304, 0, 134) -- Viền dày 2px mỗi bên
KhungVien.Position = UDim2.new(0.5, -152, 0.01, -2) -- Căn giữa
KhungVien.BackgroundColor3 = Color3.fromRGB(255, 215, 0) -- Màu vàng
KhungVien.BorderSizePixel = 0
KhungVien.ZIndex = 100 -- Đặt ZIndex cao để đè lên các GUI khác
-- Thêm UICorner để bo tròn
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
Khung.ZIndex = 101 -- Đặt ZIndex cao hơn KhungVien
-- Thêm UICorner để bo tròn
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = Khung
Khung.Parent = ScreenGui

-- Tạo khung thông báo ở góc phải dưới
local ThongBaoFrame = Instance.new("Frame")
ThongBaoFrame.Size = UDim2.new(0, 200, 0, 50)
ThongBaoFrame.Position = UDim2.new(1, -10, 1, -10) -- Góc phải dưới
ThongBaoFrame.AnchorPoint = Vector2.new(1, 1) -- Căn vào góc phải dưới
ThongBaoFrame.BackgroundColor3 = Color3.fromRGB(50, 150, 255) -- Màu xanh dương nhạt
ThongBaoFrame.BorderSizePixel = 2
ThongBaoFrame.BorderColor3 = Color3.fromRGB(255, 215, 0) -- Viền vàng
ThongBaoFrame.ZIndex = 102 -- Đặt ZIndex cao
-- Thêm UICorner để bo tròn
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
ThongBaoLabel.ZIndex = 103 -- Đặt ZIndex cao hơn ThongBaoFrame
ThongBaoLabel.Parent = ThongBaoFrame

-- Tự động ẩn thông báo sau 5 giây
spawn(function()
    task.wait(5)
    ThongBaoFrame.Visible = false
end)

-- Tạo nhãn "Tên" (hiển thị tên người chơi đã che)
local NhanTen = Instance.new("TextLabel")
NhanTen.Size = UDim2.new(1, 0, 0, 30)
NhanTen.Position = UDim2.new(0, 0, 0, 10)
NhanTen.BackgroundTransparency = 1
NhanTen.Text = "Tên: " .. cheTen(player.Name)
NhanTen.TextColor3 = Color3.fromRGB(255, 255, 0)
NhanTen.TextScaled = true
NhanTen.ZIndex = 104 -- Đặt ZIndex cao
NhanTen.Parent = Khung

-- Tạo nhãn "Đơn" và ô nhập liệu
local NhanDon = Instance.new("TextLabel")
NhanDon.Size = UDim2.new(0, 50, 0, 30)
NhanDon.Position = UDim2.new(0, 10, 0, 50)
NhanDon.BackgroundTransparency = 1
NhanDon.Text = "Đơn:"
NhanDon.TextColor3 = Color3.fromRGB(255, 255, 0)
NhanDon.TextScaled = true
NhanDon.ZIndex = 105 -- Đặt ZIndex cao
NhanDon.Parent = Khung

local ODon = Instance.new("TextBox")
ODon.Size = UDim2.new(0, 150, 0, 30)
ODon.Position = UDim2.new(0, 60, 0, 50)
ODon.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ODon.TextColor3 = Color3.fromRGB(255, 255, 255)
ODon.Text = "TUSHITA" -- Giá trị mặc định
ODon.TextScaled = true
ODon.ZIndex = 106 -- Đặt ZIndex cao
ODon.Parent = Khung

-- Tạo nút "Xóa" cho phần "Đơn"
local NutXoa = Instance.new("TextButton")
NutXoa.Size = UDim2.new(0, 70, 0, 30)
NutXoa.Position = UDim2.new(0, 220, 0, 50)
NutXoa.BackgroundColor3 = Color3.fromRGB(200, 0, 0) -- Màu đỏ đậm hơn
NutXoa.Text = "Xóa"
NutXoa.TextColor3 = Color3.fromRGB(255, 255, 255)
NutXoa.TextScaled = true
NutXoa.BorderSizePixel = 2 -- Thêm viền
NutXoa.BorderColor3 = Color3.fromRGB(255, 255, 255) -- Viền trắng
NutXoa.ZIndex = 107 -- Đặt ZIndex cao
-- Thêm UICorner để bo tròn
local UICornerXoa = Instance.new("UICorner")
UICornerXoa.CornerRadius = UDim.new(0, 8) -- Bo tròn 8px
UICornerXoa.Parent = NutXoa
NutXoa.Parent = Khung

-- Thêm hiệu ứng hover cho nút "Xóa"
local originalColorXoa = NutXoa.BackgroundColor3
NutXoa.MouseEnter:Connect(function()
    NutXoa.BackgroundColor3 = Color3.fromRGB(220, 20, 20) -- Sáng hơn khi hover
end)
NutXoa.MouseLeave:Connect(function()
    NutXoa.BackgroundColor3 = originalColorXoa -- Trở về màu gốc
end)

-- Tạo nhãn và ô nhập ID server
local NhanServer = Instance.new("TextLabel")
NhanServer.Size = UDim2.new(0, 100, 0, 30)
NhanServer.Position = UDim2.new(0, 10, 0, 90)
NhanServer.BackgroundTransparency = 1
NhanServer.Text = "Server ID:"
NhanServer.TextColor3 = Color3.fromRGB(255, 255, 0)
NhanServer.TextScaled = true
NhanServer.ZIndex = 108 -- Đặt ZIndex cao
NhanServer.Parent = Khung

local OServer = Instance.new("TextBox")
OServer.Size = UDim2.new(0, 100, 0, 30)
OServer.Position = UDim2.new(0, 110, 0, 90)
OServer.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
OServer.TextColor3 = Color3.fromRGB(255, 255, 255)
OServer.Text = ""
OServer.PlaceholderText = "Nhập ID Server"
OServer.TextScaled = true
OServer.ZIndex = 109 -- Đặt ZIndex cao
OServer.Parent = Khung

-- Tạo nút "Chuyển Server"
local NutChuyen = Instance.new("TextButton")
NutChuyen.Size = UDim2.new(0, 70, 0, 30)
NutChuyen.Position = UDim2.new(0, 220, 0, 90)
NutChuyen.BackgroundColor3 = Color3.fromRGB(0, 200, 0) -- Màu xanh lá dịu hơn
NutChuyen.Text = "Chuyển"
NutChuyen.TextColor3 = Color3.fromRGB(255, 255, 255)
NutChuyen.TextScaled = true
NutChuyen.BorderSizePixel = 2 -- Thêm viền
NutChuyen.BorderColor3 = Color3.fromRGB(255, 255, 255) -- Viền trắng
NutChuyen.ZIndex = 110 -- Đặt ZIndex cao
-- Thêm UICorner để bo tròn
local UICornerChuyen = Instance.new("UICorner")
UICornerChuyen.CornerRadius = UDim.new(0, 8) -- Bo tròn 8px
UICornerChuyen.Parent = NutChuyen
NutChuyen.Parent = Khung

-- Thêm hiệu ứng hover cho nút "Chuyển"
local originalColorChuyen = NutChuyen.BackgroundColor3
NutChuyen.MouseEnter:Connect(function()
    NutChuyen.BackgroundColor3 = Color3.fromRGB(20, 220, 20) -- Sáng hơn khi hover
end)
NutChuyen.MouseLeave:Connect(function()
    NutChuyen.BackgroundColor3 = originalColorChuyen -- Trở về màu gốc
end)

-- Lưu nội dung "Đơn" vào file riêng cho từng tài khoản
local tenFile = "DonText_" .. player.Name .. ".json" -- File sẽ có dạng DonText_tennguoichoi.json
local HttpService = game:GetService("HttpService")

-- Hàm lưu nội dung "Đơn" vào file
local function luuNoiDungDon()
    local noiDung = ODon.Text
    pcall(function()
        writefile(tenFile, HttpService:JSONEncode({don = noiDung}))
        print("Đã lưu nội dung Đơn vào file " .. tenFile .. ": " .. noiDung)
    end)
end

-- Hàm tải nội dung "Đơn" từ file
local function taiNoiDungDon()
    local noiDung = "............" -- Giá trị mặc định nếu không có file
    pcall(function()
        if isfile(tenFile) then
            local data = HttpService:JSONDecode(readfile(tenFile))
            noiDung = data.don or "TUSHITA"
        end
    end)
    ODon.Text = noiDung
end

-- Khi nội dung "Đơn" thay đổi, tự động lưu vào file
ODon:GetPropertyChangedSignal("Text"):Connect(function()
    luuNoiDungDon()
end)

-- Nút "Xóa" để xóa nội dung "Đơn" và cập nhật file
NutXoa.MouseButton1Click:Connect(function()
    ODon.Text = ""
    luuNoiDungDon()
end)

-- Chuyển server theo ID
local TeleportService = game:GetService("TeleportService")
NutChuyen.MouseButton1Click:Connect(function()
    local serverId = OServer.Text
    if serverId and serverId ~= "" then
        -- Chuyển đến server theo ID
        TeleportService:TeleportToPlaceInstance(game.PlaceId, serverId, player)
    else
        warn("Vui lòng nhập ID Server hợp lệ!")
    end
end)

-- Tải nội dung "Đơn" từ file khi script chạy
taiNoiDungDon()

print("Hack Blox Fruits đã chạy! Menu BananaHub đã được mở.")
