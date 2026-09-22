USE sql_learning;
-- cau 1.
CREATE TABLE Khuvuc(
    IP VARCHAR(50) PRIMARY KEY,
    tenkhuvuc VARCHAR(50) not null,
    tang int
);

CREATE TABLE Loai(
    idloai VARCHAR(50) PRIMARY KEY,
    tenloai VARCHAR(50) not null
);

CREATE TABLE phong(
    MP VARCHAR(50) PRIMARY KEY,
    tenphong VARCHAR(50) not null,
    somay VARCHAR(50),
    IP VARCHAR(50),
    foreign key (IP) references Khuvuc(IP)
);

CREATE TABLE May(
    idMay VARCHAR(50) PRIMARY KEY,
    tenmay VARCHAR(50) not null,
    IP VARCHAR(50),
    ad INT CHECK (ad >= 0 AND ad <= 255),
    idloai VARCHAR(50),
    MP VARCHAR(50),
    foreign key (MP) references phong(MP),
    foreign key (IP) references Khuvuc(IP),
    foreign key (idloai) references Loai(idloai)
);

CREATE TABLE Phanmem(
    idPM VARCHAR(50) PRIMARY KEY,
    tenPM VARCHAR(50) not null,
    ngaymua date,
    version VARCHAR(50), 
    idloai VARCHAR(50),
    gia int,
    foreign key (idloai) references Loai(idloai)
);

CREATE TABLE Caidat(
    id VARCHAR(50) PRIMARY KEY,
    idMay VARCHAR(50),
    idPM VARCHAR(50),
    ngaycai date DEFAULT (CURRENT_DATE),
    foreign key (idMay) references May(idMay),
    foreign key (idPM) references Phanmem(idPM)
);

-- cau 2
INSERT INTO Khuvuc(IP, tenkhuvuc)
VALUES
('130.120.80', 'Brin RDC'),
('130.120.81', 'Brin'),
('130.120.82', 'Brin');

INSERT INTO Loai(idLoai, tenloai)
VALUES
('TX', 'Terminal X-Window'),
('UNIX', 'SySteme Unix'),
('PCNT', 'PC Windows NT'),
('PCWS', 'PC Wiindows'),
('NC', 'Network Computer');

INSERT INTO Phong(MP, tenphong, somay, IP)
VALUES
('s01', 'Salle 1', 3, '130.120.80'),
('s02', 'Salle 2', 2, '130.120.80'),
('s03', 'Salle 3', 3, '130.120.80'),
('s011', 'Salle 11', 2, '130.120.81'),
('s012', 'Salle 12', 1, '130.120.81'),
('s021', 'Salle 21', 2, '130.120.82'),
('s022', 'Salle 22', 0, '130.120.82'),
('s023', 'Salle 23', 0, '130.120.82');

INSERT INTO May(idMay, tenmay, IP, ad, idLoai, MP)
VALUES
('p1', 'Poste 1', '130.120.80', 01, 'TX', 's01'),
('p2', 'Poste 2', '130.120.80', 02, 'UNIX', 's01'),
('p3', 'Poste 3', '130.120.80', 03, 'TX', 's01'),
('p4', 'Poste 4', '130.120.80', 04, 'PCWS', 's02'),
('p5', 'Poste 5', '130.120.80', 05, 'PCWS', 's02'),
('p6', 'Poste 6', '130.120.80', 06, 'UNIX', 's03'),
('p7', 'Poste 7', '130.120.80', 07, 'TX', 's03'),
('p8', 'Poste 8', '130.120.81', 01, 'UNIX', 's011'),
('p9', 'Poste 9', '130.120.81', 02, 'TX', 's011'),
('p10', 'Poste 10', '130.120.81', 03, 'UNIX', 's012'),
('p11', 'Poste 11', '130.120.82', 01, 'PCNT', 's021'),
('p12', 'Poste 12', '130.120.82', 02, 'PCWS', 's021');

INSERT INTO Phanmem(idPM, tenPM, ngaymua, version, idloai, gia)
VALUES
('log1', 'Oracle 6', '1995-05-13', '6.2', 'UNIX', 3000),
('log2', 'Oracle 8', '1999-09-15', '8i', 'UNIX', 5600),
('log3', 'SQL Server', '1998-04-12', '7', 'PCNT', 2700),
('log4', 'Front Page', '1997-06-03', '5', 'PCWS', 500),
('log5', 'WinDev', '1997-05-12', '5', 'PCWS', 750),
('log6', 'SQL*Net', null, '2,0', 'UNIX', 500),
('log7', 'I. I. S.', '2002-04-12', '2', 'PCNT', 810),
('log8', 'DreamWeaver', '2003-09-21', '2.0', 'PCNT', 1400);

INSERT INTO Caidat(idMay, idPM, id, ngaycai)
VALUES
('p2', 'log1', 1, '2003-05-15'),
('p2', 'log2', 2, '2003-09-17'),
('p4', 'log5', 3, DEFAULT),
('p6', 'log6', 4, '2003-05-20'),
('p6', 'log1', 5, '2003-05-20'),
('p8', 'log2', 6, '2003-05-19'),
('p8', 'log6', 7, '2003-05-20'),
('p11', 'log3', 8, '2003-04-20'),
('p12', 'log4', 9, '2003-04-20'),
('p11', 'log7', 10, '2003-04-20'),
('p7', 'log7', 11, '2002-04-01');

-- cau 1
select M.idMay, M.tenmay, L.tenloai
from May M
join Loai L on M.idloai = L.idloai
where M.idMay = 'p8';

-- cau 2
select * from Phanmem
where idLoai = 'UNIX';

--cau 3

select P.tenphong, P.IP, P.MP
from phong P
join May M on P.MP = M.MP
where M.idLoai =  'UNIX' OR M.idLoai = 'PCWS';


-- cau 4
SELECT DISTINCT P.tenphong, P.IP, P.MP
FROM phong P
JOIN May M ON P.MP = M.MP
WHERE (M.idLoai = 'UNIX' OR M.idLoai = 'PCWS')
  AND P.IP = '130.120.80'
ORDER BY P.MP desc;

-- cau 5
SELECT COUNT(*) AS so_luong_phan_mem
FROM Caidat
WHERE idMay = 'p6';

-- cau 6

select count(*) as soPMlog1
from Caidat
where idPM = 'log1';

-- cau 7
select P.IP, M.tenmay
from Phong P
join May M on P.IP = M.IP
where M.idLoai = 'TX';

-- cau 8
select avg(gia) as avg_unix
from Phanmem
where idLoai = 'UNIX';

-- cau 9
select P.tenphong
from Phong P
join May M on P.MP = M.MP
join Caidat C on M.idMay = C.idMay
join Phanmem PM on C.idPM = PM.idPM
where PM.tenPM like 'Oracle%';

-- cau 10
select distinct PM.tenPM
from Phanmem PM
join Caidat C on PM.idPM = C.idPM
join May M on M.idMay = C.idMay
join Phong P on P.MP = M.MP
where P.tenphong = 'Salle 1'; 

-- cau 11
select PM.tenPM
from Phanmem PM
where PM.ngaymua like '1997%';

-- cau 12

select tenPM
from Phanmem
where gia > 2000 and idloai = 'UNIX';
