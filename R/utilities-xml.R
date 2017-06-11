xml_chr <- function(x, xpath) {
  xml2::xml_text(xml2::xml_find_first(x, xpath))
}

xml_int <- function(x, xpath) {
  as.integer(xml_chr(x, xpath))
}

xml_dbl <- function(x, xpath) {
  as.numeric(gsub(",", "\\.", xml_chr(x, xpath)))
}

xml_dttm <- function(x, xpath) {
  strptime(xml_chr(x, xpath), "%Y-%m-%d %H:%M:%S", "CET")
}
