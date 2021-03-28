CREATE DATABASE QuanLySieuThi;
USE QuanLySieuThi


--	xtype = U là định dạng bảng người dùng. 
IF NOT EXISTS(SELECT * FROM sysobjects WHERE name='tblLoaiHang' and xtype='U')
	CREATE TABLE tblLoaiHang(
		sMaLH			VARCHAR(10) PRIMARY KEY,
		sTenLoaihang	NVARCHAR(30)
	)

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='tblNhaCungCap' and xtype='U')
	CREATE TABLE tblNhaCungCap(
		iMaNCC				INT IDENTITY(1,1) PRIMARY KEY,
		sTenNhaCC			NVARCHAR(50),
		sDiaChi				NVARCHAR(100), 
		sSoDT				VARCHAR(15) UNIQUE
	)

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='tblMatHang' and xtype='U')
	CREATE TABLE tblMatHang(
		sMaHang			VARCHAR(10) PRIMARY KEY,
		sTenHang		NVARCHAR(30) NOT NULL,
		iMaNCC			INT NOT NULL,
		sMaLH			VARCHAR(10) NOT NULL,
		sNoiSX			NVARCHAR(100),
		fSoLuong		FLOAT DEFAULT 0,
		sDonViTinh		NVARCHAR(10),
		fGiaBan			FLOAT DEFAULT 0,
		CONSTRAINT FK_Mh_Lh FOREIGN KEY(sMaLH) REFERENCES tblLoaiHang(sMaLH),
		CONSTRAINT FK_Mh_Ncc FOREIGN KEY(iMaNCC) REFERENCES tblNhaCungCap(iMaNCC),
	)

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='tblChucVu' and xtype='U')
	CREATE TABLE tblChucVu(
		sMaCV			VARCHAR(10) PRIMARY KEY,
		sTenCV			NVARCHAR(30) NOT NULL
	)

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='tblNhanVien' and xtype='U')
	CREATE TABLE tblNhanVien(
		sMaNV			VARCHAR(10) PRIMARY KEY,
		sMaCV			VARCHAR(10) NOT NULL,
		sTenNV			NVARCHAR(50),
		sCMND			VARCHAR(15) UNIQUE,
		dNgaySinh		DATE,
		dNgayVaoLam		DATE DEFAULT getdate(),
		sDiaChi			NVARCHAR(100),
		sSoDT			VARCHAR(15),
		fLuongCB		FLOAT check(fLuongCB >0),
		fThuong			FLOAT DEFAULT 0,
		bTrangThai		BIT DEFAULT 1,
		CONSTRAINT FK_nv_cv	FOREIGN KEY (sMaCV) REFERENCES tblChucVu(sMaCV)
	)
/*
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='tblKhachHang' AND xtype='U')
	CREATE TABLE tblKhachHang(
		sMaKH		VARCHAR(10) PRIMARY KEY,
		sTenKH		NVARCHAR(30) NOT NULL,
		sSoDT		VARCHAR(15) UNIQUE,
		sCMND		VARCHAR(15) UNIQUE,
		sDiaChi		VARCHAR(100),
		dNgayTao	DATETIME DEFAULT GETDATE(),
		fDiem		FLOAT default 0,
	)*/


IF NOT EXISTS (SELECT * FROM sysobjects WHERE  name='tblHoaDon' AND xtype='U')
	CREATE TABLE tblHoaDon(
		iSoHD		INT PRIMARY KEY,
		dNgayBan	DATETIME DEFAULT GETDATE(),
		sMaNV		VARCHAR(10) NOT NULL,
		CONSTRAINT fk_Hd_nv	FOREIGN KEY(sMaNV) REFERENCES tblNhanVien(sMaNV)
	)

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='tblChiTietHoaDon' AND xtype='U')
	CREATE TABLE tblChiTietHoaDon(
		iSoHD		INT NOT NULL,
		sMaHH		VARCHAR(10) NOT NULl,
		fSoLuong	FLOAT CHECK(fSoLuong>0),
		fDonGia		FLOAT CHECK(fDonGia>0),
		fTiLeVAT	FLOAT DEFAULT 0,
		fGiamGia	FLOAT DEFAULT 0,
		fThanhTien	FLOAT DEFAULT 0,
		CONSTRAINT fk_cthd_hh FOREIGN KEY(sMaHH) REFERENCES tblMatHang(sMaHang),
		CONSTRAINT pk_chitiethoadon	PRIMARY KEY(iSoHD,sMaHH)
	)

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='tblPhieuNhap' AND xtype='U')
	CREATE TABLE tblPhieuNhap(
		iSoPN		INT PRIMARY KEY,
		iMaNCC		INT NOT NULL,
		dNgayNhap	DATETIME DEFAULT GETDATE(),
		sMaChungTu	VARCHAR(30),
		fTongTien	FLOAT DEFAULT 0,
		sMaNV		VARCHAR(10),
		CONSTRAINT fk_pn_ncc FOREIGN KEY(iMaNCC) REFERENCES tblNhaCungCap(iMaNCC),
		CONSTRAINT fk_pn_nv	 FOREIGN KEY(sMaNV)	REFERENCES tblNhanVien(sMaNV)
	)

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='tblChiTietPhieuNhap' AND xtype='U')
	CREATE TABLE tblChiTiePhieuNhap(
		iSoPN		INT NOT NULL ,
		sMaHH		VARCHAR(10) NOT NULL, 
		fSoLuong	FLOAT DEFAULT 0,
		fDonGia		FLOAT DEFAULT 0,
		CONSTRAINT fk_chitietphieunhap PRIMARY KEY(iSoPN,sMaHH)
	)


