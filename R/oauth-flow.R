#' Request Token
#'
#' Get a request token.
#'
#' @param consumer A consumer, created by \code{\link{consumer}}.
#'
#' @return A request token, an object of class \code{"token"}.
#' @export
#'
#' @examples
#' \dontrun{
#' # Consumer key and secret below are for illustrative purposes only
#' cns <- consumer("3qxJ4m36ONdmkQxVES9xW5",
#'                 "nOhqxax1vDLElZPXgSzYOWIGWbDTQD1BpegtGPz4sCu")
#' rtkn <- request_token(cns)
#' }
request_token <- function(consumer) {
  url <- oauth_url()$request_token
  response <- httr::GET(url, oauth_header(url, consumer))
  content <- httr::content(response, "text", "text/html", "UTF-8")
  if (response$status_code != 200L) {
    html <- xml2::read_html(content, "UTF-8")
    title <- xml2::xml_find_first(html, "head/title")
    title <- xml2::xml_text(title)
    stop(title)
  }
  content <- strsplit(content, "&")[[1]]
  content_fields <- sapply(strsplit(content, "="), `[`, 1)
  content_values <- sapply(strsplit(content, "="), `[`, 2)
  content <- as.list(stats::setNames(content_values, content_fields))
  if (is.null(content$oauth_token))
    stop("Cannot parse request token.")
  if (is.null(content$oauth_token_secret))
    stop("Cannot parse request token secret.")
  token(content$oauth_token, content$oauth_token_secret)
}
