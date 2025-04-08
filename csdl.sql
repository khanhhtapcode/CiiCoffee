create database QuanLyQuanCafe2



-- Bảng Quê
CREATE TABLE Que (
    MaQue INT IDENTITY(1,1) PRIMARY KEY,
    TenQue NVARCHAR(100) NOT NULL
);

-- Bảng Công dụng
CREATE TABLE CongDung (
    MaCongDung INT IDENTITY(1,1) PRIMARY KEY,
    TenCongDung NVARCHAR(100) NOT NULL
);

-- Bảng Loại sản phẩm
CREATE TABLE Loai (
    MaLoai INT IDENTITY(1,1) PRIMARY KEY,
    TenLoai NVARCHAR(100) NOT NULL
);

-- Bảng Nhân viên
CREATE TABLE NhanVien (
    MaNV INT IDENTITY(1,1) PRIMARY KEY,
    TenNV NVARCHAR(100) NOT NULL,
    DiaChi NVARCHAR(255),
    GioiTinh NVARCHAR(10),
    NgaySinh DATE,
    SDT NVARCHAR(15),
    MaQue INT,
	HinhAnh VARBINARY(MAX),
    FOREIGN KEY (MaQue) REFERENCES Que(MaQue)
);
 ALTER TABLE NhanVien ADD Anh VARBINARY(MAX);
 
-- Bảng Khách hàng
CREATE TABLE KhachHang (
    MaKH INT IDENTITY(1,1) PRIMARY KEY,
    DiaChi NVARCHAR(255)
);

-- Bảng Nhà cung cấp
CREATE TABLE NhaCungCap (
    MaNCC INT IDENTITY(1,1) PRIMARY KEY,
    TenNCC NVARCHAR(100) NOT NULL,
    DiaChi NVARCHAR(255),
    SDT NVARCHAR(15)
);
alter table NhaCungCap add Mota nvarchar(100)
-- Bảng Sản phẩm
CREATE TABLE SanPham (
    MaSP INT IDENTITY(1,1) PRIMARY KEY,
    TenSP NVARCHAR(100) NOT NULL,
    MaLoai INT,
    GiaNhap DECIMAL(18,2),
    GiaBan DECIMAL(18,2),
    SoLuong INT,
    MaCongDung INT,
    HinhAnh VARBINARY(MAX),
    FOREIGN KEY (MaLoai) REFERENCES Loai(MaLoai),
    FOREIGN KEY (MaCongDung) REFERENCES CongDung(MaCongDung)
);

-- Bảng Hóa đơn bán hàng
CREATE TABLE HoaDonBan (
    MaHDB INT IDENTITY(1,1) PRIMARY KEY,
    NgayBan DATE,
    MaNV INT,
    MaKH INT,
    TongTien DECIMAL(18,2),
    FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV),
    FOREIGN KEY (MaKH) REFERENCES KhachHang(MaKH)
);

-- Bảng Chi tiết hóa đơn bán
CREATE TABLE ChiTietHDB (
    MaCTHDB INT IDENTITY(1,1) PRIMARY KEY,
    MaHDB INT,
    MaSP INT,
    SoLuong INT,
    ThanhTien DECIMAL(18,2),
    KhuyenMai NVARCHAR(50),
    FOREIGN KEY (MaHDB) REFERENCES HoaDonBan(MaHDB),
    FOREIGN KEY (MaSP) REFERENCES SanPham(MaSP)
);

-- Bảng Hóa đơn nhập hàng
CREATE TABLE HoaDonNhap (
    MaHDN INT IDENTITY(1,1) PRIMARY KEY,
    NgayNhap DATE,
    MaNV INT,
    MaNCC INT,
    TongTien DECIMAL(18,2),
    FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV),
    FOREIGN KEY (MaNCC) REFERENCES NhaCungCap(MaNCC)
);

