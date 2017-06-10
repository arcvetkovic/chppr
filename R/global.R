#' Languages
#'
#' Download a data frame with available languages.
#'
#' @param consumer A consumer, created by \code{\link{consumer}}.
#' @param access_token An access token, created by \code{\link{access_token}}.
#'
#' @return A data frame with two variables:
#' \item{\code{language_id}}{Language ID.}
#' \item{\code{language_name}}{Language name.}
#' @export
#'
#' @examples
#' \dontrun{
#' df <- languages(consumer, access_token)
#' }
languages <- function(consumer, access_token) {
  query <- "file=worldlanguages&version=1.2"
  xml <- protected_resources(query, consumer, access_token, TRUE)
  nodes <- xml2::xml_find_all(xml, "LanguageList/Language")
  language_id <- xml_int(nodes, "LanguageID")
  language_name <- xml_chr(nodes, "LanguageName")
  data.frame(language_id,
             language_name,
             stringsAsFactors = FALSE)
}
