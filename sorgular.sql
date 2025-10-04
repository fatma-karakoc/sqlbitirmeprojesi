--Sorgu 1:Ankara'dan 2023-08-01 tarihinden �nce kayit olan m��teriler
select * from musteri
where sehir='Ankara' and kayit_tarihi<'2023-08-01'

--Sorgu 2:Hangi �ehirden ka� m��teri var
select sehir,count(*) as MusteriSayisi from musteri
group by sehir;

--Sorgu 3:M��teri id 1 olan m��terinin �deyece�i toplam tutar
select sum(toplam_tutar) as odenecek_tutar from siparis
where musteri_id='1'

--Sorgu 4:En fazla tutarda sipari� veren ilk 3 m��teri
select top 3 m.ad, m.soyad, s.id as siparis_id , s.tarih, s.toplam_tutar from musteri m
inner join siparis s on m.id = s.musteri_id
order by toplam_tutar desc;

--Sorgu 5:�deme t�r� kredi kart� ve toplam tutar� 650 TL'den fazla olan m��teriler 
select m.ad, m.soyad, s.id as siparis_id , s.odeme_turu, s.toplam_tutar from musteri m
inner join siparis s on m.id = s.musteri_id
where odeme_turu='Kredi Kart�' and toplam_tutar>'650'

--Sorgu 6:�deme t�r�ne toplam sat�� say�s� ve tutar
select odeme_turu, count(*) as siparis_sayisi,sum(toplam_tutar) as toplam_�cret from siparis
group by odeme_turu;

--Sorgu 7:�sminde m harfi ge�en m��terilerin ad,soyad,�ehir,�deme t�r� ve toplam tutar bilgileri
select m.ad,m.soyad,m.sehir,s.odeme_turu,s.toplam_tutar from siparis s
inner join musteri m on m.id=s.musteri_id
where ad like '%m%';

--Sorgu 8:Sipari�i veren m��terinin ad�,soyad� ve sipari�teki �r�n bilgileri
select m.ad,m.soyad,u.ad,sd.adet,sd.fiyat from siparis s
inner join musteri m on m.id=s.musteri_id
inner join siparisdetay sd on s.id=sd.siparis_id
inner join urun u on sd.urun_id=u.id;

--Sorgu 9:Birden fazla sipari� veren m��teri bilgileri(ayr� sipari�ler olu�turan)
select m.ad,m.soyad,m.id,count(s.id) as siparis_sayilari from siparis s
inner join musteri m on m.id=s.musteri_id
group by m.ad,m.soyad,m.id 
having count(s.id)>1;

--Sorgu 10:T�m sipari�lerinin tutar� 750 TL'den fazla olan m��teriler (sipari� �creti �oktan aza do�ru)
select m.ad,m.soyad,m.id,sum(s.toplam_tutar) as siparis_ucreti from siparis s
inner join musteri m on m.id=s.musteri_id
group by m.ad,m.soyad,m.id 
having sum(s.toplam_tutar)>750
order by sum(s.toplam_tutar) desc;

--Sorgu 11:�r�n isminde l harfi ge�en ve sto�u 45'ten fazla olan �r�n bilgileri
select * from urun
where ad like '%l%' and stok>45;

--Sorgu 12:Kategori id'ye g�re toplam stok (stoklar azdan �o�a do�ru)
select kategori_id,sum(stok) as toplam_stok from urun
group by kategori_id
order by toplam_stok asc;

--Sorgu 13:En fazla tutarda sipari� olan 3 �ehir ve toplam tutar bilgisi
select top 3 m.sehir , s.toplam_tutar from musteri m
inner join siparis s on m.id = s.musteri_id
order by toplam_tutar desc;

--Sorgu 14:�ehirlere g�re toplam sipari� �cretleri
select m.sehir,sum(s.toplam_tutar) as siparis_ucreti from siparis s
inner join musteri m on m.id=s.musteri_id
group by m.sehir;

--Sorgu 15:Sto�u 50'den az olan �r�n sipari�i veren m��teriler
select m.ad,m.soyad,u.stok from musteri m 
inner join siparis s on m.id=s.musteri_id
inner join siparisdetay sd on s.id=sd.siparis_id
inner join urun u on sd.urun_id = u.id
where stok<'50';

--Sorgu 16:Hi� sipari� verilmemi� �r�nler
select u.id,u.ad as urun_ad� from urun u
left join siparisdetay sd on sd.urun_id = u.id
where sd.urun_id is null;

--Sorgu 17:Toplam harcamas� en d���k m��teri
select top 1 m.ad,m.soyad,m.id,sum(s.toplam_tutar) as siparis_ucreti from siparis s
inner join musteri m on m.id=s.musteri_id
group by m.ad,m.soyad,m.id 
order by sum(s.toplam_tutar) asc;

