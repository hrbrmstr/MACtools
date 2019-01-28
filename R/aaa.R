set_names <- function (object = nm, nm) {
  names(object) <- nm
  object
}

set_names(
  c("0000", "0001", "0010", "0011", "0100", "0101", "0110", "0111", "1000",
    "1001", "1010", "1011", "1100", "1101", "1110", "1111", "1010", "1011",
    "1100", "1101", "1110", "1111"),
  c('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C',
    'D', 'E', 'F', 'a', 'b', 'c', 'd', 'e', 'f')
) -> hex_map

.pkgenv <- new.env(parent=emptyenv())

#' Rebuild in-memory search tries
#'
#' The search structures created by `triebeard` are full of external pointers
#' which point to the deep, dark void when bad things happen to R sessions.
#' When the package reloads everything _should_ return to normal, but you
#' can use this function to rebuild the in-memory search structures at any time.
#'
#' @md
#' @export
rebuild_search_tries <- function() {

  data("mac_age_db", envir = .pkgenv, package = "MACtools")
  data("mac_registry_data", envir = .pkgenv, package = "MACtools")

  triebeard::trie(
    .pkgenv$mac_age_db$to_match,
    .pkgenv$mac_age_db$prefix
  ) -> age_trie

  age_masks <- as.integer(unique(.pkgenv$mac_age_db$mask))

  assign("age_trie", age_trie, envir = .pkgenv)
  assign("age_masks", age_masks, envir = .pkgenv)

  triebeard::trie(
    .pkgenv$mac_registry_data$to_match,
    .pkgenv$mac_registry_data$assignment
  ) -> reg_trie

  reg_masks <- sort(unique(.pkgenv$mac_registry_data$mask), decreasing = TRUE)

  assign("reg_trie", reg_trie, envir = .pkgenv)
  assign("reg_masks", reg_masks, envir = .pkgenv)

}
