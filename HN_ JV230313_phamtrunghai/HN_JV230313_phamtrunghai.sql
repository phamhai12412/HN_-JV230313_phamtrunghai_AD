create database HN_JV230313_phamtrunghai;
use HN_JV230313_phamtrunghai;
create table dmkhoa(
makhoa varchar (20) primary key,
tenkhoa  varchar(255)
);
create table dmnganh(
manganh int primary key,
tennganh varchar(255),
makhoa varchar(20),
foreign key (makhoa) references dmkhoa(makhoa)
);
create table dmlop(
malop varchar(20) primary key,
tenlop varchar(255),
manganh int,

khoahoc int,
hedt varchar(255),
namnhaphoc int,
foreign key (manganh) references dmnganh(manganh)
);
create table sinhvien(
masv int primary key,
hoten varchar(20),
malop varchar(20),
foreign key (malop) references dmlop(malop),
gioitinh tinyint(1),
ngaysinh date,
diachi varchar(255)
);
create table dmhocphan(
mahp int primary key,
tenhp varchar(255),
sodvht int,
manganh int,
foreign key (manganh) references dmnganh(manganh),
hocky int
);
create table diemhp(

masv int,
mahp int,
diemhp float,
foreign key (masv) references sinhvien(masv),
foreign key (mahp) references dmhocphan(mahp)
);
insert into dmkhoa (makhoa, tenkhoa)
values
    ('CNTT', 'Công nghệ thông tin'),
    ('KT', 'Kế Toán'),
    ('SP', 'Sư phạm');

insert into dmnganh (MaNganh, Tennganh, MaKhoa)
values
    (140902, 'Sư phạm toán tin', 'SP'),
    (480202, 'Tin học ứng dụng','CNTT');

insert into dmlop (MaLop, TenLop, MaNganh, KhoaHoc, HeDT, NamNhapHoc)
values
    ('CT11', 'Cao đẳng tin học', '480202', 11, 'TC', 2013),
    ('CT12', 'Cao đẳng tin học', '480202', 12, 'CĐ', 2013),
    ('CT13', 'Cao đẳng tin học', '480202', 13, 'TC', 2014);

insert into dmhocphan (MaHP, TenHP, Sodvht, MaNganh, Hocky)
values
    (1, 'Toán cấp cấp A1', 4, '480202', 1),
    (2, 'Tiếng Anh 1', 3, '480202', 1),
    (3, 'Vật lý đại cương', 4, '480202', 1),
    (4, 'Tiếng Anh 2', 7, '480202', 1),
    (5, 'Tiếng Anh 1', 3, '140902', 2),
    (6, 'Xác suất thống kê', 3, '480202', 2);

insert into sinhvien (MaSV, HoTen, MaLop, Gioitinh, NgaySinh, DiaChi)
values
    (1, 'Phan Thanh', 'CT12', 0, '1990-09-12', 'Tuy Phước'),
    (2, 'Nguyễn Thị Cẩm CT12', 'CT12', 1, '1994-01-12', 'Quy Nhơn'),
    (3, 'Võ Thị Hà', 'CT12', 1, '1995-07-02', 'An Nhơn'),
    (4, 'Trần Hoài Nam', 'CT12', 0, '1994-04-05', 'Tây Sơn'),
    (5, 'Trần Văn Hoàng', 'CT13', 0, '1995-08-04', 'Vĩnh Thạnh'),
    (6, 'Đặng Thị Thảo', 'CT13', 1, '1995-06-12', 'Quy Nhơn'),
    (7, 'Lê Thị Sen', 'CT13', 1, '1994-08-12', 'Phù Mỹ'),
    (8, 'Nguyễn Văn Huy CT11', 'CT11', 0, '1995-06-04', 'Tuy Phước'),
    (9, 'Trần Thị Hoa', 'CT11', 1, '1994-08-09', 'Hoài Nhơn');

