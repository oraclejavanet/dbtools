context("Test connections")

test_that("testConnection", {

  workingConnection <- Credentials(drv = SQLite, dbname = ":memory:")
  testthat::expect_true(testConnection(workingConnection, function(...) NULL))

  nonWorkingConnection <- Credentials(drv = MySQL, dbname = "Nirvana")
  testthat::expect_false(testConnection(nonWorkingConnection, function(...) NULL))

  defunctConnections <- Credentials(drv = MySQL, dbname = c("Nirvana", "Walhalla"))
  testthat::expect_false(testConnection(defunctConnections, loggerSuppress))

  testthat::expect_match(
    testthat::evaluate_promise(
      testConnection(defunctConnections))$output, "FAILED")

})