--Sorgu 18:Kategori id'ye g�re toplam �r�n �e�idi
select k.id as kategori_id,k.ad as urun_adi,count(u.id) as urun_cesidi from kategori k
inner join urun u on u.kategori_id=k.id
group by k.id,k.ad;

--Sorgu 19:En pahal� �r�n ve sat�c�s�
select top 1 u.fiyat as urun_fiyati,u.ad as urun_adi,s.ad as satici_adi from urun u
inner join satici s on s.id=u.satici_id
group by u.fiyat,u.ad,s.ad
order by u.fiyat desc;

--Sorgu 20: T�m �r�nlerin ad�,fiyat� ve kategori ad�
select u.ad as urun_adi,u.fiyat as urun_fiyati,k.ad as kategori_adi from urun u
inner join kategori k on k.id=u.kategori_id
group by u.ad,u.fiyat,k.ad;

--Sorgu 21:Elektronik kategorisindeki �r�nler
select u.ad as urun_adi,k.ad as kategori_adi from urun u
inner join kategori k on k.id=u.kategori_id
where k.ad='Elektronik';

--Sorgu 22:2023 y�l� Temmuz ay�ndaki sipari�ler
select * from siparis
where tarih between '2023-07-01' and '2023-07-31';

--Sorgu 23:�stanbul'daki m��terilerin toplam sipari� tutar�
select sum(s.toplam_tutar) as toplam_tutar from musteri m
inner join siparis s on m.id=s.musteri_id
where m.sehir='�stanbul';

--Sorgu 24:2023 y�l�n�n ilk 6 ay�ndaki sipari� veren m��teriler
select m.ad,m.soyad,s.tarih from musteri m
inner join siparis s on m.id=s.musteri_id
where tarih between '2023-01-01' and '2023-06-30';

--Sorgu 25:100'den fazla stok olan �r�nlerin kategorileri
select distinct k.ad as kategori_adi,u.stok from kategori k
inner join urun u on u.kategori_id=k.id
where u.stok>100;
 
--Sorgu 26:Kap�da �deme yapan m��teriler ve �dedikleri tutar
select m.ad,m.soyad,s.toplam_tutar from musteri m
inner join siparis s on m.id=s.musteri_id
where odeme_turu='Kap�da �deme';

--Sorgu 27:En pahal� �r�n ve kategorisi
select top 1 u.ad as urun_adi,k.ad as kategori_adi,u.fiyat from kategori k
inner join urun u on k.id=u.kategori_id
group by u.ad,k.ad,u.fiyat
order by u.fiyat desc;

--Sorgu 28:Sat�c� adresi �stanbul olan �r�nler
select u.ad as urun_adi,s.adres as satici_adres from urun u
inner join satici s on u.satici_id=s.id
where s.adres='�stanbul';

--Sorgu 29:Kategori ad�na g�re toplam �r�n sto�u
select k.ad as urun_adi,sum(u.stok) as urun_stogu from kategori k
inner join urun u on u.kategori_id=k.id
group by k.ad;

--Sorgu 30:�ehrin ismi i ile ba�layan m��teriler
select ad,soyad,sehir from musteri
where sehir like 'i%'

--Sorgu 31:Toplam harcamas� 1000 TL'nin �zerinde olan m��teriler ve �deme t�rleri
select m.ad,m.soyad,sum(s.toplam_tutar) as toplam_harcama,s.odeme_turu from musteri m
inner join siparis s on m.id=s.musteri_id
group by m.ad,m.soyad,s.odeme_turu
having sum(s.toplam_tutar)>1000
order by toplam_harcama desc;

--Sorgu 32:En pahal� sipari�i veren m��teri bilgisi
select top 1 m.ad,m.soyad,m.sehir,s.toplam_tutar from musteri m
inner join siparis s on s.musteri_id=m.id
group by m.ad,m.soyad,m.sehir,s.toplam_tutar
order by s.toplam_tutar desc;

--Sorgu 33:Fiyat� 1000 TL'den y�ksek olan �r�nlerin ortalama fiyat�
select avg(fiyat) as ortalama_fiyat from urun
where fiyat>1000;

--Sorgu 34:2023 y�l�n�n 6. ay�ndan sonra sipari� veren m��terilerin ad� ve soyad�
select distinct m.ad,m.soyad from  musteri m
inner join siparis s on m.id=s.musteri_id
where s.tarih>'2023-06-30';

--Sorgu 35:Moda D�nyas� sat�c�s�n�n satt��� �r�nlerin ad�n�, fiyat�n� ve stok miktar�
select u.ad as urun_adi,u.fiyat,u.stok from urun u
inner join satici s on u.satici_id=s.id
where s.ad='Moda D�nyas�';