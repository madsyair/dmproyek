# Utilitas internal (tidak diekspor) ------------------------------------------

#' Lokasi folder template bawaan paket
#' @noRd
.lokasi_template <- function() {
  system.file("template", package = "dmproyek")
}

#' Ganti token {{KEY}} pada sebuah string dengan nilai dari daftar
#' @noRd
.ganti_token <- function(teks, peta) {
  for (kunci in names(peta)) {
    pola <- paste0("{{", kunci, "}}")
    teks <- gsub(pola, peta[[kunci]], teks, fixed = TRUE)
  }
  teks
}

#' Terapkan substitusi token ke seluruh berkas teks dalam direktori
#' @noRd
.substitusi_berkas <- function(dir, peta) {
  ext_teks <- c("qmd", "yml", "yaml", "tex", "bib", "md", "txt")
  berkas <- list.files(dir, recursive = TRUE, full.names = TRUE)
  for (f in berkas) {
    if (tolower(tools::file_ext(f)) %in% ext_teks) {
      isi <- tryCatch(
        readLines(f, warn = FALSE, encoding = "UTF-8"),
        error = function(e) NULL
      )
      if (is.null(isi)) next
      baru <- .ganti_token(isi, peta)
      if (!identical(isi, baru)) {
        con <- file(f, open = "w", encoding = "UTF-8")
        writeLines(baru, con)
        close(con)
      }
    }
  }
  invisible(TRUE)
}

#' Bangun blok subjudul LaTeX bila subjudul disediakan
#' @noRd
.blok_subjudul <- function(subjudul) {
  if (is.null(subjudul) || !nzchar(subjudul)) {
    list(
      SUBJUDUL            = "",
      SUBJUDUL_BLOCK      = "",
      SUBJUDUL_PERNYATAAN = "",
      SUBJUDUL_PENGESAHAN = ""
    )
  } else {
    list(
      SUBJUDUL            = subjudul,
      SUBJUDUL_BLOCK      = sprintf("\\vspace{0.3cm}{\\bfseries\\large (%s)\\par}", subjudul),
      SUBJUDUL_PERNYATAAN = sprintf("{\\bfseries (%s)\\par}", subjudul),
      SUBJUDUL_PENGESAHAN = sprintf("\\begin{center}{\\bfseries\\large (%s)}\\end{center}", subjudul)
    )
  }
}

#' Bangun blok LaTeX daftar anggota kelompok untuk sampul
#' @noRd
.blok_anggota <- function(anggota, nim = NULL) {
  n <- length(anggota)
  if (!is.null(nim) && length(nim) == n) {
    baris <- paste(
      sprintf("%d. & %s & %s", seq_len(n), anggota, nim),
      collapse = " \\\\\n"
    )
    sprintf("\\begin{tabular}{@{}r l l@{}}\n%s\n\\end{tabular}", baris)
  } else {
    baris <- paste(
      sprintf("%d. & %s", seq_len(n), anggota),
      collapse = " \\\\\n"
    )
    sprintf("\\begin{tabular}{@{}r l@{}}\n%s\n\\end{tabular}", baris)
  }
}
