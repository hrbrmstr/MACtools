#' Update MAC Address Age Database
#'
#' Retrieve data file from <https://github.com/hdm/mac-ages>
#'
#' @md
#' @export
update_mac_age_db <- function() {

  readr::read_csv(
    file = "https://github.com/hdm/mac-ages/blob/master/data/mac-ages.csv?raw=true",
    col_names = c("X1", "date", "source"),
    col_types = readr::cols(
      X1 = readr::col_character(),
      date = readr::col_date(format = ""),
      source = readr::col_character()
    )
  ) -> mac_age_db

  pm <- stri_split_fixed(mac_age_db$X1, "/", n = 2, simplify = TRUE)

  mac_age_db$prefix <- pm[,1]
  mac_age_db$mask <- pm[,2]
  mac_age_db$to_match <- mac_to_binary_string(mac_age_db$prefix)
  mac_age_db$to_match <- substr(mac_age_db$to_match, 1, as.integer(mac_age_db$mask))
  mac_age_db$X1 <- NULL

  class(mac_age_db) <- c("tbl_df", "tbl", "data.frame")

  save(mac_age_db, file = system.file("data/mac_age_db.rda", package = "MACtools"))

  rebuild_search_tries()

}