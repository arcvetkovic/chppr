#' Countries
#'
#' Download a data frame with general information about countries.
#'
#' @param consumer A consumer, created by \code{\link{consumer}}.
#' @param access_token An access token, created by \code{\link{access_token}}.
#'
#' @return A data frame with 27 variables:
#' \item{\code{league_id}}{League ID.}
#' \item{\code{league_name}}{League name.}
#' \item{\code{season}}{Current season.}
#' \item{\code{season_offset}}{Season offset to Swedish season.}
#' \item{\code{match_round}}{Current series match round.}
#' \item{\code{short_name}}{League short name.}
#' \item{\code{continent}}{Continent name.}
#' \item{\code{zone_name}}{Geographical zone name.}
#' \item{\code{english_name}}{League name in English.}
#' \item{\code{country_available}}{Is there a country related to the league?}
#' \item{\code{country_id}}{Country ID.}
#' \item{\code{country_name}}{Country name.}
#' \item{\code{currency_name}}{Currency name.}
#' \item{\code{currency_rate}}{Currency exchange rate to SEK (Swedish Krona).}
#' \item{\code{country_code}}{Country code.}
#' \item{\code{date_format}}{Date format.}
#' \item{\code{time_format}}{Time format.}
#' \item{\code{national_team_id}}{National team ID.}
#' \item{\code{u20_team_id}}{U20 national team ID.}
#' \item{\code{active_teams}}{Number of active teams.}
#' \item{\code{active_users}}{Number of active users.}
#' \item{\code{waiting_users}}{Number of waiting users.}
#' \item{\code{training_date}}{Next training update date and time.}
#' \item{\code{economy_date}}{Next economy update date and time.}
#' \item{\code{cup_match_date}}{Next cup round date and time.}
#' \item{\code{series_match_date}}{Next series round date and time.}
#' \item{\code{number_of_levels}}{Number of levels.}
#' @export
#'
#' @examples
#' \dontrun{
#' df <- countries(consumer, access_token)
#' }
countries <- function(consumer, access_token) {
  query <- "file=worlddetails&version=1.8"
  xml <- protected_resources(query, consumer, access_token, TRUE)
  nodes <- xml2::xml_find_all(xml, "LeagueList/League")
  country_available <- xml2::xml_find_first(nodes, "Country")
  country_available <- xml2::xml_attr(country_available, "Available")
  country_available <- as.logical(country_available)
  data.frame(league_id = xml_int(nodes, "LeagueID"),
             league_name = xml_chr(nodes, "LeagueName"),
             season = xml_int(nodes, "Season"),
             season_offset = xml_int(nodes, "SeasonOffset"),
             match_round = xml_int(nodes, "MatchRound"),
             short_name = xml_chr(nodes, "ShortName"),
             continent = xml_chr(nodes, "Continent"),
             zone_name = xml_chr(nodes, "ZoneName"),
             english_name = xml_chr(nodes, "EnglishName"),
             country_available,
             country_id = xml_int(nodes, "Country/CountryID"),
             country_name = xml_chr(nodes, "Country/CountryName"),
             currency_name = xml_chr(nodes, "Country/CurrencyName"),
             currency_rate = xml_dbl(nodes, "Country/CurrencyRate"),
             country_code = xml_chr(nodes, "Country/CountryCode"),
             date_format = xml_chr(nodes, "Country/DateFormat"),
             time_format = xml_chr(nodes, "Country/TimeFormat"),
             national_team_id = xml_int(nodes, "NationalTeamId"),
             u20_team_id = xml_int(nodes, "U20TeamId"),
             active_teams = xml_int(nodes, "ActiveTeams"),
             active_users = xml_int(nodes, "ActiveUsers"),
             waiting_users = xml_int(nodes, "WaitingUsers"),
             training_date = xml_dttm(nodes, "TrainingDate"),
             economy_date = xml_dttm(nodes, "EconomyDate"),
             cup_match_date = xml_dttm(nodes, "CupMatchDate"),
             series_match_date = xml_dttm(nodes, "SeriesMatchDate"),
             number_of_levels = xml_int(nodes, "NumberOfLevels"),
             stringsAsFactors = FALSE)
}

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
