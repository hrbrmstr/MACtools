#include <Rcpp.h>
#include "mac-address.hpp"

using namespace Rcpp;

//' Test if MAC address strings are in canonical form
//'
//' The canonical form for MAC addresses strings is 6, 2-character
//' octets separated by colons. This function returns `TRUE` if
//' an address string is in canonical format.
//'
//' @md
//' @param mac character vector of MAC address strings
//' @export
//' @examples
//' is_canonical_mac("c8:69:cd:28:5a:7d")
// [[Rcpp::export]]
LogicalVector is_canonical_mac(std::vector < std::string > mac) {

  LogicalVector out(mac.size());

  for (unsigned int i=0; i<mac.size(); i++) {
    out[i] = MacAddress::isHexStringValid(mac[i]);
  }

  return(out);

}

//' Convert a charactrer vector of MAC addresses to
//' a `list` of `raw` vectors.
//'
//' @md
//' @param mac character vector of MAC address strings
//' @export
//' @examples
//' as_raw_mac("c8:69:cd:28:5a:7d")
// [[Rcpp::export]]
List as_raw_mac(std::vector < std::string > mac) {

  List out(mac.size());
  MacAddress m;

  for (unsigned int i=0; i<mac.size(); i++) {
    bool ok = m.setToHexString(mac[i]);
    if (!ok) {
      out[i] = RawVector();
    } else {
      RawVector v(6);
      for (unsigned int j=0; j<6; j++) v[j] = m[j];
      out[i] = v;
    }
  }

  return(out);

}

std::string join(const std::vector<std::string>& elements, const char* const separator) {
  switch (elements.size()) {
  case 0: return("");
  case 1: return(elements[0]);
  default:
    std::ostringstream os;
    std::copy(elements.begin(), elements.end()-1,
              std::ostream_iterator<std::string>(os, separator));
    os << *elements.rbegin();
    return(os.str());
  }
}

//' Converts a character vector of MAC addresses into canonical form
//'
//' The canonical form for MAC addresses strings is 6, 2-character
//' octets separated by colons. This function returns `TRUE` if
//' an address string is in canonical format.
//'
//' @md
//' @param mac character vector of MAC address strings
//' @export
//' @examples
//' canonicalize_mac("b8:e8:56:35:36:4")
// [[Rcpp::export]]
CharacterVector canonicalize_mac(std::vector < std::string > mac) {

  CharacterVector out(mac.size());

  for (unsigned int i=0; i<mac.size(); i++) {

    std::istringstream ss(mac[i]);
    std::string token;
    std::vector < std::string > ret(6);

    int j = 0;
    while(std::getline(ss, token, ':')) {
      if (token.length() == 1) {
        if (MacAddress::isHexDigitValid(token[0])) {
          token[0] = std::tolower(token[0]);
          ret[j++] = "0" + token;
        } else {
          out[i] = NA_STRING;
          break;
        }
      } else if (token.length() == 2) {
        if (MacAddress::isHexDigitValid(token[0]) &&
            MacAddress::isHexDigitValid(token[1])) {
          token[0] = std::tolower(token[0]);
          token[1] = std::tolower(token[1]);
          ret[j++] = token;
        } else {
          out[i] = NA_STRING;
          break;
        }
      } else {
        out[i] = NA_STRING;
        break;
      }
    }

    if (j==6) {
      out[i] = join(ret, ":");
    } else {
      out[i] = NA_STRING;
    }

  }

  return(out);

}





