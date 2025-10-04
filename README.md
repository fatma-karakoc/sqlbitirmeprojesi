#  E-Ticaret Veritabanı Projesi

## Proje Amacı

Bu veritabanı modeli, bir e-ticaret sisteminde:
- Müşteri bilgilerini,
- Ürün stok ve kategori detaylarını,
- Sipariş geçmişini,
- Satıcı bilgilerini  
takip edebilmek için tasarlanmıştır.

Veritabanı yapısı, hem raporlama hem de analiz amaçlı kullanılabilir.

---

## 🧩 Veritabanı Tabloları

### 1. `musteri`
| Alan Adı | Veri Tipi | Açıklama |
|-----------|------------|----------|
| id | INT (PK, IDENTITY) | Müşteri kimliği |
| ad | NVARCHAR(100) | Müşteri adı |
| soyad | NVARCHAR(100) | Müşteri soyadı |
| email | NVARCHAR(100) | E-posta adresi |
| sehir | NVARCHAR(100) | Müşteri şehri |
| kayit_tarihi | DATE | Kayıt tarihi |

---

### 2. `urun`
| Alan Adı | Veri Tipi | Açıklama |
|-----------|------------|----------|
| id | INT (PK, IDENTITY) | Ürün kimliği |
| ad | NVARCHAR(100) | Ürün adı |
| fiyat | DECIMAL(10,2) | Ürün fiyatı |
| stok | INT | Ürün stok miktarı |
| kategori_id | INT  | Ürünün kategorisi |
| satici_id | INT | Ürünü satan satıcı |

---

### 3. `kategori`
| Alan Adı | Veri Tipi | Açıklama |
|-----------|------------|----------|
| id | INT (PK, IDENTITY) | Kategori kimliği |
| ad | NVARCHAR(100) | Kategori adı |

---

### 4. `satici`
| Alan Adı | Veri Tipi | Açıklama |
|-----------|------------|----------|
| id | INT (PK, IDENTITY) | Satıcı kimliği |
| ad | NVARCHAR(100) | Satıcı adı |

---

### 5. `siparis`
| Alan Adı | Veri Tipi | Açıklama |
|-----------|------------|----------|
| id | INT (PK, IDENTITY) | Sipariş kimliği |
| musteri_id | INT  | Sipariş veren müşteri |
| siparis_tarihi | DATE | Sipariş tarihi |

---

### 6. `siparisdetay`
| Alan Adı | Veri Tipi | Açıklama |
|-----------|------------|----------|
| id | INT (PK, IDENTITY) | Detay kimliği |
| siparis_id | INT  | İlgili sipariş |
| urun_id | INT  | Siparişteki ürün |
| miktar | INT | Satılan miktar |
| toplam_tutar | DECIMAL(10,2) | Satır toplam tutarı |

---

##  Tablo İlişkileri 

- Bir müşteri birden fazla sipariş verebilir.  
- Bir sipariş, birden fazla ürün içerebilir.  
- Her ürün, bir kategoriye aittir.  
- Her ürün, bir satıcıya bağlıdır.  

