# dmproyek

Template **Quarto** untuk penyusunan skripsi yang **dikhususkan bagi mahasiswa
Program Studi D-IV Komputasi Statistik, Politeknik Statistika STIS**, disusun
mengikuti *Pedoman Skripsi KS Edisi Keenam (2025)*. Paket ini membuat proyek
skripsi siap pakai—lengkap dengan halaman muka, pengaturan format, dan gaya
kutipan **APA edisi ke-7 dengan modifikasi bahasa Indonesia**.

> 📌 **Khusus Prodi D-IV Komputasi Statistik.** Seluruh ketentuan (halaman muka,
> peminatan Sains Data / Sistem Informasi Statistik, kerangka bab, gaya sitasi)
> mengacu pada pedoman skripsi Prodi Komputasi Statistik. Template ini **tidak
> ditujukan** untuk program studi lain (mis. D-IV Statistika) yang memiliki
> pedoman dan format berbeda.

> ⚠️ **Status: versi pengembangan (tidak resmi).**
> Paket ini masih dalam tahap pengembangan dan **belum sepenuhnya mengikuti**
> panduan penulisan skripsi Politeknik Statistika STIS. Format, tata letak, dan
> ketentuan yang dihasilkan **dapat berubah** serta perlu diperiksa kembali
> terhadap pedoman resmi sebelum digunakan untuk pengajuan. Ini **bukan** templat
> resmi yang dikeluarkan oleh Politeknik Statistika STIS.
>
> Setelah seluruh ketentuan sesuai dengan panduan penulisan skripsi, **versi
> stabil** akan dirilis. Masukan dan koreksi sangat diharapkan.

## Fitur

- **Halaman muka otomatis**: sampul, halaman judul, pernyataan (dengan meterai),
  pengesahan (tim penguji + pembimbing), dan lembar hak cipta — terisi dari
  argumen fungsi.
- **Format STIS**: kertas A4, margin 4-3-3-3 cm, font Times (TeX Gyre Termes),
  spasi 1,5, judul bab "BAB I" rata tengah dan kapital (Romawi pada judul, subbab
  bernomor Arab 1.1, 1.2, ...), nomor halaman bagian awal Romawi (tengah bawah) dan
  bagian isi Arab (kanan bawah).
- **Tabel sesuai pedoman**: judul di atas tabel berawalan "Tabel" (bukan "Table"),
  baris nomor kolom (1), (2), (3), baris "Sumber" untuk data sekunder, serta dukungan
  `longtable` (tabel lintas-halaman) dan `pdflscape` (tabel lebar landscape). Gambar
  berjudul "Gambar" di bawah objek.
- **Daftar lengkap**: Daftar Isi (entri bab berawalan "BAB I", "BAB II", ...),
  Daftar Tabel, Daftar Gambar, dan **Daftar Lampiran**.
- **Dua varian kerangka bab sesuai peminatan**:
  - *Sains Data* — Bab I Pendahuluan, II Tinjauan Pustaka, III Metode Penelitian,
    IV Hasil dan Pembahasan, V Kesimpulan dan Saran.
  - *Sistem Informasi Statistik* — Bab I–III sama, lalu IV Analisis dan Perancangan,
    V Implementasi dan Evaluasi, VI Kesimpulan dan Saran.
- **Templat Proyek RStudio**: tersedia di *File → New Project → New Directory →
  Skripsi Komputasi Statistik (Politeknik Statistika STIS)*.
- **Contoh chunk R dan Python**: chunk R dieksekusi langsung; chunk Python dapat
  diaktifkan melalui `reticulate`.
- **Kerangka pikir**: placeholder diagram kerangka pikir (Permasalahan-Tujuan-Solusi-
  Evaluasi) pada Bab III sesuai pedoman.
- **Urutan halaman sesuai pedoman**: Sampul → Judul → Pernyataan → Pengesahan →
  Hak Cipta → Prakata → Abstrak → Daftar Isi → Daftar Tabel → Daftar Gambar →
  Daftar Lampiran → Bab I–V → Daftar Pustaka → Lampiran → Riwayat Hidup. Halaman
  muka bernomor Romawi kecil mulai dari Prakata (i), isi bernomor Arab di kanan bawah.
- **Sitasi APA 7 Indonesia** (`apa-stis-id.csl`): penghubung **dan**, tiga penulis
  atau lebih disingkat **dkk.**, tanpa tahun **t.t.**, edisi **ed. ke-2**,
  penerjemah **Penerj.** Daftar pustaka tersusun otomatis dan alfabetis.
- **Komputasi langsung**: contoh tabel dan gambar dihitung dari kode R sehingga
  angka pada naskah selalu konsisten.
