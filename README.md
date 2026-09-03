# dmproyek

Template **Quarto** untuk penyusunan **laporan proyek kelompok** mata kuliah
*Data Mining* (Program Studi D-IV Komputasi Statistik) dan *Data Mining dan Big
Data* (Program Studi D-IV Statistika) di **Politeknik Statistika STIS**. Struktur
laporan mengikuti metodologi **CRISP-DM**. Paket ini membuat proyek laporan siap
pakai—lengkap dengan sampul, pengaturan format, dan gaya kutipan/daftar pustaka.

> **Catatan.** Template ini menyiapkan format dan struktur agar konsisten. Periksa
> kembali kesesuaian dengan ketentuan tugas dari dosen pengampu masing-masing
> sebelum dikumpulkan.

## Fitur

- **Sampul kelompok**: memuat judul, *Laporan Proyek* + mata kuliah, nomor
  **Kelompok**, **Kelas**, **daftar anggota** (3–7 orang, dengan NIM opsional), dan
  **Dosen Pengampu**—semuanya dalam satu halaman.
- **Program studi otomatis**: dipilih dari `mata_kuliah` (Komputasi Statistik untuk
  *Data Mining*; Statistika untuk *Data Mining dan Big Data*).
- **Struktur CRISP-DM (Bab I–VI)**: Pendahuluan & Pemahaman Bisnis, Pemahaman Data,
  Persiapan Data, Pemodelan, Evaluasi, serta Penerapan dan Kesimpulan.
- **Format konsisten**: font Times (TeX Gyre Termes) 12 pt, penomoran
  tabel/gambar/persamaan **deret tunggal** (1, 2, 3, … lintas bab), rujukan
  persamaan ber-kurung (*Persamaan (1)*), header "Halaman" pada Daftar
  Isi/Tabel/Gambar/Lampiran, dan nomor halaman di kanan bawah.
- **Kutipan APA 7 (modifikasi Indonesia)** melalui berkas `apa-stis-id.csl`.
- **Templat proyek RStudio** dan contoh *chunk* R (tabel `kableExtra`, grafik).

## Instalasi

```r
# dari berkas sumber
install.packages("dmproyek_0.1.0.tar.gz", repos = NULL, type = "source")
# dari github
devtools::install_github("madsyair/dmproyek")
```

Prasyarat render: **Quarto** (≥ 1.4), **XeLaTeX** (TeX Live/TinyTeX), serta paket R
`knitr`, `rmarkdown`, `tikzDevice`, dan `kableExtra`.

## Penggunaan

```r
library(dmproyek)

buat_laporan(
  path        = "proyek-dm",
  judul       = "Klasifikasi Status Kesejahteraan Rumah Tangga",
  mata_kuliah = "Data Mining",          # atau "Data Mining dan Big Data"
  kelompok    = 3,
  kelas       = "3SD1",
  anggota     = c("Nama 1", "Nama 2", "Nama 3"),   # 3 s.d. 7 nama
  nim         = c("222311001", "222311002", "222311003"),
  dosen       = "Nama Dosen Pengampu",
  render      = TRUE                      # butuh Quarto + XeLaTeX
)
```

Informasi pada sampul (sebagai pengganti blok nama mahasiswa pada skripsi) adalah
**nomor kelompok**, **kelas**, **daftar anggota**, dan **dosen pengampu**.

## Render ke PDF

```bash
quarto render proyek-dm
```

Hasil PDF berada di `proyek-dm/_output/index.pdf`. Dari R, dapat pula memakai
`render_laporan("proyek-dm")`.

## Templat proyek RStudio

**File → New Project… → New Directory → Laporan Proyek Data Mining (Politeknik
Statistika STIS)**, lalu isi judul, mata kuliah, kelompok, kelas, anggota, dan dosen.

## Struktur proyek

```
proyek-dm/
├── _quarto.yml              # konfigurasi Quarto (format, crossref, CSL)
├── index.qmd                # berkas utama (halaman muka + perakit bab)
├── referensi.bib            # pustaka (BibTeX)
├── apa-stis-id.csl          # gaya APA 7 modifikasi Indonesia
├── referensi-perintah.qmd   # rujukan perintah (dirender terpisah)
├── bab/
│   ├── bab1_pendahuluan.qmd          # Pemahaman Bisnis
│   ├── bab2_pemahaman_data.qmd       # Data Understanding
│   ├── bab3_persiapan_data.qmd       # Data Preparation
│   ├── bab4_pemodelan.qmd            # Modeling
│   ├── bab5_evaluasi.qmd             # Evaluation
│   ├── bab6_penerapan_kesimpulan.qmd # Deployment & Kesimpulan
│   └── lampiran.qmd
├── tex/                     # preamble & halaman muka (LaTeX)
└── img/                     # logo
```

## Lisensi

Kode dan templat berlisensi MIT (lihat `LICENSE`). Logo Politeknik Statistika STIS
**bukan** berlisensi MIT dan disertakan atas izin institusi (lihat `inst/COPYRIGHTS`).
