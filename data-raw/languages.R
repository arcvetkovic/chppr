cns <- consumer(Sys.getenv("CHPPR_CONSUMER_KEY"),
                Sys.getenv("CHPPR_CONSUMER_SECRET"))
tkn <- token(Sys.getenv("CHPPR_ACCESS_TOKEN"),
             Sys.getenv("CHPPR_ACCESS_TOKEN_SECRET"))
ht_languages <- languages(cns, tkn)
devtools::use_data(ht_languages, overwrite = TRUE)
