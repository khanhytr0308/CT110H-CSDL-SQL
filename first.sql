USE sql_learning;

CREATE TABLE PHICONG(
	MPC VARCHAR(50) PRIMARY KEY,
    hoten VARCHAR(50) not null,
    diachi VARCHAR(50) not null,
    quocgia VARCHAR(50) default 'VietNam'
);

CREATE TABLE CONGTY(
	MCT VARCHAR(50) PRIMARY KEY,
    tencty VARCHAR(50) not null,
    quocgia VARCHAR(50) default 'VietNam'
);

CREATE TABLE LOAIMAYBAY(
	loai VARCHAR(50) PRIMARY KEY,
    NhaSX VARCHAR(50) not null,
    socho INT CHECK (socho > 0)
);

CREATE TABLE MAYBAY(
	MMB VARCHAR(50) PRIMARY KEY,
	loai VARCHAR(50) not null,
    MCT VARCHAR(50) not null,
    foreign key (loai) references LOAIMAYBAY(loai),
    foreign key (MCT) references CONGTY(MCT)
);

CREATE TABLE CHUYENBAY(
	SOCB VARCHAR(50) not null,
    ngaybay VARCHAR(50) not null,
    MPC VARCHAR(50) not null,
    MMB VARCHAR(50) not null,
    noidi VARCHAR(50) not null,
    noiden VARCHAR(50) not null,
    khoangcach VARCHAR(50) not null,
    gioden VARCHAR(50) not null,
    giodi VARCHAR(50) not null,
    PRIMARY KEY (SOCB, ngaybay),
    foreign key (MPC) references PHICONG(MPC),
    foreign key (MMB) references MAYBAY(MMB)
);

CREATE TABLE LAMVIEC(
	MPC VARCHAR(50) not null,
    MCT VARCHAR(50) not null,
    ngayBD VARCHAR(50) not null,
    songay VARCHAR(50) not null,
    PRIMARY KEY (MPC, MCT, ngayBD),
    foreign key (MPC) references PHICONG(MPC),
    foreign key (MCT) references CONGTY(MCT)
);

INSERT INTO PHICONG(MPC, hoten, diachi, quocgia)
VALUES
('PC01', 'hoai linh', 'saigon', 'VietNam'),
('PC02', 'thanh do', 'Ha Noi', 'VietNam');

INSERT INTO CONGTY(MCT, tencty)
VALUES
('CT01', 'Vietnam Airlines'),
('CT02', 'Bamboo Airways');

INSERT INTO LOAIMAYBAY(loai, NhaSX, socho)
VALUES
('A320', 'Airbus', 180),
('B737', 'Boeing', 160);

INSERT INTO MAYBAY(MMB, loai, MCT)
VALUES
('MB01', 'A320', 'CT01'),
('MB02', 'B737', 'CT02');

INSERT INTO CHUYENBAY(SOCB, ngaybay, MPC, MMB, noidi, noiden, khoangcach, giodi, gioden)
VALUES
('VN001', '20 THANG 4', 'PC01', 'MB01', 'CAN THO', 'HA NOI', '1000KM', '14H', '16H'),
('VN002', '20 THANG 4', 'PC02', 'MB02', 'CAN THO', 'TOKYO', '6000KM', '15H', '21H');

INSERT INTO LAMVIEC(MPC, MCT, ngayBD, songay)
VALUES
('PC01', 'CT01', '18 THANG 4 NAM 2007', '6.930 NGAY'),
('PC02', 'CT02', '12 THANG 9 NAM 2007', '6.938 NGAY');