insert into diemhp(masv,mahp,diemhp)values
(2,2,5.9),
(2,3,4.5),
(3,1,4.3),
(3,2,6.7),
(3,3,7.3),
(4,1,4),
(4,2,5.2),
(4,3,3.5),
(5,1,9.8),
(5,2,7.9),
(5,3,7.5),
(6,1,6.1),
(6,2,5.6),
(6,3,4),
(7,1,6.2);
-- 1.	 Cho biết họ tên sinh viên KHÔNG học học phần nào (5đ)
select masv ,hoten
from sinhvien
where masv not in (select distinct masv from diemhp);
-- 2.	Cho biết họ tên sinh viên CHƯA học học phần nào có mã 1 (5đ)
select masv
from sinhvien sv where masv not in (select distinct masv
from diemhp
where mahp=1);
-- 3.	Cho biết Tên học phần KHÔNG có sinh viên điểm HP <5. (5đ)
select  mahp, tenhp
from dmhocphan
where mahp not in (
    select mahp
    from diemhp
    where diemhp < 5
);
-- 4.	Cho biết Họ tên sinh viên KHÔNG có học phần điểm HP<5 (5đ)
select distinct sv.masv, sv.hoten
from sinhvien sv
where sv.masv not in (
    select distinct dh.masv
    from diemhp dh
    where dh.diemhp < 5
);
-- 5.	Cho biết Tên lớp có sinh viên tên Hoa (5đ)
select l.malop, l.tenlop
from dmlop l
join sinhvien sv on l.malop = sv.malop
where sv.hoten like '%Hoa';
-- 6.	Cho biết HoTen sinh viên có điểm học phần 1 là <5.
 select sv.masv, sv.hoten
    from diemhp dh
    join sinhvien sv on sv.masv=dh.masv
    where dh.diemhp < 5 and dh.mahp=1;
-- 7.	Cho biết danh sách các học phần có số đơn vị học trình lớn hơn hoặc bằng số đơn vị học trình của học phần mã 1.
    select *
from dmhocphan
where sodvht >= (select sodvht from dmhocphan where mahp = 1);
-- 8.	Cho biết HoTen sinh viên có DiemHP cao nhất. (ALL)
select sv.masv, sv.hoten, dhp.diemhp,dhp.mahp
from sinhvien sv
join diemhp dhp on dhp.masv= sv.masv
where dhp.diemhp = (
    select diemhp
    from diemhp
    order by diemhp desc
    LIMIT 1
);
-- 9.	Cho biết MaSV, HoTen sinh viên có điểm học phần mã 1 cao nhất. (ALL)
select distinct sv.masv, sv.hoten
from sinhvien sv
join diemhp dh on sv.masv = dh.masv
where dh.mahp = 1 and dh.diemhp =(select diemhp
from diemhp dh
where dh.mahp = 1
order by dh.diemhp desc
limit 1);
-- 10.	Cho biết MaSV, MaHP có điểm HP lớn hơn bất kì các điểm HP của sinh viên mã 3 (ANY).
select dh.masv, dh.mahp
from diemhp dh
where dh.diemhp > any (
    select dh2.diemhp
    from diemhp dh2
    where dh2.masv = 3
);
-- 11.	Cho biết MaSV, HoTen sinh viên ít nhất một lần học học phần nào đó. (EXISTS)
select sv.masv, sv.hoten
from sinhvien sv
where exists (
    select 1
    from diemhp dh
    where dh.masv = sv.masv
);
-- 12.	Cho biết MaSV, HoTen sinh viên đã không học học phần nào. (EXISTS)
select sv.masv, sv.hoten
from sinhvien sv
where not exists (
    select 1
    from diemhp dh
    where dh.masv = sv.masv
);
-- 13.	Cho biết MaSV đã học ít nhất một trong hai học phần có mã 1, 2. 
select distinct masv
from diemhp
where mahp in (1, 2);
-- 14.	Tạo thủ tục có tên KIEM_TRA_LOP cho biết HoTen sinh viên KHÔNG có điểm HP <5 ở lớp có mã chỉ định (tức là tham số truyền vào procedure là mã lớp). Phải kiểm tra MaLop chỉ định có trong danh mục hay không, nếu không thì hiển thị thông báo ‘Lớp này không có trong danh mục’. Khi lớp tồn tại thì đưa ra kết quả.
-- Ví dụ gọi thủ tục: Call KIEM_TRA_LOP(‘CT12’).