- **Penulisan matematika**: lingkungan **Definisi, Teorema, Lema, Akibat, Proposisi,
  Contoh** (judul + rujukan silang berbahasa Indonesia) beserta lingkungan **Bukti**,
  semuanya bernomor dan dapat dirujuk dengan `@def-`, `@thm-`, dan seterusnya.
- **Algoritma**: lingkungan `algorithm2e` dengan nama "Algoritme", kata kunci Indonesia
  (Masukan, Keluaran, untuk, selama, kembalikan), dan penomoran deret tunggal
  (mis. Algoritme 1).
- **Kode sebagai gambar**: potongan kode dapat diberi judul "Gambar x. ..." dan dirujuk
  silang layaknya gambar (masuk pula ke Daftar Gambar), lengkap dengan nomor baris agar
  mudah dijelaskan baris per baris.
- **Font grafik = font dokumen**: grafik R dirender dengan `tikzDevice` (xelatex) sehingga
  ber-font Times New Roman serasi dengan teks dan dapat memuat simbol LaTeX
  (mis. `$\alpha$`, `$\sigma^2$`) pada label.

## Prasyarat

- [R](https://www.r-project.org/) beserta paket `knitr`, `rmarkdown`, dan `tikzDevice`
- [Quarto](https://quarto.org/) >= 1.4
- Distribusi LaTeX dengan **XeLaTeX** dan paket `algorithm2e` (mis. TinyTeX:
  `quarto install tinytex`; paket LaTeX akan dipasang otomatis saat render pertama)

## Pemasangan

```r
# dari sumber (folder paket)
install.packages("dmproyek_0.4.0.tar.gz", repos = NULL, type = "source")

# atau dari GitHub
# remotes::install_github("madsyair/dmproyek")
```

## Penggunaan

```r
library(dmproyek)

buat_laporan(
  path       = "skripsi-saya",
  judul      = "Pemodelan Proxy Means Test Berbasis GPBoost di Provinsi Jawa Timur",
  subjudul   = NULL,
  nama       = "Nama Mahasiswa",
  nim        = "222212501",
  peminatan  = "Sains Data",
  ketua_prodi = "Nama Ketua Program Studi",
  pembimbing = "Nama Pembimbing",
  render     = TRUE        # langsung render ke PDF
)
```

Render manual kapan saja:

```bash
quarto render skripsi-saya
```

Hasil PDF berada di `skripsi-saya/_output/`.

### Lewat menu RStudio (Templat Proyek)

Setelah paket terpasang, template muncul di RStudio melalui:

**File → New Project… → New Directory → Skripsi Komputasi Statistik (Politeknik
Statistika STIS)**

Dialog akan menanyakan judul, nama, NIM, peminatan, dan pembimbing, lalu membuat
proyek dan membuka `index.qmd`.

> **Catatan tentang "New Quarto Document".** Dialog *File → New File → Quarto Document*
> di RStudio hanya membuat satu berkas `.qmd` kosong dan **tidak dapat memuat template
> dari paket R**. Karena skripsi ini berupa **proyek multi-berkas** (banyak bab, berkas
> `.tex`, `.csl`, `.bib`, dan gambar), mekanisme yang tepat adalah **Templat Proyek**
> di atas (atau fungsi `buat_laporan()`), bukan "New Quarto Document". Ini batasan
> RStudio/Quarto, bukan paket ini.

## Struktur proyek yang dihasilkan

```
skripsi-saya/
├── _quarto.yml              # konfigurasi (format, CSL, bibliografi)
├── index.qmd                # Prakata, Abstrak, Daftar Isi/Tabel/Gambar, include bab
├── referensi.bib            # basis data referensi (BibTeX)
├── apa-stis-id.csl          # gaya sitasi APA 7 modifikasi Indonesia
├── bab/
│   ├── bab1_pendahuluan.qmd
│   ├── bab2_tinjauan_pustaka.qmd
│   ├── bab3_metode.qmd
│   ├── bab4_hasil.qmd
│   ├── bab5_kesimpulan.qmd
│   └── lampiran.qmd
├── tex/
│   ├── preamble.tex         # format (margin, font, spasi, judul bab)
│   └── 00_frontmatter.tex   # sampul s.d. lembar hak cipta
└── img/                     # logo_stis.png sudah disertakan (boleh diganti)
```

## Menulis kutipan

Tambahkan entri ke `referensi.bib`, lalu rujuk di naskah:

| Penulisan         | Hasil                       |
|-------------------|-----------------------------|
| `[@kunci2025]`    | (Nama dkk., 2025)           |
| `@kunci2025`      | Nama dkk. (2025)            |
| `[@a2020; @b2021]`| (A dkk., 2020; B dkk., 2021)|

## Penulisan matematika, algoritma, dan kode-sebagai-gambar

**Definisi / Teorema / Lema / Bukti** (rujuk dengan `@def-`, `@thm-`, dst.):

````markdown
::: {#def-pmt}
**(Proxy Means Test).** Misalkan $y_i$ ... .
:::

::: {#thm-takbias}
Penduga kuadrat terkecil bersifat takbias.
:::

::: {.proof}
Bukti ... . $\qed$
:::

Lihat @def-pmt dan @thm-takbias.
````

**Algoritma** (penomoran deret tunggal; rujuk dengan `\ref{...}`):

````markdown
```{=latex}
\begin{algorithm}[H]
\caption{Estimasi PMT}\label{alg-pmt}
\KwIn{Data $\mathbf{X}$, target $y$}
\KwOut{Model $\hat{f}$}
\ForEach{kandidat $m$}{ Latih $m$\; }
\Return $\hat{f}$\;
\end{algorithm}
```
Lihat Algoritme \ref{alg-pmt}.
````

**Kode sebagai gambar** (judul "Gambar x."; nomor baris dengan `.numberLines`; rujuk dengan `@fig-`):

````markdown
::: {#fig-kode-regresi}
```{.r .numberLines}
model <- lm(y ~ x, data = dat)
```

Kode penghitungan regresi linear
:::

Lihat @fig-kode-regresi.
````

**Font grafik = Times + simbol LaTeX.** Setelan global pada `index.qmd` sudah mengaktifkan
`dev = "tikz"` untuk semua gambar saat output PDF, sehingga grafik ber-font Times dan
dapat memuat simbol LaTeX pada label, mis. `xlab = "Sumbu $\\alpha$"` (perhatikan *double
backslash* di dalam string R). Untuk satu gambar tertentu yang tidak ingin memakai tikz,
tambahkan opsi chunk `#| dev: ragg_png`.

### Chunk R dan Python

Template memakai mesin **knitr**. Chunk **R** dieksekusi langsung. Chunk **Python**
dapat dijalankan pada dokumen yang sama melalui paket `reticulate`:

````markdown
```{r}
nilai <- c(70, 85, 90, 65, 78)
mean(nilai)
```

```{python}
#| eval: false
import numpy as np
print(np.array([70, 85, 90, 65, 78]).mean())
```
````

Untuk mengaktifkan Python: `install.packages("reticulate")`, arahkan ke interpreter
Python (mis. `reticulate::install_miniconda()`), lalu hapus `#| eval: false`. Contoh
kedua chunk sudah tersedia di Bab IV (Hasil dan Pembahasan) pada peminatan Sains Data.

## Catatan modifikasi APA 7 → Indonesia

Berkas `apa-stis-id.csl` diturunkan dari gaya resmi *APA 7th edition* (CSL),
kemudian disesuaikan: penghubung antarpenulis menggunakan kata "dan" (bukan
"&"), istilah dilokalkan ke bahasa Indonesia (`dkk.`, `t.t.`, `dalam`,
`diakses`, `ed. ke-N`, `Penerj.`), dan dokumen di-set `lang: id`.

## Catatan kepatuhan & spasi

Beberapa ketentuan format telah disesuaikan dengan Pedoman Skripsi KS Edisi Keenam
(2025): penamaan "Tabel"/"Gambar", baris nomor kolom dan baris sumber pada tabel,
judul bab "BAB I" dengan subbab Arab, nomor halaman isi di kanan bawah, Daftar
Lampiran, ukuran font institusi 14 pt, logo 5 cm, serta placeholder kerangka pikir.

Mengenai jarak baris: template memakai **spasi 1,5** untuk seluruh dokumen. Teks
pedoman pada hlm. 34 menyebut teks isi **2 spasi** (sementara abstrak dan subjudul
1,5 spasi). Karena praktik di lapangan bervariasi, **konfirmasikan ke Program Studi**
spasi yang berlaku. Bila diminta 2 spasi untuk teks isi, ubah `\onehalfspacing`
menjadi `\doublespacing` pada `tex/preamble.tex` (abstrak/halaman muka dapat dibungkus
`\begin{spacing}{1.5}...\end{spacing}` bila perlu).

> Catatan: pada Daftar Isi, entri bab dapat tampil sebagai "1 PENDAHULUAN" (bukan
> "BAB I PENDAHULUAN"). Penyesuaian tampilan entri bab pada Daftar Isi bersifat opsional
> dan dapat ditambahkan kemudian; penomoran pada badan dokumen sudah sesuai pedoman.
