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
select M.idloai, M.idmay, L.tenloai
from May M
join Loai L on M.idloai = L.idloai 
where idmay = 'p8';

-- cau 2
select * from Phanmem
where idloai = 'UNIX';

-- cau 3
select P.tenphong, P.IP, M.MP
from Phong P
join May M on P.MP = M.MP
where idloai = 'UNIX' or 'PCWS';

-- cau 4
select P.tenphong, P.IP, M.MP
from Phong P 
join May M on P.MP = M.IP
where M.IP = '130.120.80'
ORDER BY P.MP desc;

-- cau 5
select count(*) as so_luong_phan_mem
from Caidat
where idMay = 'p6';

-- cau 6
select count(*) as so_cac_may
from caidat 
where idPM = 'log1';

-- cau 7
select tenmay, IP
from May
where idLoai = 'TX';

-- cau 8
select c.idMay, count(c.idPM) as so_luong
from Caidat c
group by c.idMay;

-- cau 9
select P.tenphong, count(M.idMay) as so_luong
from Phong P
left join May M on M.MP = P.MP
group by P.tenphong;

-- cau 10
select M.idMay, count(C.idPM) as so_luong_cai_dat
from May M
left join Caidat C on C.idMay = M.idMay
group by M.idMay;

-- cau 11
select avg(gia) as gia_avg_unix
from Phanmem
where idloai = 'UNIX';

-- cau 12
select max(ngaymua) as ngay_mua_gan_nhat
from phanmem;

-- cau 13
select idMay, count(idPM) as may_tren_2PM
from caidat
group by idMay
having count(idPM) >= 2;

-- cau 14
select count(*) from(
    select idMay, count(idPM)
    from caidat
    group by idMay
    having count(idPM) >= 2
) as so_may;

-- cau 15
select L.idLoai
from Loai L
left join May M
    on M.idLoai = l.idLoai
where M.idLoai is null;

-- cau 16 
select distinct L.idLoai
from Loai L 
inner join Phanmem PM on PM.idLoai = L.idLoai
inner join May M on M.idLoai = L.idLoai;

-- cau 17
select M.idLoai
from May M 
left join Phanmem P on P.idLoai = M.idLoai
where P.idLoai is null;

-- cau 18
select M.IP 
from May M
where M.idMay in (
	select C.idMay
    from Caidat C 
    where C.idPM = 'log6'
);

-- cau 19
select M.IP
from May M
where M.idMay in (
	select C.idMay
    from Caidat C
    where C.idMay = 'Oracle 8'
);

-- cau 20
select K.tenkhuvuc
from Khuvuc K
where K.IP in (
	select M.IP
    from May M
    where M.idLoai = 'TX'
	GROUP BY M.IP
	HAVING COUNT(M.idMay) = 3
);

-- cau 21
select P.tenphong
from Phong P
where P.MP in (
	select M.MP
    from May M
	where M.idMay in (
		select C.idMay
        from Caidat C
        where C.idPM in (
			select PM.idPM
			from Phanmem PM
            where PM.tenPM = 'Oracle 6'
            )
		)
);

-- cau 22
select PM.tenPM
from Phanmem PM
where PM.ngaymua in(
	select max(ngaymua) as ngay_mua_gan_nhat
	from phanmem
);

-- cau 23
select M.IP
from May M
join Caidat C on C.idMay = M.idMay
where C.idPM = 'log6';

-- cau 24
select M.IP
from May M
join Phanmem PM on PM.idLoai = M.idLoai
where PM.tenPM = 'Oracle 8';

-- cau 25
select K.tenkhuvuc
from Khuvuc K
join May M on M.IP = K.IP
where M.idLoai = 'TX'
group by M.IP 
having count(*) >= 3;

-- cau 26
SELECT P.tenphong
FROM Phong P
JOIN May M ON M.MP = P.MP
JOIN Caidat C ON C.idMay = M.idMay
JOIN Phanmem PM ON PM.idPM = C.idPM
WHERE PM.tenPM = 'Oracle 6'
GROUP BY P.MP, P.tenphong
HAVING COUNT(*) = 1;

-- cau 27
select distinct C.idMay
from Caidat C 
where C.idPM in (
    select idPM
    from Caidat 
    where idMay = 'p6'
)
and C.idMay <> 'p6';

-- cau 28
select tenPM
from phanmem
where idLoai = 'PCNT'
and gia > any (
    select gia 
    from Phanmem
    where idLoai = 'UNIX'
);

-- cau 29
select tenPM
from phanmem
where idLoai = 'UNIX'
and gia > all (
    select gia
    from Phanmem
    where idLoai = 'PCNT'
);

-- cau 30
SELECT DISTINCT C.idMay
FROM Caidat C
WHERE C.idMay <> 'p6'
AND NOT EXISTS (
    SELECT *
    FROM Caidat P6
    WHERE P6.idMay = 'p6'
    AND NOT EXISTS (
        SELECT *
        FROM Caidat X
        WHERE X.idMay = C.idMay
        AND X.idPM = P6.idPM
    )
);

-- cau 31
SELECT DISTINCT C.idMay
FROM Caidat C
WHERE C.idMay <> 'p2'

AND NOT EXISTS (
    SELECT *
    FROM Caidat P2
    WHERE P2.idMay = 'p2'
    AND NOT EXISTS (
        SELECT *
        FROM Caidat X
        WHERE X.idMay = C.idMay
        AND X.idPM = P2.idPM
    )
)

AND NOT EXISTS (
    SELECT *
    FROM Caidat X
    WHERE X.idMay = C.idMay
    AND NOT EXISTS (
        SELECT *
        FROM Caidat P2
        WHERE P2.idMay = 'p2'
        AND P2.idPM = X.idPM
    )
);


