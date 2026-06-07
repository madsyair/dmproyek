#' Pengikat (binding) RStudio Project Template untuk laporan proyek Data Mining
#'
#' Fungsi ini dipanggil otomatis oleh RStudio melalui menu
#' **File \eqn{\rightarrow} New Project \eqn{\rightarrow} New Directory \eqn{\rightarrow}
#' Laporan Proyek Data Mining (Politeknik Statistika STIS)**.
#' Gunakan [buat_laporan()] untuk pemakaian dari konsol.
#'
#' @param path Direktori proyek yang dibuat RStudio.
#' @param ... Parameter dari dialog RStudio (judul, mata_kuliah, kelompok,
#'   kelas, anggota, dosen).
#' @return (Secara *invisible*) path proyek.
#' @export
#' @keywords internal
buat_laporan_rstudio <- function(path, ...) {
  dots <- list(...)

  kosong_jadi_default <- function(x, default) {
    if (is.null(x) || !nzchar(trimws(as.character(x)))) default else x
  }

  mk <- kosong_jadi_default(dots$mata_kuliah, "Data Mining")
  # Anggota: dialog menerima satu baris dipisah koma/titik koma.
  anggota_raw <- kosong_jadi_default(dots$anggota, "Nama Anggota 1; Nama Anggota 2")
  anggota <- trimws(unlist(strsplit(as.character(anggota_raw), "[;,]")))
  anggota <- anggota[nzchar(anggota)]

  buat_laporan(
    path        = path,
    judul       = kosong_jadi_default(dots$judul, "TULISKAN JUDUL PROYEK ANDA DI SINI"),
    subjudul    = if (is.null(dots$subjudul) || !nzchar(trimws(dots$subjudul))) NULL else dots$subjudul,
    mata_kuliah = mk,
    kelompok    = kosong_jadi_default(dots$kelompok, "X"),
    kelas       = kosong_jadi_default(dots$kelas, "KELAS"),
    anggota     = anggota,
    dosen       = kosong_jadi_default(dots$dosen, "Nama Dosen Pengampu"),
    overwrite   = TRUE
  )
  invisible(path)
}