delimiter //

create procedure KIEM_TRA_LOP(in MaLop varchar(20))
begin
    declare count_result int;

    -- Kiểm tra lớp có tồn tại trong danh mục hay không
    select count(*) into count_result from dmlop where malop = MaLop;
    
    if count_result = 0 then
        select 'Lớp này không có trong danh mục';
    else
        -- Thực hiện kiểm tra sinh viên không có điểm HP < 5 trong lớp chỉ định
        select sv.HoTen
        from sinhvien sv
        where sv.malop = MaLop
        and not exists (
            select 1
            from diemhp dh
            where dh.masv = sv.masv
            and dh.diemhp < 5
        );
    end if;
end;

// delimiter ;
Call KIEM_TRA_LOP('CT12');



-- 15.	Tạo một trigger để kiểm tra tính hợp lệ của dữ liệu nhập vào bảng sinhvien là MaSV không được rỗng  Nếu rỗng hiển thị thông báo ‘Mã sinh viên phải được nhập’.
delimiter //
create trigger kiem_tra_masv_truoc_chen
before insert on sinhvien
for each row
begin
    if new.MaSV is null or new.MaSV ='' then
        signal sqlstate '45000'
        set message_text = 'Mã sinh viên phải được nhập';
    end if;
end;

// delimiter ;
-- Chèn dữ liệu có MaSV là null vào bảng sinhvien
insert into sinhvien (masv,hoten) values ( null,'Nguyen Van A');
-- ===============================
-- 16.	Tạo một TRIGGER khi thêm một sinh viên trong bảng sinhvien ở một lớp nào đó thì cột SiSo của lớp đó trong bảng dmlop 
-- (các bạn tạo thêm một cột SiSo trong bảng dmlop) tự động tăng lên 1, đảm bảo tính toàn vẹn dữ liệu khi thêm một sinh viên mới
-- trong bảng sinhvien thì sinh viên đó phải có mã lớp trong bảng dmlop.
--  Đảm bảo tính toàn vẹn dữ liệu khi thêm là mã lớp phải có trong bảng dmlop.
-- ===================================
-- 17.	Viết một function DOC_DIEM đọc điểm chữ số thập phân thành chữ  Sau đó ứng dụng để lấy ra:
--  MaSV, HoTen, MaHP, DiemHP, DOC_DIEM(DiemHP) để đọc điểm HP của sinh viên đó thành chữ
-- Tạo hàm DOC_DIEM để chuyển điểm số thành chữ
delimiter //

create function DOC_DIEM(p_diem float) returns varchar(255)
deterministic
begin
    declare v_integer_part int;
    declare v_decimal_part int;
    declare v_result varchar(255);
    set v_integer_part = floor(p_diem);
    set v_decimal_part = round((p_diem - v_integer_part) * 10);
    set v_result = concat(cast(v_integer_part as char), ' phẩy ', cast(v_decimal_part as char), ' điểm');
    return v_result;
end;
//

delimiter ;

