CREATE TABLE Khuvuc(
    IP VARCHAR(50) PRIMARY KEY,
    tenkhuvuc VARCHAR(50) not null,
    tang VARCHAR(50)
);

CREATE TABLE phong(
    MP VARCHAR(50) PRIMARY KEY,
    tenphong VARCHAR(50) not null,
    somay VARCHAR(50) not null,
    IP VARCHAR(50),
    foreign key (IP) references Khuvuc(IP)
);

CREATE TABLE May(
    idMay VARCHAR(50) PRIMARY KEY,
    tenmay VARCHAR(50),
    IP VARCHAR(50),
    ad VARCHAR(50),
    idloai VARCHAR(50),
    MP VARCHAR(50),
    foreign key MP references phong(MP),
    foreign key ID references Khuvuc(IP)
);

CREATE TABLE Phanmen(
    idPM VARCHAR(50) PRIMARY KEY,
    tenPM VARCHAR(50) not null,
    ngaymua VARCHAR(50),
    version VARCHAR(50), 
    idloai VARCHAR(50),
    gia VARCHAR(50),
    foreign key idloai references May(idloai)
);

CREATE TABLE Caidat(
    id VARCHAR(50) PRIMARY KEY,
    idMay VARCHAR(50),
    idPM VARCHAR(50),
    ngaycai VARCHAR(50),
    foreign key idMay references May(idMay),
    foreign key idMPM references Phanmen(idPM)
);

CREATE TABLE Loai(
    idloai VARCHAR(50) PRIMARY KEY,
    tenloai VARCHAR(50)
);