IF NOT EXISTS ( SELECT * FROM sysobjects WHERE  name='tblPhieuXuat' AND xtype='U')
	CREATE TABLE tblPhieuXuat(
		sMaPX		VARCHAR(10) PRIMARY KEY,
		sMaNV		VARCHAR(10) NOT NULL,
		dNgayXuat	DATETIME DEFAULT GETDATE(),
		CONSTRAINT pk_px_nv	FOREIGN KEY(sMaNV)	REFERENCES tblNhanVien(sMaNV)
	)

IF NOT EXISTS ( SELECT * FROM sysobjects WHERE  name='tblChiTietPhieuXuat' AND xtype='U')
	CREATE TABLE tblChiTietPhieuXuat(
		sMaPX		VARCHAR(10) NOT NULL,
		sMaHang		VARCHAR(10) NOT NULL,
		fSoLuong	FLOAT CHECK(fSoLuong >0)
		CONSTRAINT pk_chitietphieuxuat	PRIMARY KEY(sMaPX,sMaHang)
	)

IF NOT EXISTS ( SELECT * FROM sysobjects WHERE  name='tblQuyenTruyCap' AND xtype='U')
	CREATE TABLE tblQuyenTruyCap(
		sTenDangNhap		VARCHAR(30) PRIMARY KEY,
		sMatKhau			VARCHAR(50)
	)


/*=========================================================	INSERT DATA=======================================*/
SELECT * FROM tblLoaiHang;
INSERT INTO tblLoaiHang
VALUES	('LH1',N'Đồ Gia Dụng'),
		('LH2',N'Thực Phẩm'),
		('LH3',N'Thời Trang');

SELECT * FROM tblNhaCungCap;
INSERT INTO tblNhaCungCap (sTenNhaCC,sDiaChi,sSoDT)
VALUES	(N'Tống Văn Quý',N'Hà Tây','012347777'),
		(N'Đinh Huy Khánh',N'Bắc Giang','0383007888'),
		(N'Bùi Minh Tuấn',N'Hạ Long','0778787878'),
		(N'Phạm Xuân Vinh',N'Nam Định','0901012121')

SELECT * FROM tblChucVu;
INSERT INTO tblChucVu
VALUES	('CV1',N'Quản Lý'),
		('CV2',N'Nhân viên bán hàng'),
		('CV3',N'Nhân viên thu nhân'),
		('CV4',N'Nhân viên quản lý kho')

SELECT * FROM tblMatHang;
INSERT INTO  tblMatHang
VALUES	('MH1',N'Nồi cơm điện',1,'LH1',N'Việt Nam',0,N'cái',450000),
		('MH2',N'siêu tốc',1,'LH1',N'Việt Nam',0,N'cái',150000),
		('MH3',N'Rau cải',2,'LH2',N'Việt Nam',0,N'kg',15000),
		('MH4',N'Ức gà',2,'LH2',N'Việt Nam',0,N'cái',45000),
		('MH5',N'Quần jean nam',3,'LH3',N'Việt Nam',0,N'cái',250000),
		('MH6',N'Sơ mi',3,'LH3',N'Việt Nam',0,N'cái',150000)

SELECT * FROM tblNhanVien;
SELECT * FROM tblChucVu;


INSERT INTO  
tblNhanVien (sMaNV,sMaCV,sTenNV,sCMND,dNgaySinh,sDiaChi,sSoDT,fLuongCB)
VALUES ('NV1','CV2',N'Nguyên Văn Tèo','1223412','2001-01-01','Hoàng Mai','098831311',4500000),
		('NV2','CV1',N'Nguyễn Thị Ngọc','1223413','1998-06-28','Hà Đông','0977913099',6000000),
		('NV3','CV3',N'Tô Hoài An','1223414','1999-01-01','Hà Đông','098180101',5000000),
		('NV4','CV4',N'Dương Thừa Mạnh','1223415','2000-06-19','Mai Dịch','0913309988',4500000);

