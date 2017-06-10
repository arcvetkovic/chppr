xml_chr <- function(x, xpath) {
  xml2::xml_text(xml2::xml_find_first(x, xpath))
}

xml_int <- function(x, xpath) {
  xml2::xml_integer(xml2::xml_find_first(x, xpath))
}
