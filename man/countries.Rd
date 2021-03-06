% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/global.R
\name{countries}
\alias{countries}
\title{Countries}
\usage{
countries(consumer, access_token)
}
\arguments{
\item{consumer}{A consumer, created by \code{\link{consumer}}.}

\item{access_token}{An access token, created by \code{\link{access_token}}.}
}
\value{
A data frame with 27 variables:
\item{\code{league_id}}{League ID.}
\item{\code{league_name}}{League name.}
\item{\code{season}}{Current season.}
\item{\code{season_offset}}{Season offset to Swedish season.}
\item{\code{match_round}}{Current series match round.}
\item{\code{short_name}}{League short name.}
\item{\code{continent}}{Continent name.}
\item{\code{zone_name}}{Geographical zone name.}
\item{\code{english_name}}{League name in English.}
\item{\code{country_available}}{Is there a country related to the league?}
\item{\code{country_id}}{Country ID.}
\item{\code{country_name}}{Country name.}
\item{\code{currency_name}}{Currency name.}
\item{\code{currency_rate}}{Currency exchange rate to SEK (Swedish Krona).}
\item{\code{country_code}}{Country code.}
\item{\code{date_format}}{Date format.}
\item{\code{time_format}}{Time format.}
\item{\code{national_team_id}}{National team ID.}
\item{\code{u20_team_id}}{U20 national team ID.}
\item{\code{active_teams}}{Number of active teams.}
\item{\code{active_users}}{Number of active users.}
\item{\code{waiting_users}}{Number of waiting users.}
\item{\code{training_date}}{Next training update date and time.}
\item{\code{economy_date}}{Next economy update date and time.}
\item{\code{cup_match_date}}{Next cup round date and time.}
\item{\code{series_match_date}}{Next series round date and time.}
\item{\code{number_of_levels}}{Number of levels.}
}
\description{
Download a data frame with general information about countries.
}
\examples{
\dontrun{
df <- countries(consumer, access_token)
}
}
