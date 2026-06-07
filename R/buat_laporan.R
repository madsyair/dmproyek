#' Buat proyek Quarto laporan proyek Data Mining (CRISP-DM) Politeknik Statistika STIS
#'
#' Menyalin kerangka (template) proyek Quarto laporan proyek dan mengisi metadata
#' (judul, kelompok, kelas, anggota, dosen pengampu, dan lain-lain) secara otomatis.
#' Struktur laporan mengikuti metodologi **CRISP-DM** (Bab I-VI: Pendahuluan &
#' Pemahaman Bisnis, Pemahaman Data, Persiapan Data, Pemodelan, Evaluasi, serta
#' Penerapan dan Kesimpulan). Gaya kutipan mengikuti **APA edisi ke-7 modifikasi
#' bahasa Indonesia**.
#'
#' Informasi pada sampul (pengganti nama mahasiswa pada skripsi) berupa nomor
#' **Kelompok**, **Kelas**, dan **daftar nama anggota** kelompok.
#'
#' @param path Direktori tujuan proyek (akan dibuat). Default `"laporan-dm"`.
#' @param judul Judul proyek.
#' @param subjudul Subjudul proyek (opsional, `NULL` jika tidak ada).
#' @param mata_kuliah Mata kuliah, menentukan program studi pada sampul:
#'   `"Data Mining"` (Prodi D-IV Komputasi Statistik) atau
#'   `"Data Mining dan Big Data"` (Prodi D-IV Statistika).
#' @param kelompok Nomor kelompok (mis. `1` atau `"1"`).
#' @param kelas Kelas (mis. `"3SD1"`, `"4SI2"`).
#' @param anggota Vektor karakter nama anggota kelompok (3 sampai 7 nama).
#' @param nim Vektor karakter NIM anggota (opsional, panjang sama dengan
#'   `anggota`). Bila diisi, sampul menampilkan kolom NIM.
#' @param dosen,nip_dosen Nama dan NIP dosen pengampu (untuk lembar pengesahan).
#' @param tahun Tahun (default tahun berjalan).
#' @param overwrite Bila `TRUE`, menimpa direktori yang sudah ada.
#' @param render Bila `TRUE`, langsung menjalankan `quarto render` setelah membuat
#'   proyek (membutuhkan Quarto terpasang).
#'
#' @return (Secara *invisible*) path absolut proyek yang dibuat.
#' @export
#'
#' @examples
#' \dontrun{
#' buat_laporan(
#'   path        = "proyek-dm",
#'   judul       = "Klasifikasi Status Kesejahteraan Rumah Tangga",
#'   mata_kuliah = "Data Mining",
#'   kelompok    = 3,
#'   kelas       = "3SD1",
#'   anggota     = c("Nama Anggota 1", "Nama Anggota 2", "Nama Anggota 3"),
#'   nim         = c("222311001", "222311002", "222311003"),
#'   dosen       = "Nama Dosen Pengampu",
#'   render      = TRUE
#' )
#' }
buat_laporan <- function(
    path        = "laporan-dm",
    judul       = "TULISKAN JUDUL PROYEK ANDA DI SINI",
    subjudul    = NULL,
    mata_kuliah = c("Data Mining", "Data Mining dan Big Data"),
    kelompok    = "X",
    kelas       = "KELAS",
    anggota     = c("Nama Anggota 1", "Nama Anggota 2", "Nama Anggota 3"),
    nim         = NULL,
    dosen       = "Nama Dosen Pengampu",
    nip_dosen   = "0000",
    tahun       = format(Sys.Date(), "%Y"),
    overwrite   = FALSE,
    render      = FALSE) {

  mata_kuliah <- match.arg(mata_kuliah)
  # Program studi pada sampul ditentukan oleh mata kuliah.
  prodi_str <- if (identical(mata_kuliah, "Data Mining")) {
    "KOMPUTASI STATISTIK"
  } else {
    "STATISTIKA"
  }

  if (length(anggota) < 3L || length(anggota) > 7L) {
    stop("'anggota' harus berisi 3 sampai 7 nama (jumlah saat ini: ",
         length(anggota), ").", call. = FALSE)
  }
  if (!is.null(nim) && length(nim) != length(anggota)) {
    stop("Panjang 'nim' harus sama dengan 'anggota'.", call. = FALSE)
  }

  # --- Validasi direktori tujuan ---
  if (dir.exists(path)) {
    if (!overwrite) {
      stop("Direktori '", path, "' sudah ada. ",
           "Gunakan overwrite = TRUE untuk menimpanya.", call. = FALSE)
    }
    unlink(path, recursive = TRUE, force = TRUE)
  }

  template <- .lokasi_template()
  if (!nzchar(template) || !dir.exists(template)) {
    stop("Template bawaan tidak ditemukan. Pastikan paket terpasang dengan benar.",
         call. = FALSE)
  }

  # --- Salin seluruh template ke tujuan ---
  dir.create(path, recursive = TRUE, showWarnings = FALSE)
  berkas_template <- list.files(template, recursive = TRUE, full.names = FALSE,
                                all.files = TRUE, no.. = TRUE)
  for (rel in berkas_template) {
    src <- file.path(template, rel)
    dst <- file.path(path, rel)
    dir.create(dirname(dst), recursive = TRUE, showWarnings = FALSE)
    file.copy(src, dst, overwrite = TRUE)
  }

  # --- Kerangka bab: CRISP-DM (Bab I-VI), sama untuk kedua mata kuliah ---
  urutan_bab <- c("bab1_pendahuluan", "bab2_pemahaman_data",
                  "bab3_persiapan_data", "bab4_pemodelan",
                  "bab5_evaluasi", "bab6_penerapan_kesimpulan")
  include_bab <- paste(
    sprintf("{{< include bab/%s.qmd >}}", urutan_bab),
    collapse = "\n\n"
  )

  # --- Susun peta substitusi token ---
  peta <- c(
    list(
      JUDUL         = judul,
      MATA_KULIAH   = mata_kuliah,
      PRODI         = prodi_str,
      KELOMPOK      = as.character(kelompok),
      KELAS         = kelas,
      ANGGOTA_BLOCK = .blok_anggota(anggota, nim),
      DOSEN         = dosen,
      NIP_DOSEN     = nip_dosen,
      TAHUN         = as.character(tahun),
      INCLUDE_BAB   = include_bab
    ),
    .blok_subjudul(subjudul)
  )

  .substitusi_berkas(path, peta)

  abs_path <- normalizePath(path, winslash = "/", mustWork = TRUE)
  message("Proyek laporan Data Mining dibuat di: ", abs_path)
  message("Mata kuliah: ", mata_kuliah, " | Kelompok: ", kelompok, " | Kelas: ", kelas)
  message("Render dengan: quarto render \"", abs_path, "\"")

  if (isTRUE(render)) {
    render_laporan(abs_path)
  }
  invisible(abs_path)
}

