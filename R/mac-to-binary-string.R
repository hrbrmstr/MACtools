#' Convert MAC address character vector to a binary string representation
#'
#' @md
#' @param x character vector of MAC address. Each MAC address can be in any
#'        case, the octets do not need to be 0-prefixed, and it doesn't matter
#'        if the octets are separated by a `:` or if they are just contiguous.
#'        If they _are_contiguous, that &mdash; by definition &mdash; means
#'        each octet is 0-prefixed.
#' @return a character vector of binary strings
#' @export
#' @examples
#' mac_to_binary_string(c("f023b9eb4204", "f0:23:b9:eb:42:4", "F023B9eB4204"))
mac_to_binary_string <- function(x) {

  sapply(x, function(y) {
    if (grepl(":", y)) {
      paste0(
        hex_map[unlist(strsplit(sprintf("%02s", strsplit(y, ":")[[1]]), ""), use.names = FALSE)],
        collapse=""
      )
    } else {
      paste0(hex_map[strsplit(y, "")[[1]]], collapse="")
    }
  }, USE.NAMES = FALSE)

}