-- Bảng Chi tiết hóa đơn nhập hàng
CREATE TABLE ChiTietHDN (
    MaCTHDN INT IDENTITY(1,1) PRIMARY KEY,
    MaHDN INT,
    MaSP INT,
    SoLuong INT,
    DonGia DECIMAL(18,2),
    ThanhTien DECIMAL(18,2),
    KhuyenMai NVARCHAR(50),
    FOREIGN KEY (MaHDN) REFERENCES HoaDonNhap(MaHDN),
    FOREIGN KEY (MaSP) REFERENCES SanPham(MaSP)
);

-- Bảng Tài Khoản
CREATE TABLE TaiKhoan (
    MaTK INT IDENTITY(1,1) PRIMARY KEY,
    TenDangNhap NVARCHAR(50) UNIQUE NOT NULL,
    MatKhau NVARCHAR(255) NOT NULL,
    LoaiTaiKhoan NVARCHAR(20) CHECK (LoaiTaiKhoan IN ('Admin', 'NhanVien')),
    MaNV INT,
    FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV) ON DELETE SET NULL
);
INSERT INTO Que (TenQue) 
VALUES 
(N'Hà Nội'),
(N'TP Hồ Chí Minh'),
(N'Đà Nẵng'),
(N'Quảng Ninh'),
(N'Bắc Giang'),
(N'Hải Phòng'),
(N'Thái Bình'),
(N'Nam Định'),
(N'Vĩnh Phúc'),
(N'Bắc Ninh');


--Cong Dung
INSERT INTO CongDung (TenCongDung) 
VALUES 
(N'Giải khát'),
(N'Giúp tỉnh táo'),
(N'Giảm căng thẳng'),
(N'Tăng cường sức đề kháng'),
(N'Tăng cường sự tập trung'),
(N'Cung cấp năng lượng'),
(N'Giải nhiệt'),
(N'Tăng cường hệ miễn dịch'),
(N'Giảm stress'),
(N'Tăng cường sức khỏe tim mạch');

--Loại
INSERT INTO Loai (TenLoai) 
VALUES 
(N'Cà phê đen'),
(N'Cà phê sữa'),
(N'Trà xanh'),
(N'Trà đen'),
(N'Bánh ngọt'),
(N'Nước ép trái cây'),
(N'Sinh tố'),
(N'Bánh mì'),
(N'Sữa chua'),
(N'Pudding');


--Nhan Vien
INSERT INTO NhanVien (TenNV, DiaChi, GioiTinh, NgaySinh, SDT, MaQue, HinhAnh) 
VALUES 
(N'Nguyễn Văn A', N'123 Đống Đa, Hà Nội', N'Nam', '1990-05-10', '0123456789', 1, NULL),
(N'Trần Thị B', N'456 Quận 1, TP.HCM', N'Nữ', '1995-07-15', '0987654321', 2, NULL),
(N'Lê Quang C', N'789 Quận 3, TP.HCM', N'Nam', '1993-04-25', '0912345678', 3, NULL),
(N'Phạm Thị D', N'321 Ba Đình, Hà Nội', N'Nữ', '1988-06-30', '0918765432', 4, NULL),
(N'Vũ Quang E', N'654 Cầu Giấy, Hà Nội', N'Nam', '1992-11-10', '0981234567', 5, NULL),
(N'Hồ Minh F', N'987 Thanh Xuân, Hà Nội', N'Nam', '1985-02-20', '0901237890', 6, NULL),
(N'Ngô Thị G', N'654 Hoàng Mai, Hà Nội', N'Nữ', '1991-10-12', '0976543210', 7, NULL),
(N'Trương Minh H', N'432 Tân Bình, TP.HCM', N'Nam', '1987-03-05', '0912223344', 8, NULL),
(N'Phan Thị I', N'123 Quận 7, TP.HCM', N'Nữ', '1994-08-18', '0934567890', 9, NULL),
(N'Đặng Minh J', N'321 Hoàn Kiếm, Hà Nội', N'Nam', '1996-01-10', '0901122334', 10, NULL);

