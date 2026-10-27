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

-- cau 9
-- Họ tên cá nhân đã tham gia ít nhất 1 bộ phim do họ thực hiện

select distinct concat(c.ho, ' ' ,c.ten) as hoten
from canhan c 
join dienvien d on d.idCN = c.idCN
join film f on f.idFilm  = d.idFilm
join canhan c2 on c2.id
where c.idcn = f.nguoithuchien;

-- cau 10 
-- Họ tên cá nhân đã tham gia ít nhất 10 bộ phim do họ thực hiện

select distinct concat(c.ho, ' ' ,c.ten) as hoten, count(f.idFilm) as sofilm
from canhan c 
join dienvien d on d.idcn = c.idcn
join film f on f.idfilm = d.idfilm
where c.idcn = f.nguoithuchien
group by c.idcn, c.ho, c.ten
having count(f.idfilm) >= 10;

-- cau 11
-- Tổng thù lao đã trả cho bộ phim 'TALE OF TWO CITIES'
select sum(d.thulao) as tong
from dienvien d 
join film f on f.idfilm = d.idfilm
where f.tua = 'TALE OF TWO CITIES';


-- cau 12
-- Số phim mỗi thể loại
select l.tenloai, count(lp.idfilm) as sophim
from loaiphim lp
join loai l on l.idloai = lp.idloai
group by l.tenloai;

-- cau 13
-- Tên loại có nhiều phim nhất
select l.tenloai, count(lp.idfilm) as sophim
from loaiphim lp
join loai l on l.idloai = lp.idloai
group by l.tenloai
having count(lp.idfilm) in (
    select max(sophim)
    from (
        select count(lp.idfilm) as sophim
        from loaiphim lp
        group by idloai
    ) as bangdem
);

-- cau 14
-- kinh phí trung bình của phim theo người thực hiện

select concat(c.ho, ' ' ,c.ten) as hoten, avg(f.kinhphi) as trungbinh
from canhan c 
join film f on f.nguoithuchien = c.idcn
group by c.idcn;


-- cau 15 
-- Họ tên người thực hiện đã thực hiện hơn 50 bộ phim

select concat(c.ho, ' ' ,c.ten) as hoten, count(f.idfilm) as sophim
from canhan c 
join dienvien d on d.idcn = c.idcn 
join film f on f.idfilm = d.idfilm
group by c.idcn, c.ho, c.ten
having count(f.idfilm) >= 50;

-- cau 16
-- Họ tên người thực hiện thực hiện nhiều phim nhất
select concat(c.ho, ' ' ,c.ten) as hoten, count(f.idfilm) as sophim 
from canhan c 
join film f on f.nguoithuchien = c.idcn
group by c.idcn
having count(f.idfilm) = (
    select max(sophim)
    from (
        select count(f.idFilm) as sophim
        from film f
        group by f.nguoithuchien
    ) as bangtam
);

-- cau 17
-- Họ tên diễn viên đã tham gia hơn 50 bộ phim
select concat(c.ho, ' ' ,c.ten) as hoten, count(d.idfilm) as sophim
from canhan c 
join dienvien d on d.idcn = c.idcn
join film f on f.idfilm = d.idfilm
group by c.idcn, c.ho, c.ten 
having count(d.idfilm) >= 50;

-- cau 18
-- Họ tên diễn viên tham gia nhiều phim nhất
select concat(c.ho, ' ' ,c.ten) as hoten, count(d.idfilm) as sophim
from canhan c 
join dienvien d on d.idcn = c.idcn
group by c.idcn, c.ho, c.ten
having count(d.idfilm) = (
    select max(sophim)
    from (
        select count(d.idfilm) as sophim
        from dienvien d 
        group by d.idcn
    ) as bang
);

-- cau 19
-- Tên bộ phim có kinh phí thực hiện cao nhất

select tua, kinhphi
from film
where kinhphi = (
	select max(kinhphi)
    from film
);

-- cau 20
-- Tên bộ phim có kinh phí thực hiện thấp nhất
select tua, kinhphi
from film
where kinhphi = (
    select min(kinhphi)
    from film
);

