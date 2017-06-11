context("Data")

test_that("ht_countries", {
  cns <- consumer(Sys.getenv("CHPPR_CONSUMER_KEY"),
                  Sys.getenv("CHPPR_CONSUMER_SECRET"))
  tkn <- token(Sys.getenv("CHPPR_ACCESS_TOKEN"),
               Sys.getenv("CHPPR_ACCESS_TOKEN_SECRET"))
  df <- countries(cns, tkn)
  vars <- c("league_id",
            "league_name",
            "season_offset",
            "short_name",
            "continent",
            "zone_name",
            "english_name",
            "country_available",
            "country_id",
            "country_name",
            "currency_name",
            "currency_rate",
            "country_code",
            "date_format",
            "time_format",
            "national_team_id",
            "u20_team_id",
            "number_of_levels")
  df <- df[, vars]
  expect_equal(df, ht_countries)
})

test_that("ht_languages", {
  cns <- consumer(Sys.getenv("CHPPR_CONSUMER_KEY"),
                  Sys.getenv("CHPPR_CONSUMER_SECRET"))
  tkn <- token(Sys.getenv("CHPPR_ACCESS_TOKEN"),
               Sys.getenv("CHPPR_ACCESS_TOKEN_SECRET"))
  expect_equal(languages(cns, tkn), ht_languages)
})
