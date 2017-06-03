#' OAuth Consumer
#'
#' Create a CHPP product (a consumer in OAuth terminology).
#'
#' @param key Consumer key.
#' @param secret Consumer secret.
#' @param callback Callback URL (\code{"oob"} by default).
#' @param challenge Manage challenges?
#' @param order Set match orders?
#' @param youth Manage youth players?
#' @param training Set training?
#' @param bid Place bid?
#'
#' @return An object of class \code{"consumer"}.
#' @export
#'
#' @examples
#' # Consumer key and secret below are for illustrative purposes only
#' cns <- consumer("3qxJ4m36ONdmkQxVES9xW5",
#'                 "nOhqxax1vDLElZPXgSzYOWIGWbDTQD1BpegtGPz4sCu")
#' # Ask for permission to manage challenges
#' cns <- consumer("3qxJ4m36ONdmkQxVES9xW5",
#'                 "nOhqxax1vDLElZPXgSzYOWIGWbDTQD1BpegtGPz4sCu",
#'                 challenge = TRUE)
consumer <- function(key, secret, callback = "oob",
                     challenge = FALSE, order = FALSE, youth = FALSE,
                     training = FALSE, bid = FALSE) {
  structure(list(key = key,
                 secret = secret,
                 callback = callback,
                 challenge = challenge,
                 order = order,
                 youth = youth,
                 training = training,
                 bid = bid),
            class = "consumer")
}

#' @export
print.consumer <- function(x, ...) {
  cat("Consumer key:         ", x$key, "\n", sep = "")
  cat("Consumer secret:      ", x$secret, "\n", sep = "")
  cat("Callback URL:         ", x$callback, "\n", sep = "")
  cat("Manage challenges:    ", x$challenge, "\n", sep = "")
  cat("Set match orders:     ", x$order, "\n", sep = "")
  cat("Manage youth players: ", x$youth, "\n", sep = "")
  cat("Set training:         ", x$training, "\n", sep = "")
  cat("Place bid:            ", x$bid, "\n", sep = "")
}
