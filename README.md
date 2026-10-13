# Purwarupa Voucher Kas Keluar

Nama: Ali Fikri Asmara
NIM: 12030124120074
Kelas: D

## Deskripsi

Proyek ini merupakan purwarupa modul Voucher Entri Transaksi Kas Keluar untuk mata kuliah Pemrograman/Coding. Sistem menggunakan Supabase PostgreSQL untuk menyimpan data akun dan jurnal serta menerapkan pengendalian dasar pada transaksi yang sudah diposting.

## Fitur

* Struktur tabel chart of accounts, journal headers, dan journal lines.
* Validasi keseimbangan debit dan kredit pada fungsi posting jurnal.
* Pencatatan created_by, created_at, dan hash_checksum.
* Penguncian transaksi POSTED terhadap perubahan dan penghapusan langsung.
* Konsep koreksi melalui jurnal pembalik.
* Rancangan formulir jurnal dengan indikator keseimbangan debit-kredit.

## Berkas

* `schema.sql`: struktur tabel dan constraint.
* `audit_trail.sql`: fungsi posting, trigger, dan pengaturan akses.
* `index.html`: rancangan antarmuka web.
* `dokumentasi.md`: penjelasan implementasi dan hasil pengujian.

## Catatan

Rancangan antarmuka web dan fungsi database merupakan komponen yang perlu diintegrasikan dengan autentikasi serta pengaturan hak akses sebelum digunakan sebagai aplikasi produksi.
