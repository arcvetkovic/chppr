context("OAuth")

test_that("create consumer and token", {
  cns <- consumer("3qxJ4m36ONdmkQxVES9xW5",
                  "nOhqxax1vDLElZPXgSzYOWIGWbDTQD1BpegtGPz4sCu")
  expect_is(cns, "consumer")
  tkn <- token("OpDVf2v0vuD31yW7", "ASyuUmShpiodN2WX")
  expect_is(tkn, "token")
})

test_that("get request token", {
  cns <- consumer(Sys.getenv("CHPPR_CONSUMER_KEY"),
                  Sys.getenv("CHPPR_CONSUMER_SECRET"),
                  NULL)
  expect_error(request_token(cns))
  cns <- consumer(Sys.getenv("CHPPR_CONSUMER_KEY"),
                  Sys.getenv("CHPPR_CONSUMER_SECRET"))
  expect_is(request_token(cns), "token")
})

test_that("get access token", {
  cns <- consumer(Sys.getenv("CHPPR_CONSUMER_KEY"),
                  Sys.getenv("CHPPR_CONSUMER_SECRET"))
  rtkn <- request_token(cns)
  aurl <- authorization_url(cns, rtkn)
  session <- rvest::html_session(aurl)
  form <- rvest::html_form(session)[[1]]
  form <- rvest::set_values(form,
                            txtUsername = Sys.getenv("CHPPR_USERNAME"),
                            txtPassword = Sys.getenv("CHPPR_PASSWORD"))
  session <- rvest::submit_form(session, form)
  content <- httr::content(session$response)
  vrf <- rvest::html_text(rvest::xml_nodes(content, "pre"))
  expect_is(access_token(cns, rtkn, vrf), "token")
})