--Khach Hang
INSERT INTO KhachHang (DiaChi) 
VALUES 
(N'789 Ba Đình, Hà Nội'),
(N'321 Bình Thạnh, TP.HCM'),
(N'123 Cầu Giấy, Hà Nội'),
(N'456 Hoàng Mai, Hà Nội'),
(N'987 Thanh Xuân, TP.HCM'),
(N'654 Quận 3, TP.HCM'),
(N'432 Tân Bình, TP.HCM'),
(N'321 Hoàn Kiếm, Hà Nội'),
(N'111 Hà Đông, Hà Nội'),
(N'555 Phú Nhuận, TP.HCM');


--Nha Cung CXap
INSERT INTO NhaCungCap (TenNCC, DiaChi, SDT, Mota) 
VALUES 
(N'Công ty A', N'Quận 1, TP.HCM', '0901234567', N'Sản xuất cà phê'),
(N'Công ty B', N'Quận Cầu Giấy, Hà Nội', '0912345678', N'Sản xuất trà'),
(N'Công ty C', N'Quận 10, TP.HCM', '0923456789', N'Sản xuất bánh ngọt'),
(N'Công ty D', N'Quận 2, TP.HCM', '0934567890', N'Sản xuất sữa chua'),
(N'Công ty E', N'Quận 7, TP.HCM', '0945678901', N'Sản xuất nước ép trái cây'),
(N'Công ty F', N'Quận Hoàn Kiếm, Hà Nội', '0956789012', N'Sản xuất sinh tố'),
(N'Công ty G', N'Quận 3, TP.HCM', '0967890123', N'Sản xuất pudding'),
(N'Công ty H', N'Quận 4, TP.HCM', '0978901234', N'Sản xuất bánh mì'),
(N'Công ty I', N'Quận 5, TP.HCM', '0989012345', N'Sản xuất cà phê'),
(N'Công ty J', N'Quận 6, TP.HCM', '0990123456', N'Sản xuất trà đen');

----San Pham
INSERT INTO SanPham (TenSP, MaLoai, GiaNhap, GiaBan, SoLuong, MaCongDung, HinhAnh) 
VALUES 
(N'Cà phê Arabica', 1, 50000, 70000, 100, 1, NULL),
(N'Cà phê Robusta', 2, 40000, 60000, 150, 2, NULL),
(N'Trà xanh', 3, 30000, 45000, 200, 1, NULL),
(N'Trà đen', 4, 25000, 35000, 180, 2, NULL),
(N'Bánh ngọt', 5, 20000, 30000, 120, 3, NULL),
(N'Nước ép cam', 6, 15000, 20000, 250, 1, NULL),
(N'Sinh tố bơ', 7, 25000, 35000, 130, 2, NULL),
(N'Bánh mì thịt', 8, 15000, 20000, 170, 3, NULL),
(N'Sữa chua', 9, 10000, 15000, 220, 4, NULL),
(N'Pudding socola', 10, 12000, 17000, 200, 2, NULL);

--Hoa Don Ban
INSERT INTO HoaDonBan (NgayBan, MaNV, MaKH, TongTien) 
VALUES 
('2024-03-25', 1, 1, 140000),
('2024-03-26', 2, 2, 120000),
('2024-03-27', 3, 3, 160000),
('2024-03-28', 4, 4, 180000),
('2024-03-29', 5, 5, 200000),
('2024-03-30', 6, 6, 220000),
('2024-03-31', 7, 7, 240000),
('2024-04-01', 8, 8, 260000),
('2024-04-02', 9, 9, 280000),
('2024-04-03', 10, 10, 300000);

--Chi tiet hoa don ban 
INSERT INTO ChiTietHDB (MaHDB, MaSP, SoLuong, ThanhTien, KhuyenMai) 
VALUES 
(6, 6, 3, 60000, N'Giảm 10%'),
(7, 7, 4, 140000, N'Giảm 5%'),
(8, 8, 5, 100000, N'Không giảm'),
(9, 9, 6, 90000, N'Giảm 10%'),
(10, 10, 7, 119000, N'Không giảm');

