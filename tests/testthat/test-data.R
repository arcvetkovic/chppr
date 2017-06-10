context("Data")

test_that("ht_languages", {
  cns <- consumer(Sys.getenv("CHPPR_CONSUMER_KEY"),
                  Sys.getenv("CHPPR_CONSUMER_SECRET"))
  tkn <- token(Sys.getenv("CHPPR_ACCESS_TOKEN"),
               Sys.getenv("CHPPR_ACCESS_TOKEN_SECRET"))
  expect_equal(languages(cns, tkn), ht_languages)
})
