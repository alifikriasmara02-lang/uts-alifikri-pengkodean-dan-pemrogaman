-- Audit Trail & Immutability untuk Voucher Kas Keluar
-- PERHATIAN:
-- 1. File ini merangkum fungsi/trigger untuk dokumentasi dan penyesuaian.
-- 2. Jika trigger/fungsi sudah dibuat di Supabase, jangan jalankan ulang tanpa memeriksa
--    definisi yang ada. CREATE OR REPLACE dapat mengganti fungsi yang sudah digunakan.
-- 3. Pastikan ekstensi pgcrypto tersedia pada skema extensions di proyek Supabase.

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;

CREATE OR REPLACE FUNCTION public.prevent_posted_header_change()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF OLD.posting_status = 'POSTED' THEN
        RAISE EXCEPTION 'Transaksi POSTED tidak boleh diubah atau dihapus langsung.';
    END IF;
    RETURN CASE WHEN TG_OP = 'DELETE' THEN OLD ELSE NEW END;
END;
$$;

DROP TRIGGER IF EXISTS trg_prevent_posted_header_update ON public.journal_headers;
CREATE TRIGGER trg_prevent_posted_header_update
BEFORE UPDATE ON public.journal_headers
FOR EACH ROW EXECUTE FUNCTION public.prevent_posted_header_change();

DROP TRIGGER IF EXISTS trg_prevent_posted_header_delete ON public.journal_headers;
CREATE TRIGGER trg_prevent_posted_header_delete
BEFORE DELETE ON public.journal_headers
FOR EACH ROW EXECUTE FUNCTION public.prevent_posted_header_change();

CREATE OR REPLACE FUNCTION public.prevent_posted_line_change()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_header_id BIGINT;
    v_status TEXT;
BEGIN
    v_header_id := OLD.header_id;

    SELECT posting_status INTO v_status
    FROM public.journal_headers
    WHERE header_id = v_header_id
    FOR UPDATE;

    IF v_status = 'POSTED' THEN
        RAISE EXCEPTION 'Detail jurnal POSTED tidak boleh diubah atau dihapus langsung.';
    END IF;

    IF TG_OP = 'UPDATE' AND NEW.header_id <> OLD.header_id THEN
        RAISE EXCEPTION 'Detail jurnal tidak boleh dipindahkan ke header lain.';
    END IF;

    RETURN CASE WHEN TG_OP = 'DELETE' THEN OLD ELSE NEW END;
END;
$$;

DROP TRIGGER IF EXISTS trg_prevent_posted_line_update ON public.journal_lines;
CREATE TRIGGER trg_prevent_posted_line_update
BEFORE UPDATE ON public.journal_lines
FOR EACH ROW EXECUTE FUNCTION public.prevent_posted_line_change();

DROP TRIGGER IF EXISTS trg_prevent_posted_line_delete ON public.journal_lines;
CREATE TRIGGER trg_prevent_posted_line_delete
BEFORE DELETE ON public.journal_lines
FOR EACH ROW EXECUTE FUNCTION public.prevent_posted_line_change();

-- Fungsi posting harus mengikuti definisi post_journal yang sudah kamu buat
-- dan uji di Supabase. Jangan menjalankan ulang fungsi yang berbeda tanpa membandingkannya.
-- Catatan keamanan: pembatasan EXECUTE harus disesuaikan dengan autentikasi/otorisasi aplikasi.