--Hoa Don Bán
INSERT INTO HoaDonBan (NgayBan, MaNV, MaKH, TongTien) 
VALUES 
('2024-04-01', 1, 1, 350000),
('2024-04-02', 2, 2, 420000),
('2024-04-03', 1, 1, 500000),
('2024-04-04', 2, 2, 550000),
('2024-04-05', 1, 2, 650000),
('2024-04-06', 2, 1, 700000),
('2024-04-07', 1, 1, 800000),
('2024-04-08', 2, 2, 450000),
('2024-04-09', 1, 2, 900000),
('2024-04-10', 2, 1, 1000000);

--Hóa đơn nhập
INSERT INTO HoaDonNhap (NgayNhap, MaNV, MaNCC, TongTien) 
VALUES 
('2024-04-01', 1, 1, 200000),
('2024-04-02', 2, 2, 250000),
('2024-04-03', 1, 1, 300000),
('2024-04-04', 2, 2, 350000),
('2024-04-05', 1, 1, 400000),
('2024-04-06', 2, 2, 450000),
('2024-04-07', 1, 1, 500000),
('2024-04-08', 2, 2, 550000),
('2024-04-09', 1, 1, 600000),
('2024-04-10', 2, 2, 650000);

--Chi tiêt hóa đo nanhapj
INSERT INTO ChiTietHDN (MaHDN, MaSP, SoLuong, DonGia, ThanhTien, KhuyenMai) 
VALUES 
(1, 1, 10, 20000, 200000, N'Giảm 5%'),
(2, 2, 15, 25000, 375000, N'Không giảm'),
(3, 3, 8, 30000, 240000, N'Giảm 10%'),
(4, 4, 12, 35000, 420000, N'Không giảm'),
(5, 5, 10, 40000, 400000, N'Giảm 5%'),
(6, 6, 5, 45000, 225000, N'Giảm 10%'),
(7, 7, 7, 50000, 350000, N'Không giảm'),
(8, 8, 10, 55000, 550000, N'Giảm 5%'),
(9, 9, 12, 60000, 720000, N'Giảm 10%'),
(10, 10, 15, 65000, 975000, N'Không giảm');

--Tai Khoan 
INSERT INTO TaiKhoan (TenDangNhap, MatKhau, LoaiTaiKhoan, MaNV) 
VALUES 
(N'admin', N'1', N'Admin', NULL),
(N'admin2', N'password', N'Admin', NULL),
(N'nv1', N'12345', N'NhanVien', 1),
(N'nv2', N'abcde', N'NhanVien', 2),
(N'nv3', N'admin123', N'NhanVien', 1),
(N'nv4', N'password456', N'NhanVien', 2),
(N'nv5', N'qwerty', N'NhanVien', 1),
(N'nv6', N'zxcvbn', N'NhanVien', 2),
(N'nv7', N'qwerty123', N'NhanVien', 1),
(N'nv8', N'pass12345', N'NhanVien', 2);


EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;

EXEC sp_configure 'Ad Hoc Distributed Queries', 1;
RECONFIGURE;

INSERT INTO NhanVien (TenNV, DiaChi, GioiTinh, NgaySinh, SDT, MaQue, Anh)
SELECT 
    N'Nguyễn Văn A', 
    N'123 Đường ABC, TP.HCM', 
    N'Nam', 
    '1990-01-01', 
    '0912345678', 
    1,  
    BulkColumn
FROM OPENROWSET(BULK 'D:\Study\C#\Cuoiki\Picture\avt.png', SINGLE_BLOB) AS AnhFile;

-- Cập nhật cột Anh trong bảng NhanVien


UPDATE NhanVien
SET HinhAnh = (SELECT BulkColumn FROM OPENROWSET(BULK 'D:\Study\C#\Cuoiki\Picture\avt.png', SINGLE_BLOB) AS img)
WHERE HinhAnh IS NOT NULL;

