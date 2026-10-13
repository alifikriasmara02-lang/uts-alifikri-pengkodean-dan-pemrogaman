# Purwarupa Voucher Kas Keluar

## Deskripsi
Purwarupa modul Voucher Entri Transaksi Kas Keluar untuk mata kuliah Pemrograman/Coding. Contoh ini menggunakan Supabase PostgreSQL sebagai basis data dan HTML/CSS/JavaScript untuk rancangan antarmuka.

## Berkas
- `schema.sql`: struktur tabel dan constraint serta data contoh akun.
- `audit_trail.sql`: contoh trigger pengunci jurnal POSTED.
- `index.html`: rancangan antarmuka web dengan kalkulasi debit-kredit otomatis.
- `dokumentasi.md`: dokumentasi implementasi dan hasil pengujian.
- `post_journal.sql`: tempat untuk menyimpan definisi fungsi posting yang sudah kamu uji (buat/salin sendiri dari Supabase).

## Cara mencoba antarmuka
Buka `index.html` dengan browser. Form ini berjalan sebagai demo antarmuka, tetapi belum mengirim data ke Supabase.

## Catatan
Jangan mengunggah password, access token, atau `service_role key`. Sebelum dipakai sebagai aplikasi nyata, integrasikan autentikasi dan hak akses dengan benar.
