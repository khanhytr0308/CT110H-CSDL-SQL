use film;

select count(*)
from film;

SELECT COUNT(*) AS tong_so_dong,
    MIN(idFilm) AS id_nho_nhat,
    MAX(idFilm) AS id_lon_nhat
FROM film;

-- cau 1
-- Danh sách tất cả các bộ phim có khinh phí lớn hơn 1 triệu
select f.tua, f.kinhphi
from film f 
where f.kinhphi > 1000000;

-- cau 2
-- Tên Loại của bộ phim tựa 'IMPORTANCE OF BEING ERNEST'
select L.tenloai
from Loai L
join LOAIPHIM LP on LP.idLoai = L.idLoai
join film f on f.idFilm = lp.idFilm
where f.tua like "%IMPORTANCE OF BEING ERNEST%";


-- cau 3 Tựa và kinh phí của các bộ phim thuộc thể loại 'SCIENCE FICTION' và có kinh phí lớn
-- hơn 800,000 và nhỏ hơn 1 triệu. Sắp kết quả tăng dần theo kinh phí.

select f.tua, f.kinhphi
from film f
join loaiphim lp on lp.idFilm = f.idFilm
join loai l on l.idloai = lp.idloai
where l.tenloai like '%SCIENCE FICTION%' and f.kinhphi >= 800000 and f.kinhphi < 1000000;

-- cau 4 
-- Tên đầy đủ (ghép họ và tên), thù lao của các diễn viên đã tham gia bộ phim 'MARK OF
-- THE DEVIL'. Sắp kết quả giảm dần theo thù lao
select concat(c.ho, ' ' ,c.ten), d.thulao
from canhan c
join dienvien d on d.idcn = c.idcn
join film f on f.idfilm = d.idfilm
where f.tua = 'MARK OF THE DEVIL'
order by d.thulao desc;

-- cau 5
-- Tên đầy đủ (ghép họ và tên) của người đã thực hiện bộ phim 'ONCE A THIEF'
select concat(c.ho, ' ' ,c.ten) as hoten
from canhan C
join dienvien d on d.idcn = C.idcn
join film f on f.idfilm = d.idfilm
where f.tua = 'ONCE A THIEF';

-- cau 6
-- Tên các bộ phim bao gồm từ 'IMPOSSIBLE'
select f.tua
from film f
where f.tua like '%IMPOSSIBLE%';

-- cau 7
-- Thông tin về các bộ phim do viễn viên 'WILDE CORNEL' đóng. Sắp kết quả tăng dần
-- theo họ và tên người thực hiện.

select * 
from film f
join dienvien d on d.idFilm = f.idFilm
join CANHAN c on c.idCN = d.idCN
join canhan c2 on f.nguoithuchien = c2.idCN
where c.ho like "%WILDE%" and c.ten like "%CORNEL%"
order by c2.ho asc, c2.ten asc;

-- cau 8
-- Tựa các bộ phim do 'WILSON HUGH'
select f.tua
from film f 
join dienvien d on d.idfilm = f.idfilm
join canhan c on c.idcn = d.idCN
join canhan c2 on c2.idcn = f.nguoithuchien
where c2.ho = "WILSON" and c2.ten = "HUGH";