#' OAuth Token
#'
#' Create a token.
#'
#' @param token Token.
#' @param secret Token secret.
#'
#' @return An object of class \code{"token"}.
#' @export
#'
#' @examples
#' # Token and secret below are for illustrative purposes only
#' tkn <- token("OpDVf2v0vuD31yW7", "ASyuUmShpiodN2WX")
token <- function(token, secret) {
  structure(list(token = token,
                 secret = secret),
            class = "token")
}

#' @export
print.token <- function(x, ...) {
  cat("Token:        ", x$token, "\n", sep = "")
  cat("Token secret: ", x$secret, "\n", sep = "")
}
