test_that("buat_laporan membuat struktur proyek dan mengganti token", {
  tmp <- file.path(tempdir(), "uji-laporan")
  on.exit(unlink(tmp, recursive = TRUE, force = TRUE), add = TRUE)

  p <- buat_laporan(
    path        = tmp,
    judul       = "JUDUL UJI COBA",
    mata_kuliah = "Data Mining",
    kelompok    = 3,
    kelas       = "3SD1",
    anggota     = c("Budi Santoso", "Siti Aminah", "Andi Wijaya"),
    nim         = c("221234567", "221234568", "221234569"),
    dosen       = "Dr. Pengampu",
    overwrite   = TRUE
  )

  expect_true(dir.exists(p))
  expect_true(file.exists(file.path(p, "_quarto.yml")))
  expect_true(file.exists(file.path(p, "index.qmd")))
  expect_true(file.exists(file.path(p, "referensi.bib")))
  expect_true(file.exists(file.path(p, "bab", "bab1_pendahuluan.qmd")))
  expect_true(file.exists(file.path(p, "bab", "bab6_penerapan_kesimpulan.qmd")))
  expect_true(file.exists(file.path(p, "tex", "00_frontmatter.tex")))

  fm <- readLines(file.path(p, "tex", "00_frontmatter.tex"), warn = FALSE, encoding = "UTF-8")
  expect_true(any(grepl("KELOMPOK 3", fm, fixed = TRUE)))
  expect_true(any(grepl("Budi Santoso", fm, fixed = TRUE)))
  expect_true(any(grepl("KOMPUTASI STATISTIK", fm, fixed = TRUE)))
  expect_false(any(grepl("{{JUDUL}}", fm, fixed = TRUE)))
})

test_that("mata kuliah menentukan program studi pada sampul", {
  tmp <- file.path(tempdir(), "uji-laporan-bd")
  on.exit(unlink(tmp, recursive = TRUE, force = TRUE), add = TRUE)
  buat_laporan(path = tmp, mata_kuliah = "Data Mining dan Big Data",
               anggota = c("Nama A", "Nama B", "Nama C"), overwrite = TRUE)
  fm <- readLines(file.path(tmp, "tex", "00_frontmatter.tex"), warn = FALSE, encoding = "UTF-8")
  expect_true(any(grepl("STATISTIKA", fm, fixed = TRUE)))
  expect_true(any(grepl("PROGRAM DIPLOMA IV", fm, fixed = TRUE)))
})

test_that("buat_laporan menolak menimpa tanpa overwrite", {
  tmp <- file.path(tempdir(), "uji-laporan-2")
  on.exit(unlink(tmp, recursive = TRUE, force = TRUE), add = TRUE)
  buat_laporan(path = tmp, anggota = c("Nama A", "Nama B", "Nama C"), overwrite = TRUE)
  expect_error(buat_laporan(path = tmp, anggota = c("Nama A", "Nama B", "Nama C")), "sudah ada")
})

test_that("kerangka bab mengikuti CRISP-DM (Bab I-VI)", {
  tmp <- file.path(tempdir(), "uji-laporan-crispdm")
  on.exit(unlink(tmp, recursive = TRUE, force = TRUE), add = TRUE)
  buat_laporan(path = tmp, anggota = c("Nama A", "Nama B", "Nama C"), overwrite = TRUE)
  bab <- list.files(file.path(tmp, "bab"))
  expect_true(all(c("bab2_pemahaman_data.qmd", "bab3_persiapan_data.qmd",
                    "bab4_pemodelan.qmd", "bab5_evaluasi.qmd",
                    "bab6_penerapan_kesimpulan.qmd") %in% bab))
  idx <- readLines(file.path(tmp, "index.qmd"), warn = FALSE, encoding = "UTF-8")
  expect_false(any(grepl("{{INCLUDE_BAB}}", idx, fixed = TRUE)))
})

test_that("path_csl mengembalikan berkas yang ada", {
  expect_true(file.exists(path_csl()))
})

test_that("jumlah anggota dibatasi 3 sampai 7", {
  tmp <- file.path(tempdir(), "uji-anggota")
  on.exit(unlink(tmp, recursive = TRUE, force = TRUE), add = TRUE)
  expect_error(buat_laporan(path = tmp, anggota = c("A", "B"), overwrite = TRUE),
               "3 sampai 7")
  expect_error(
    buat_laporan(path = tmp, anggota = paste0("A", 1:8), overwrite = TRUE),
    "3 sampai 7"
  )
  expect_silent(suppressMessages(
    buat_laporan(path = tmp, anggota = paste0("A", 1:7), overwrite = TRUE)
  ))
})