SELECT * FROM tblPhieuNhap
INSERT INTO tblPhieuNhap (iSoPN,iMaNCC,sMaNV)
VALUES  (1,1,'NV4'),
		(2,2,'NV4'),
		(3,3,'NV4');

SELECT * FROM tblChiTiePhieuNhap;
SELECT * FROM tblMatHang;

INSERT INTO tblChiTiePhieuNhap
VALUES	(1,'MH1',50,350000);
INSERT INTO tblChiTiePhieuNhap
VALUES (1,'MH2',50,100000);
INSERT INTO tblChiTiePhieuNhap
VALUES	(2,'MH3',30,7000);
INSERT INTO tblChiTiePhieuNhap
VALUES	(2,'MH4',100,30000);
INSERT INTO tblChiTiePhieuNhap
VALUES	(3,'MH5',100,150000);
INSERT INTO tblChiTiePhieuNhap
VALUES(3,'MH6',100,70000);

SELECT * FROM tblHoaDon;
INSERT INTO tblHoaDon(iSoHD,sMaNV)
VALUES		(1,'NV2'),
			(2,'NV2'),
			(3,'Nv3'),
			(4,'NV3');

SELECT * FROM tblChiTietHoaDon;
INSERT INTO tblChiTietHoaDon (iSoHD,sMaHH,fSoLuong,fTiLeVAT,fGiamGia)
VALUES	(1,'MH1',3,3,200000);

INSERT INTO tblChiTietHoaDon (iSoHD,sMaHH,fSoLuong,fTiLeVAT,fGiamGia)
VALUES	(1,'MH2',2,3,20000);

INSERT INTO tblChiTietHoaDon (iSoHD,sMaHH,fSoLuong,fTiLeVAT,fGiamGia)
VALUES	(2,'MH3',3,0,0);

INSERT INTO tblChiTietHoaDon (iSoHD,sMaHH,fSoLuong,fTiLeVAT,fGiamGia)
VALUES	(2,'MH4',3,0,0);
		
INSERT INTO tblChiTietHoaDon (iSoHD,sMaHH,fSoLuong,fTiLeVAT,fGiamGia)
VALUES (3,'MH5',3,0,5000);

INSERT INTO tblChiTietHoaDon (iSoHD,sMaHH,fSoLuong,fTiLeVAT,fGiamGia)
VALUES	(3,'MH6',3,0,5000);


/*==================================================TRIGGER===================================================*/
-- trigger khi nhập chi tiết hóa đơn
ALTER TRIGGER trgTblchitiethoadon
ON tblChiTietHoaDon
AFTER INSERT, UPDATE
AS 
	BEGIN 
		DECLARE @SoLuong	FLOAT,
				@DonGia		FLOAT,
				@VAT		FLOAT,
				@GiamGia	FLOAT,
				@ThanhTien	FLOAT,
				@soHD		FLOAT,
				@MaHH		VARCHAR(10)
		
		SELECT	@SoLuong = fSoluong,
				@VAT= fTiLeVAT,
				@GiamGia = fGiamGia,
				@soHD=iSoHD, 
				@MaHH = sMaHH
				FROM inserted;

		SELECT @DonGia = fGiaBan FROM tblMatHang WHERE sMaHang = @MaHH;
		SELECT @ThanhTien = @SoLuong*(@DonGia- @GiamGia)*(1+@VAT/100);

		UPDATE tblChiTietHoaDon 
		SET fDonGia = @DonGia
		WHERE iSoHD = @soHD AND sMaHH = @MaHH;


		UPDATE tblChiTietHoaDon 
		SET fThanhTien = @ThanhTien
		WHERE iSoHD = @soHD AND sMaHH = @MaHH;
		
		UPDATE tblMatHang 
		SET fSoLuong = a.fSoLuong - @SoLuong
		FROM tblMatHang a 
		WHERE a.sMaHang = @MaHH;
	END
-- trigger phiếu nhập
CREATE TRIGGER trgInsertPhieuNhap
ON dbo.tblChiTiePhieuNhap
FOR INSERT, UPDATE
AS
	BEGIN 
		DECLARE @SoLuong FLOAT, @MaHH VARCHAR(10), @Dongia FLOAT, @SoPN INT
		SELECT @SoLuong = fSoLuong, @MaHH = sMaHH , @Dongia = fDonGia , @SoPN = iSoPN FROM inserted
		UPDATE tblMatHang SET fSoLuong = a.fSoLuong + @SoLuong
				FROM tblMatHang a WHERE a.sMaHang=@MaHH;
		UPDATE tblPhieuNhap SET fTongTien = a.fTongTien + @Dongia*@SoLuong
					FROM tblPhieuNhap a
					WHERE a.iSoPN = @SoPN;
	END

/*==========================================================STORE PROCEDURE===================================*/


