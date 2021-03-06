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

#' Authorization URL
#'
#' Build an authorization URL.
#'
#' @param consumer A consumer, created by \code{\link{consumer}}.
#' @param request_token A request token, created by \code{\link{request_token}}.
#'
#' @return An authorization URL.
#' @export
#'
#' @examples
#' \dontrun{
#' # Consumer key and secret below are for illustrative purposes only
#' cns <- consumer("3qxJ4m36ONdmkQxVES9xW5",
#'                 "nOhqxax1vDLElZPXgSzYOWIGWbDTQD1BpegtGPz4sCu")
#' rtkn <- request_token(cns)
#' aurl <- authorization_url(cns, rtkn)
#' }
authorization_url <- function(consumer, request_token) {
  url <- paste0(oauth_url()$authorize, "?oauth_token=", request_token$token)
  scope <- c("manage_challenges",
             "set_matchorder",
             "manage_youthplayers",
             "set_training",
             "place_bid")
  scope <- scope[as.logical(consumer[4:8])]
  if (length(scope)) url <- paste0(url, "&scope=", paste(scope, collapse = ","))
  url
}

#' Access Token
#'
#' Get an access token.
#'
#' @param consumer A consumer, created by \code{\link{consumer}}.
#' @param request_token A request token, created by \code{\link{request_token}}.
#' @param verifier A verification code obtained after successful authorization.
#'
#' @return An access token, an object of class \code{"token"}.
#' @export
#'
#' @examples
#' \dontrun{
#' # Consumer key and secret below are for illustrative purposes only
#' cns <- consumer("3qxJ4m36ONdmkQxVES9xW5",
#'                 "nOhqxax1vDLElZPXgSzYOWIGWbDTQD1BpegtGPz4sCu")
#' rtkn <- request_token(cns)
#' aurl <- authorization_url(cns, rtkn)
#' # Open in browser and enter your login name and password
#' # to obtain your verification code
#' browseURL(aurl)
#' # Verification code below is for illustrative purposes only
#' atkn <- access_token(cns, rtkn, "CzYLOvq9NniD5L8T")
#' }
access_token <- function(consumer, request_token, verifier) {
  url <- oauth_url()$access_token
  response <- httr::GET(url,
                        oauth_header(url, consumer, request_token, verifier))
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
    stop("Cannot parse access token.")
  if (is.null(content$oauth_token_secret))
    stop("Cannot parse access token secret.")
  token(content$oauth_token, content$oauth_token_secret)
}

#' Protected Resources
#'
#' Get protected resources (CHPP files in XML format).
#'
#' @param query A query string, e.g. \code{"file=teamdetails&version=3.4"}.
#' @param consumer A consumer, created by \code{\link{consumer}}.
#' @param access_token An access token, created by \code{\link{access_token}}.
#' @param parse Parse the result using \code{\link[xml2]{read_xml}}?
#'
#' @return If \code{parse} is \code{FALSE}, a character vector, otherwise an
#' object of class \code{"xml_document"}.
#' @export
#'
#' @examples
#' \dontrun{
#' # Consumer key and secret below are for illustrative purposes only
#' cns <- consumer("3qxJ4m36ONdmkQxVES9xW5",
#'                 "nOhqxax1vDLElZPXgSzYOWIGWbDTQD1BpegtGPz4sCu")
#' rtkn <- request_token(cns)
#' aurl <- authorization_url(cns, rtkn)
#' # Open in browser and enter your login name and password
#' # to obtain your verification code
#' browseURL(aurl)
#' # Verification code below is for illustrative purposes only
#' atkn <- access_token(cns, rtkn, "CzYLOvq9NniD5L8T")
#' pres <- protected_resources("file=teamdetails&version=3.4", cns, atkn)
#' }
protected_resources <- function(query, consumer, access_token, parse = FALSE) {
  if (substr(query, 1, 1) != "?") query <- paste0("?", query)
  url <- paste0(oauth_url()$protected_resources, query)
  response <- httr::GET(url, oauth_header(url, consumer, access_token))
  content <- httr::content(response, "text", "text/html", "UTF-8")
  if (response$status_code != 200L) {
    html <- xml2::read_html(content, "UTF-8")
    title <- xml2::xml_find_first(html, "head/title")
    title <- xml2::xml_text(title)
    stop(title)
  }
  if (parse) content <- xml2::read_xml(content)
  content
}