-- Áp dụng hàm DOC_DIEM để lấy thông tin của sinh viên kèm theo điểm HP dưới dạng chữ
select sv.MaSV, sv.HoTen, dh.mahp, dh.diemhp, DOC_DIEM(dh.diemhp) as DiemChu
from sinhvien sv
join diemhp dh on sv.MaSV = dh.MaSV;
-- 18.	Tạo thủ tục: HIEN_THI_DIEM Hiển thị danh sách gồm MaSV, HoTen, MaLop, DiemHP, MaHP của những sinh viên có DiemHP nhỏ hơn số chỉ định, nếu không có thì hiển thị thông báo không có sinh viên nào.
-- VD: Call HIEN_THI_DIEM(5);
delimiter //
create procedure HIEN_THI_DIEM(in p_diemhp float)
begin
    declare v_count int;
    -- Kiểm tra số lượng sinh viên có DiemHP nhỏ hơn số chỉ định
    select count(*) into v_count
    from sinhvien sv
    join diemhp dh on sv.MaSV = dh.MaSV
    where dh.diemhp < p_diemhp;
    
    if v_count = 0 then
        select 'Không có sinh viên nào.';
    else
        -- Hiển thị danh sách sinh viên có DiemHP nhỏ hơn số chỉ định
        select sv.MaSV, sv.HoTen, sv.MaLop, dh.diemhp, dh.MaHP
        from sinhvien sv
        join diemhp dh on sv.MaSV = dh.MaSV
        where dh.diemhp < p_diemhp;
    end if;
end;

//
delimiter ;
Call HIEN_THI_DIEM(5);
-- 19.	Tạo thủ tục: HIEN_THI_MAHP hiển thị HoTen sinh viên CHƯA học học phần có mã chỉ định. 
-- Kiểm tra mã học phần chỉ định có trong danh mục không. Nếu không có thì hiển thị thông báo không có học phần này.
delimiter //

create procedure HIEN_THI_MAHP(in p_mahp int)
begin
    declare v_count int;
    
    -- Kiểm tra xem mã học phần chỉ định có trong danh mục không
    select count(*) into v_count
    from dmhocphan
    where mahp = p_mahp;
    
    if v_count = 0 then
        select 'Không có học phần này.' as thongbao;
    else
        -- Hiển thị HoTen của sinh viên chưa học học phần có mã chỉ định
        select distinct sv.hoten
        from sinhvien sv
        left join diemhp hp on hp.masv = sv.masv and hp.mahp =  p_mahp
        where hp.mahp is null;
        
    end if;
end;

//

delimiter ;

 Call HIEN_THI_MAHP(1);
-- 20.	Tạo thủ tục: HIEN_THI_TUOI  Hiển thị danh sách gồm: MaSV, HoTen, MaLop, NgaySinh, GioiTinh, Tuoi của sinh viên có tuổi trong khoảng chỉ định. 
-- Nếu không có thì hiển thị không có sinh viên nào.
-- VD: Call HIEN_THI_TUOI (20,30);
delimiter //

create procedure HIEN_THI_TUOI(in p_min_tuoi int, in p_max_tuoi int)
begin
    -- Kiểm tra xem có sinh viên nào thỏa mãn điều kiện hay không
    declare v_count int;
    select count(*) into v_count
    from sinhvien sv
    where TIMESTAMPDIFF(YEAR, sv.NgaySinh, CURDATE()) between p_min_tuoi and p_max_tuoi;

    -- Nếu có sinh viên thỏa mãn điều kiện, hiển thị danh sách sinh viên
    if v_count > 0 then
        select sv.MaSV, sv.HoTen, sv.MaLop, sv.NgaySinh, sv.GioiTinh,
               TIMESTAMPDIFF(YEAR, sv.NgaySinh, CURDATE()) as Tuoi
        from sinhvien sv
        where TIMESTAMPDIFF(YEAR, sv.NgaySinh, CURDATE()) between p_min_tuoi and p_max_tuoi;
    else
        -- Nếu không có sinh viên nào thỏa mãn điều kiện, hiển thị thông báo
        select 'Không có sinh viên nào.' as thongbao;
    end if;
end;

//

delimiter ;
Call HIEN_THI_TUOI (20,21);