#' OAuth URLs
#'
#' Hattrick OAuth URLs.
#'
#' @return A list with seven elements:
#' \item{\code{request_token}}{Request token URL.}
#' \item{\code{authorize}}{Authorize URL.}
#' \item{\code{authenticate}}{Authenticate URL.}
#' \item{\code{access_token}}{Access token URL.}
#' \item{\code{check_token}}{Check token URL.}
#' \item{\code{invalidate_token}}{Invalidate token URL.}
#' \item{\code{protected_resources}}{Protected resources URL.}
#' @export
#'
#' @examples
#' # Request token URL
#' oauth_url()$request_token
#' # Authorize URL
#' oauth_url()$authorize
#' # Access token URL
#' oauth_url()$access_token
oauth_url <- function() {
  list(
    request_token = "https://chpp.hattrick.org/oauth/request_token.ashx",
    authorize = "https://chpp.hattrick.org/oauth/authorize.aspx",
    authenticate = "https://chpp.hattrick.org/oauth/authenticate.aspx",
    access_token = "https://chpp.hattrick.org/oauth/access_token.ashx",
    check_token = "https://chpp.hattrick.org/oauth/check_token.ashx",
    invalidate_token = "https://chpp.hattrick.org/oauth/invalidate_token.ashx",
    protected_resources = "http://chpp.hattrick.org/chppxml.ashx"
  )
}

split_url <- function(url) {
  if (length(grep("[?]", url)) > 0) {
    base <- gsub("(.*)[?](.*)", "\\1", url)
    query <- gsub("(.*)[?](.*)", "\\2", url)
    query_fields <- sapply(strsplit(strsplit(query, "&")[[1]], "="), `[`, 1)
    query_values <- sapply(strsplit(strsplit(query, "&")[[1]], "="), `[`, 2)
    query <- as.list(stats::setNames(query_values, query_fields))
  } else {
    base <- url
    query <- NULL
  }
  list(base = base, query = query)
}
