create database eticaret

create table musteri(
id int PRIMARY KEY identity(1,1),
ad nvarchar(100),
soyad nvarchar(100),
email nvarchar(100),
sehir nvarchar(100),
kayit_tarihi date,
);
create table urun(
id int PRIMARY KEY,
ad nvarchar(100), 
fiyat decimal(10,2),
stok int,
kategori_id int,
satici_id int,
);
create table kategori(
id int PRIMARY KEY,
ad nvarchar(100),
);
create table satici(
id int PRIMARY KEY,
ad nvarchar(100),
adres nvarchar(max),
);
create table siparis(
id int PRIMARY KEY,
musteri_id int,
tarih date,
toplam_tutar decimal(10,2),
odeme_turu nvarchar(50),
);
create table siparisdetay(
id int PRIMARY KEY,
siparis_id int,
urun_id int,
adet int,
fiyat decimal(10,2),
);

insert into musteri(ad,soyad,email,sehir,kayit_tarihi) 
values('Elif', 'Demir', 'elif.demir@gmail.com', 'Ankara', '2023-01-12'),
('Mehmet', 'Kaya', 'mehmet.kaya@gmail.com', 'Ýstanbul', '2023-02-05'),
('Fatma', 'Yýlmaz', 'fatma.yilmaz@gmail.com', 'Ýzmir', '2023-03-10'),
('Ali', 'Çelik', 'ali.celik@gmail.com', 'Ýstanbul', '2023-04-18'),
('Zeynep', 'Þahin', 'zeynep.sahin@gmail.com', 'Ankara', '2023-05-22'),
('Hasan', 'Aydýn', 'hasan.aydin@gmail.com', 'Antalya', '2023-06-01'),
('Ýrem', 'Koç', 'irem.koc@gmail.com', 'Ankara', '2023-06-15'),
('Ahmet', 'Öztürk', 'ahmet.ozturk@gmail.com', 'Ankara', '2023-07-03'),
('Merve', 'Arslan', 'merve.arslan@gmail.com', 'Sivas', '2023-07-20'),
('Yusuf', 'Kurt', 'yusuf.kurt@gmail.com', 'Ýstanbul', '2023-08-08');

insert into urun(id,ad,fiyat,stok,kategori_id,satici_id) 
values(100, 'Akýllý Telefon', 18000.00, 50, 1, 1),
(101, 'Bluz', 450.00, 200, 2, 2),
(102, 'Kahve Makinesi', 1900.00, 30, 3, 3),
(103, 'Okuma Kitabý', 200.00, 100, 4, 4),
(104, 'Bilgisayar', 15000.00, 25, 1, 1),
(105, 'Pantolon', 300.00, 150, 2, 2),
(106, 'Blender', 750.00, 40, 3, 3),
(107, 'Roman', 100.00, 300, 4, 4),
(108, 'Akýllý Saat', 2500.00, 75, 1, 1),
(109, 'Elbise', 450.00, 90, 2, 2),
(110, 'Kulaklýk', 500.00, 500, 1, 1);

insert into kategori(id,ad)
values(1, 'Elektronik'),
(2, 'Giyim'),
(3, 'Ev Eþyasý'),
(4, 'Kitap');

insert into satici(id,ad,adres)
values(1, 'Teknoloji Market', 'Ýstanbul'),
(2,'Moda Dünyasý', 'Ankara'),
(3,'Evim Güzel Evim', 'Ýzmir'),
(4,'Kitapçým', 'Ýstanbul');

insert into siparis(id,musteri_id,tarih,toplam_tutar,odeme_turu)
values(1001, 1, '2023-01-20', 2500.00, 'Kredi Kartý'),
(1002, 2, '2023-02-25', 15000.00, 'Havale'),
(1003, 1, '2023-03-01', 300.00, 'Kredi Kartý'),
(1004, 3, '2023-03-15', 650.00, 'Kapýda Ödeme'),
(1005, 4, '2023-04-10', 18000.00, 'Kredi Kartý'),
(1006, 5, '2023-05-15', 300.00, 'Havale'),
(1007, 7, '2023-07-05', 750.00, 'Kredi Kartý'),
(1008, 6, '2023-07-10', 2500.00, 'Kredi Kartý'),
(1009, 9, '2023-10-05', 450.00, 'Kapýda Ödeme'),
(1010, 10, '2023-10-03', 500.00, 'Kredi Kartý'),
(1011, 6, '2023-10-08', 1900.00, 'Kredi Kartý'),
(1012, 8, '2023-09-08', 100, 'Kredi Kartý');

insert into siparisdetay(id, siparis_id, urun_id,adet,fiyat)
values(1, 1001, 108, 1, 2500.00),
(2, 1002, 104, 1, 15000.00),
(3, 1003, 105, 1, 300.00),
(4, 1004, 101, 1, 450.00),
(5, 1004, 103, 1, 250.00),
(6, 1005, 100, 1, 18000.00),
(7, 1006, 105, 1, 300.00),
(8, 1007, 101, 1, 450.00),
(9, 1007, 105, 1, 300.00),
(10, 1008, 108, 1, 2500.00),
(11, 1009, 101, 1, 450.00),
(12, 1010, 110, 1, 500.00),
(13, 1011, 102, 1, 1900.00),
(14, 1012, 107, 1, 100.00);

UPDATE musteri
SET sehir = 'Bursa' 
WHERE id = 4; 

UPDATE urun
SET stok = 300
WHERE fiyat BETWEEN 300 and 500; 

UPDATE urun
SET stok = urun.stok - sd.adet
FROM urun
INNER JOIN siparisdetay sd ON urun.id = sd.urun_id;





