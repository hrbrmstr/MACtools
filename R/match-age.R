.mac_match_age <- function(x) {

  a_mtch <- NA

  mb <- mac_to_binary_string(x)

  for (a_mask in .pkgenv$age_masks) {
    lk4a <- substr(mb, 1, a_mask)
    a_mtch <- triebeard::longest_match(.pkgenv$age_trie, lk4a)
    if (!is.na(a_mtch)) {
      ret <- .pkgenv$mac_age_db[.pkgenv$mac_age_db$prefix == a_mtch, ]
      ret$orig <- x
      return(ret[, c("orig", "date", "source", "prefix", "mask")])
    }
  }

  return(
    data.frame(
      orig = x,
      date = as.Date(NA),
      source = NA_character_,
      prefix = NA_character_,
      mask = NA_character_,
      stringsAsFactors = FALSE
    )
  )

}

#' Lookup ages of MAC addresses
#'
#' @md
#' @param x character vector of MAC address. Each MAC address can be in any
#'        case, the octets do not need to be 0-prefixed, and it doesn't matter
#'        if the octets are separated by a `:` or if they are just contiguous.
#'        If they _are_contiguous, that &mdash; by definition &mdash; means
#'        each octet is 0-prefixed.
#' @return data frame
#' @export
#' @examples
#' c(
#'   "2e:ab:a4:38:20:69", "70:26:5:19:23:25", "b8:e8:56:35:36:4",
#'   "f4:f5:d8:df:67:44", "44:d9:e7:7a:9e:25", "f4:f5:d8:a7:94:66",
#'   "a4:77:33:f2:50:30", "0:3e:e1:c3:9d:7a", "f0:23:b9:eb:42:4",
#'   "c8:69:cd:28:5a:7d", "d4:85:64:74:49:de", "3c:7:54:52:fe:11"
#' ) -> macs
#'
#' mac_match_age()
mac_match_age <- function(x) {

  out <- do.call(rbind.data.frame, lapply(x, .mac_match_age))
  class(out) <- c("tbl_df", "tbl", "data.frame")
  out

}