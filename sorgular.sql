--Sorgu 1:Ankara'dan 2023-08-01 tarihinden önce kayit olan müþteriler
select * from musteri
where sehir='Ankara' and kayit_tarihi<'2023-08-01'

--Sorgu 2:Hangi þehirden kaç müþteri var
select sehir,count(*) as MusteriSayisi from musteri
group by sehir;

--Sorgu 3:Müþteri id 1 olan müþterinin ödeyeceði toplam tutar
select sum(toplam_tutar) as odenecek_tutar from siparis
where musteri_id='1'

--Sorgu 4:En fazla tutarda sipariþ veren ilk 3 müþteri
select top 3 m.ad, m.soyad, s.id as siparis_id , s.tarih, s.toplam_tutar from musteri m
inner join siparis s on m.id = s.musteri_id
order by toplam_tutar desc;

--Sorgu 5:Ödeme türü kredi kartý ve toplam tutarý 650 TL'den fazla olan müþteriler 
select m.ad, m.soyad, s.id as siparis_id , s.odeme_turu, s.toplam_tutar from musteri m
inner join siparis s on m.id = s.musteri_id
where odeme_turu='Kredi Kartý' and toplam_tutar>'650'

--Sorgu 6:Ödeme türüne toplam satýþ sayýsý ve tutar
select odeme_turu, count(*) as siparis_sayisi,sum(toplam_tutar) as toplam_ücret from siparis
group by odeme_turu;

--Sorgu 7:Ýsminde m harfi geçen müþterilerin ad,soyad,þehir,ödeme türü ve toplam tutar bilgileri
select m.ad,m.soyad,m.sehir,s.odeme_turu,s.toplam_tutar from siparis s
inner join musteri m on m.id=s.musteri_id
where ad like '%m%';

--Sorgu 8:Sipariþi veren müþterinin adý,soyadý ve sipariþteki ürün bilgileri
select m.ad,m.soyad,u.ad,sd.adet,sd.fiyat from siparis s
inner join musteri m on m.id=s.musteri_id
inner join siparisdetay sd on s.id=sd.siparis_id
inner join urun u on sd.urun_id=u.id;

--Sorgu 9:Birden fazla sipariþ veren müþteri bilgileri(ayrý sipariþler oluþturan)
select m.ad,m.soyad,m.id,count(s.id) as siparis_sayilari from siparis s
inner join musteri m on m.id=s.musteri_id
group by m.ad,m.soyad,m.id 
having count(s.id)>1;

--Sorgu 10:Tüm sipariþlerinin tutarý 750 TL'den fazla olan müþteriler (sipariþ ücreti çoktan aza doðru)
select m.ad,m.soyad,m.id,sum(s.toplam_tutar) as siparis_ucreti from siparis s
inner join musteri m on m.id=s.musteri_id
group by m.ad,m.soyad,m.id 
having sum(s.toplam_tutar)>750
order by sum(s.toplam_tutar) desc;

--Sorgu 11:Ürün isminde l harfi geçen ve stoðu 45'ten fazla olan ürün bilgileri
select * from urun
where ad like '%l%' and stok>45;

--Sorgu 12:Kategori id'ye göre toplam stok (stoklar azdan çoða doðru)
select kategori_id,sum(stok) as toplam_stok from urun
group by kategori_id
order by toplam_stok asc;

--Sorgu 13:En fazla tutarda sipariþ olan 3 þehir ve toplam tutar bilgisi
select top 3 m.sehir , s.toplam_tutar from musteri m
inner join siparis s on m.id = s.musteri_id
order by toplam_tutar desc;

--Sorgu 14:Þehirlere göre toplam sipariþ ücretleri
select m.sehir,sum(s.toplam_tutar) as siparis_ucreti from siparis s
inner join musteri m on m.id=s.musteri_id
group by m.sehir;

--Sorgu 15:Stoðu 50'den az olan ürün sipariþi veren müþteriler
select m.ad,m.soyad,u.stok from musteri m 
inner join siparis s on m.id=s.musteri_id
inner join siparisdetay sd on s.id=sd.siparis_id
inner join urun u on sd.urun_id = u.id
where stok<'50';

--Sorgu 16:Hiç sipariþ verilmemiþ ürünler
select u.id,u.ad as urun_adý from urun u
left join siparisdetay sd on sd.urun_id = u.id
where sd.urun_id is null;

--Sorgu 17:Toplam harcamasý en düþük müþteri
select top 1 m.ad,m.soyad,m.id,sum(s.toplam_tutar) as siparis_ucreti from siparis s
inner join musteri m on m.id=s.musteri_id
group by m.ad,m.soyad,m.id 
order by sum(s.toplam_tutar) asc;

