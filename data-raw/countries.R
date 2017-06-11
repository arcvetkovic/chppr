cns <- consumer(Sys.getenv("CHPPR_CONSUMER_KEY"),
                Sys.getenv("CHPPR_CONSUMER_SECRET"))
tkn <- token(Sys.getenv("CHPPR_ACCESS_TOKEN"),
             Sys.getenv("CHPPR_ACCESS_TOKEN_SECRET"))
ht_countries <- countries(cns, tkn)
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
ht_countries <- ht_countries[, vars]
devtools::use_data(ht_countries, overwrite = TRUE)
