#' Hattrick Countries
#'
#' A data frame with general information about countries.
#'
#' @format A data frame with 129 rows and 18 columns:
#' \describe{
#'   \item{\code{league_id}}{League ID.}
#'   \item{\code{league_name}}{League name.}
#'   \item{\code{season_offset}}{Season offset to Swedish season.}
#'   \item{\code{short_name}}{League short name.}
#'   \item{\code{continent}}{Continent name.}
#'   \item{\code{zone_name}}{Geographical zone name.}
#'   \item{\code{english_name}}{League name in English.}
#'   \item{\code{country_available}}{Is there a country related to the league?}
#'   \item{\code{country_id}}{Country ID.}
#'   \item{\code{country_name}}{Country name.}
#'   \item{\code{currency_name}}{Currency name.}
#'   \item{\code{currency_rate}}{Currency exchange rate to SEK (Swedish Krona).}
#'   \item{\code{country_code}}{Country code.}
#'   \item{\code{date_format}}{Date format.}
#'   \item{\code{time_format}}{Time format.}
#'   \item{\code{national_team_id}}{National team ID.}
#'   \item{\code{u20_team_id}}{U20 national team ID.}
#'   \item{\code{number_of_levels}}{Number of levels.}
#' }
"ht_countries"

#' Hattrick Languages
#'
#' A data frame with available languages.
#'
#' @format A data frame with 57 rows and 2 columns:
#' \describe{
#'   \item{\code{language_id}}{Language ID.}
#'   \item{\code{language_name}}{Language name.}
#' }
"ht_languages"