--Sorgu 18:Kategori id'ye göre toplam ürün çeþidi
select k.id as kategori_id,k.ad as urun_adi,count(u.id) as urun_cesidi from kategori k
inner join urun u on u.kategori_id=k.id
group by k.id,k.ad;

--Sorgu 19:En pahalý ürün ve satýcýsý
select top 1 u.fiyat as urun_fiyati,u.ad as urun_adi,s.ad as satici_adi from urun u
inner join satici s on s.id=u.satici_id
group by u.fiyat,u.ad,s.ad
order by u.fiyat desc;

--Sorgu 20: Tüm ürünlerin adý,fiyatý ve kategori adý
select u.ad as urun_adi,u.fiyat as urun_fiyati,k.ad as kategori_adi from urun u
inner join kategori k on k.id=u.kategori_id
group by u.ad,u.fiyat,k.ad;

--Sorgu 21:Elektronik kategorisindeki ürünler
select u.ad as urun_adi,k.ad as kategori_adi from urun u
inner join kategori k on k.id=u.kategori_id
where k.ad='Elektronik';

--Sorgu 22:2023 yýlý Temmuz ayýndaki sipariþler
select * from siparis
where tarih between '2023-07-01' and '2023-07-31';

--Sorgu 23:Ýstanbul'daki müþterilerin toplam sipariþ tutarý
select sum(s.toplam_tutar) as toplam_tutar from musteri m
inner join siparis s on m.id=s.musteri_id
where m.sehir='Ýstanbul';

--Sorgu 24:2023 yýlýnýn ilk 6 ayýndaki sipariþ veren müþteriler
select m.ad,m.soyad,s.tarih from musteri m
inner join siparis s on m.id=s.musteri_id
where tarih between '2023-01-01' and '2023-06-30';

--Sorgu 25:100'den fazla stok olan ürünlerin kategorileri
select distinct k.ad as kategori_adi,u.stok from kategori k
inner join urun u on u.kategori_id=k.id
where u.stok>100;
 
--Sorgu 26:Kapýda ödeme yapan müþteriler ve ödedikleri tutar
select m.ad,m.soyad,s.toplam_tutar from musteri m
inner join siparis s on m.id=s.musteri_id
where odeme_turu='Kapýda Ödeme';

--Sorgu 27:En pahalý ürün ve kategorisi
select top 1 u.ad as urun_adi,k.ad as kategori_adi,u.fiyat from kategori k
inner join urun u on k.id=u.kategori_id
group by u.ad,k.ad,u.fiyat
order by u.fiyat desc;

--Sorgu 28:Satýcý adresi Ýstanbul olan ürünler
select u.ad as urun_adi,s.adres as satici_adres from urun u
inner join satici s on u.satici_id=s.id
where s.adres='Ýstanbul';

--Sorgu 29:Kategori adýna göre toplam ürün stoðu
select k.ad as urun_adi,sum(u.stok) as urun_stogu from kategori k
inner join urun u on u.kategori_id=k.id
group by k.ad;

--Sorgu 30:Þehrin ismi i ile baþlayan müþteriler
select ad,soyad,sehir from musteri
where sehir like 'i%'

--Sorgu 31:Toplam harcamasý 1000 TL'nin üzerinde olan müþteriler ve ödeme türleri
select m.ad,m.soyad,sum(s.toplam_tutar) as toplam_harcama,s.odeme_turu from musteri m
inner join siparis s on m.id=s.musteri_id
group by m.ad,m.soyad,s.odeme_turu
having sum(s.toplam_tutar)>1000
order by toplam_harcama desc;

--Sorgu 32:En pahalý sipariþi veren müþteri bilgisi
select top 1 m.ad,m.soyad,m.sehir,s.toplam_tutar from musteri m
inner join siparis s on s.musteri_id=m.id
group by m.ad,m.soyad,m.sehir,s.toplam_tutar
order by s.toplam_tutar desc;

--Sorgu 33:Fiyatý 1000 TL'den yüksek olan ürünlerin ortalama fiyatý
select avg(fiyat) as ortalama_fiyat from urun
where fiyat>1000;

--Sorgu 34:2023 yýlýnýn 6. ayýndan sonra sipariþ veren müþterilerin adý ve soyadý
select distinct m.ad,m.soyad from  musteri m
inner join siparis s on m.id=s.musteri_id
where s.tarih>'2023-06-30';

--Sorgu 35:Moda Dünyasý satýcýsýnýn sattýðý ürünlerin adýný, fiyatýný ve stok miktarý
select u.ad as urun_adi,u.fiyat,u.stok from urun u
inner join satici s on u.satici_id=s.id
where s.ad='Moda Dünyasý';