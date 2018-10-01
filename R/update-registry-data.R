c(
  "http://standards-oui.ieee.org/oui/oui.csv",
  "http://standards-oui.ieee.org/cid/cid.csv",
  "http://standards-oui.ieee.org/iab/iab.csv",
  "http://standards-oui.ieee.org/oui28/mam.csv",
  "http://standards-oui.ieee.org/oui36/oui36.csv"
) -> reg_sources

#' Update registry data
#'
#' Download/refresh/install IEEE MAC registry assignment metadata
#'
#' @md
#' @export
update_registry_data <- function() {

  lapply(reg_sources, function(x) {

    message("Downloading ", x, "...")

    x <- readr::read_csv(
      file = x,
      col_names = c("registry", "assignment", "organization_name", "organization_address"),
      col_types ="cccc"
    )

    x$assignment <- tolower(x$assignment)

    x

  }) -> reg_lst

  do.call(
    rbind.data.frame,
    reg_lst
  ) -> reg_df

  reg_df <- reg_df[order(reg_df$assignment),]
  reg_df <- reg_df[!duplicated(reg_df$assignment),]

  reg_df$to_match <- mac_to_binary_string(reg_df$assignment)
  reg_df$mask <- nchar(reg_df$to_match)

  class(reg_df) <- c("tbl_df", "tbl", "data.frame")

  save(reg_df, file = system.file("data/mac_registry_data.rda", package = "MACtools"))

  rebuild_search_tries()

}
