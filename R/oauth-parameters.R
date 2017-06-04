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

oauth_header <- function(url, consumer, token = NULL, verifier = NULL) {
  parameters <- oauth_parameters(url, consumer, token, verifier)
  authorization <- paste0("OAuth ",
                          paste0(oauth_encode(names(parameters)), "=\"",
                                 oauth_encode(parameters), "\"",
                                 collapse = ", "))
  httr::add_headers(Authorization = authorization)
}

oauth_parameters <- function(url, consumer, token = NULL, verifier = NULL) {
  url <- split_url(url)
  parameters <- list(oauth_callback = consumer$callback,
                     oauth_consumer_key = consumer$key,
                     oauth_nonce = paste(sample(c(letters, LETTERS, 0:9),
                                                10, TRUE),
                                         collapse = ""),
                     oauth_signature_method = "HMAC-SHA1",
                     oauth_token = token$token,
                     oauth_timestamp = as.integer(Sys.time()),
                     oauth_verifier = verifier,
                     oauth_version = "1.0")
  parameters <- parameters[sapply(parameters, function(x) !is.null(x))]
  string <- c(url$query, parameters)
  string <- stats::setNames(oauth_encode(string), oauth_encode(names(string)))
  string <- string[order(names(string))]
  string <- paste0(names(string), "=", string, collapse = "&")
  key <- paste0(oauth_encode(consumer$secret), "&",
                oauth_encode(token$secret))
  string <- paste0("GET", "&", oauth_encode(url$base), "&",
                   oauth_encode(string))
  parameters$oauth_signature <- httr::hmac_sha1(key, string)
  parameters[order(names(parameters))]
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

oauth_encode <- function(x) {
  encode <- function(x) {
    x <- as.character(x)
    characters <- strsplit(x, "")[[1]]
    ok <- !grepl("[^A-Za-z0-9_.~-]", characters)
    if (all(ok)) return(x)
    characters[!ok] <- sapply(characters[!ok],
                              function(x) paste0("%", toupper(charToRaw(x))))
    paste0(characters, collapse = "")
  }
  sapply(x, encode)
}