#' Render proyek laporan menggunakan Quarto
#'
#' Pembungkus tipis untuk menjalankan `quarto render` pada direktori proyek.
#'
#' @param path Direktori proyek laporan.
#' @return (Secara *invisible*) `path`.
#' @export
render_laporan <- function(path = ".") {
  quarto <- Sys.which("quarto")
  if (!nzchar(quarto)) {
    stop("Perintah 'quarto' tidak ditemukan pada PATH. Pasang Quarto terlebih dahulu: ",
         "https://quarto.org/docs/get-started/", call. = FALSE)
  }
  status <- system2(quarto, c("render", shQuote(normalizePath(path))))
  if (!identical(status, 0L)) {
    warning("quarto render selesai dengan status non-nol: ", status, call. = FALSE)
  }
  invisible(path)
}

#' Path berkas CSL APA 7 modifikasi bahasa Indonesia
#'
#' Mengembalikan path ke berkas gaya sitasi `apa-stis-id.csl` yang disertakan
#' dalam paket, untuk dipakai mandiri pada dokumen Quarto/R Markdown lain.
#'
#' @return Path absolut berkas CSL (karakter).
#' @export
#' @examples
#' path_csl()
path_csl <- function() {
  system.file("csl", "apa-stis-id.csl", package = "dmproyek")
}
