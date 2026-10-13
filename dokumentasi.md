# Dokumentasi UTS Pemrograman Akuntansi

## 1. Tujuan
Membangun purwarupa modul Voucher Entri Transaksi Kas Keluar menggunakan Supabase PostgreSQL dan rancangan antarmuka web.

## 2. Implementasi Database
Database terdiri dari tabel `chart_of_accounts`, `journal_headers`, dan `journal_lines`. Relasi antartabel menggunakan primary key dan foreign key. Constraint membatasi nilai debit dan kredit agar tidak negatif serta mencegah satu baris jurnal memiliki nilai debit dan kredit nol secara bersamaan.

## 3. Fungsi Posting Jurnal
Fungsi `post_journal` memeriksa kelengkapan transaksi dan keseimbangan total debit dengan total kredit sebelum menyimpan jurnal. Nomor referensi harus unik agar satu nomor bukti tidak digunakan berulang kali.

> Catatan: salin definisi fungsi `post_journal` yang benar-benar berhasil kamu jalankan di Supabase ke file `audit_trail.sql` atau simpan sebagai file `post_journal.sql`. File paket ini tidak mengklaim menggantikan fungsi yang sudah teruji di proyekmu.

## 4. Audit Trail dan Immutability
Field `created_by` mencatat identitas pembuat transaksi, `created_at` mencatat waktu pembuatan, dan `hash_checksum` menyimpan hash untuk membantu pemeriksaan integritas data. Trigger menolak perubahan dan penghapusan langsung pada jurnal yang sudah berstatus `POSTED`.

## 5. Hasil Pengujian
Lengkapi bagian ini sesuai hasil aktual di Supabase:
- Posting jurnal uji: [berhasil/gagal dan header_id].
- Pemeriksaan keseimbangan debit dan kredit: [hasil aktual].
- Pengujian UPDATE pada jurnal POSTED: [ditolak/diterima].
- Pengujian DELETE pada jurnal POSTED: [ditolak/diterima].
- Pengujian perubahan detail jurnal POSTED: [ditolak/diterima].

## 6. Jurnal Pembalik
Koreksi atas jurnal yang sudah diposting dilakukan melalui jurnal baru dengan nomor referensi berbeda dan nilai debit-kredit yang dibalik. Jurnal awal dipertahankan sebagai bagian dari jejak audit.

Untuk implementasi yang lebih lengkap, tambahkan relasi eksplisit antara jurnal pembalik dan jurnal awal, misalnya melalui kolom `reversal_of_header_id`.

## 7. Integrasi AI
Dokumentasikan prompt Gemini Canvas dan hasil rancangan antarmuka yang benar-benar diperoleh. Gunakan NotebookLM untuk memeriksa aturan bisnis berdasarkan sumber akuntansi yang diunggah, lalu catat hasilnya sesuai keluaran aktual.

## 8. Keterbatasan
`index.html` adalah purwarupa UI yang menghitung keseimbangan debit-kredit di browser. Form ini belum terhubung ke Supabase dan tidak boleh dianggap sudah menyimpan transaksi. Integrasi produksi memerlukan autentikasi dan pengaturan hak akses yang aman.

## 9. Tautan Repositori
[Masukkan tautan GitHub setelah repositori dibuat]
