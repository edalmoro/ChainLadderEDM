test.Mack1999 <- function() {
    ## by Markus Gesmann
    ## 2013-02-26 Don't check names of "check-values" f and f.se
    ## Test the MackChainLadder against example given in Mack's 1999 paper
    MRT <- MackChainLadder(Mortgage, tail=1.05, tail.sigma=71, tail.se=0.02, est.sigma="Mack")
    ## Table 1 in the above paper
    f <- c(11.10, 4.092, 1.708, 1.276, 1.139, 1.069, 1.026, 1.023, 1.05)
    f.se <- c(2.24, 0.517, 0.122, 0.051, 0.042, 0.023, 0.015, 0.012, 0.02)
    F.se3 <- c(7.38, 1.89, 0.357, 0.116, 0.078, 0.033, 0.015, 0.007, 0.03)
    sig <- c(1337, 988.5, 440.1, 207, 164.2, 74.60, 35.49, 16.89,71)
    ## test output from MackChainLadder
    checkEquals(MRT$f, f,tol=0.001, checkNames = FALSE)
    checkEquals(MRT$f.se, f.se,tol=0.01, checkNames = FALSE)
    checkEquals(as.numeric(MRT$F.se[3,]),F.se3,tol=0.001)
    checkEquals(as.numeric(MRT$sigma),sig,tol=0.0001)
}
test.MackRAA <- function() {
    ## by Dan Murphy
    ## Make sure MackChainLadder run on RAA returns the correct overall
    ## total standard error, 26,880.74
    checkEquals(sprintf("%.2f", MackChainLadder(RAA)$Total.Mack.S.E), "26880.74")
}
test.MackRAA_tail_equals_1.05 <- function() {
    ## by Dan Murphy
    ## Make sure MackChainLadder run on RAA returns the correct overall
    ## total standard error, 28,587.35, when input tail factor is 1.05
    checkEquals(sprintf("%.2f", MackChainLadder(RAA, est.sigma = "Mack", tail = 1.05)$Total.Mack.S.E), "28669.91")
}
test.MackMortgageCVWithTail <- function() {
    ## by Dan Murphy
    ## Make sure amount in example checks out
    MRT <- MackChainLadder(Mortgage, tail=1.05, tail.se = .05)
    checkEquals(round(tail(MRT$Total.ParameterRisk, 1) / summary(MRT)$Totals["IBNR", ], 2), .19)
}
# test.NoDevelopmentExample <- function(){
#   # If there's essentially no development from one age to the next, lm will warn
#   # that it's "essentially perfect fit". Want to replace that with a better message.
#   # The solution is to suppress that message, detect a perfect.fit separately,
#   # and "warning" an informational message to the console.
#   x <- matrix(byrow = TRUE, nrow = 4, ncol = 4,
#               dimnames = list(origin = LETTERS[1:4], dev = 1:4),
#               data = c(
#                 100, 105, 105.00001, 105.00001,
#                 200, 210, 210.00001, NA,
#                 300, 315, NA, NA,
#                 400, NA, NA, NA)
#   )
#   # This should no longer generate a warning
#   m <- tryCatch(MackChainLadder(x, est.sigma = "Mack"), warning = function(w) w)
#   checkTrue(inherits(m, "warning"))
# }
# test.loglinear.NA.Example <- function(){
#   x <- matrix(byrow = TRUE, nrow = 4, ncol = 4,
#               dimnames = list(origin = LETTERS[1:4], dev = 1:4),
#               data = c(
#                 100, 105, 105.00001, 105.00001,
#                 200, 210, 210.00001, NA,
#                 300, 315, NA, NA,
#                 400, NA, NA, NA)
#   )
#   # This should no longer generate an error
#   m <- tryCatch(MackChainLadder(x, est.sigma = "log-linear"), error = function(e) e)
#   checkTrue(!inherits(m, "error"))
# }


test.MackNANissue <- function(){
  
  MackNANTriIssue <- structure(c(72, NA, 77, NA, 94, NA, 82, NA, 79, NA, 101, NA, 
                                 101, NA, 124, NA, 124, NA, 100, NA, 100, NA, 100, NA, 100, NA, 
                                 100, NA, 100, NA, 100, NA, 100, NA, 100, NA, 100, NA, 72, NA, 
                                 77, NA, 94, NA, 82, NA, 79, NA, 101, NA, 101, NA, 124, NA, 124, 
                                 NA, 100, NA, 100, NA, 100, NA, 100, NA, 100, NA, 100, NA, 100, 
                                 NA, 100, NA, 100, NA, 100, NA, 72, NA, 77, NA, 94, NA, 82, NA, 
                                 79, NA, 101, NA, 101, NA, 124, NA, 124, NA, 100, NA, 100, NA, 
                                 100, NA, 100, NA, 100, NA, 100, NA, 100, NA, 100, NA, 100, NA, 
                                 NA, NA, 72, NA, 77, NA, 94, NA, 82, NA, 79, NA, 101, NA, 101, 
                                 NA, 124, NA, 124, NA, 100, NA, 100, NA, 100, NA, 100, NA, 100, 
                                 NA, 100, NA, 100, NA, 100, NA, 100, NA, NA, NA, 72, NA, 77, NA, 
                                 94, NA, 82, NA, 79, NA, 101, NA, 101, NA, 124, NA, 124, NA, 100, 
                                 NA, 100, NA, 100, NA, 100, NA, 100, NA, 100, NA, 100, NA, 100, 
                                 NA, NA, NA, NA, NA, 72, NA, 77, NA, 94, NA, 82, NA, 79, NA, 101, 
                                 NA, 101, NA, 124, NA, 124, NA, 100, NA, 100, NA, 100, NA, 100, 
                                 NA, 100, NA, 100, NA, 100, NA, 100, NA, NA, NA, NA, NA, 72, NA, 
                                 77, NA, 94, NA, 82, NA, 79, NA, 101, NA, 101, NA, 124, NA, 124, 
                                 NA, 100, NA, 100, NA, 100, NA, 100, NA, 100, NA, 100, NA, 100, 
                                 NA, NA, NA, NA, NA, NA, NA, 72, NA, 77, NA, 94, NA, 82, NA, 79, 
                                 NA, 101, NA, 101, NA, 124, NA, 124, NA, 100, NA, 100, NA, 100, 
                                 NA, 100, NA, 100, NA, 100, NA, 100, NA, NA, NA, NA, NA, NA, NA, 
                                 72, NA, 77, NA, 94, NA, 82, NA, 79, NA, 101, NA, 101, NA, 124, 
                                 NA, 124, NA, 100, NA, 100, NA, 100, NA, 100, NA, 100, NA, 100, 
                                 NA, NA, NA, NA, NA, NA, NA, NA, NA, 72, NA, 77, NA, 94, NA, 82, 
                                 NA, 79, NA, 101, NA, 101, NA, 124, NA, 124, NA, 100, NA, 100, 
                                 NA, 100, NA, 100, NA, 100, NA, 100, NA, NA, NA, NA, NA, NA, NA, 
                                 NA, NA, 72, NA, 77, NA, 94, NA, 82, NA, 79, NA, 101, NA, 101, 
                                 NA, 124, NA, 124, NA, 100, NA, 100, NA, 100, NA, 100, NA, 100, 
                                 NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 72, NA, 77, NA, 94, 
                                 NA, 82, NA, 79, NA, 101, NA, 101, NA, 124, NA, 124, NA, 100, 
                                 NA, 100, NA, 100, NA, 100, NA, 100, NA, NA, NA, NA, NA, NA, NA, 
                                 NA, NA, NA, NA, 72, NA, 77, NA, 94, NA, 82, NA, 79, NA, 101, 
                                 NA, 101, NA, 124, NA, 124, NA, 100, NA, 100, NA, 100, NA, 100, 
                                 NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 72, NA, 77, 
                                 NA, 94, NA, 82, NA, 79, NA, 101, NA, 101, NA, 124, NA, 124, NA, 
                                 100, NA, 100, NA, 100, NA, 100, NA, NA, NA, NA, NA, NA, NA, NA, 
                                 NA, NA, NA, NA, NA, 72, NA, 77, NA, 94, NA, 82, NA, 79, NA, 101, 
                                 NA, 101, NA, 124, NA, 124, NA, 100, NA, 100, NA, 100, NA, NA, 
                                 NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 72, NA, 77, 
                                 NA, 94, NA, 82, NA, 79, NA, 101, NA, 101, NA, 124, NA, 124, NA, 
                                 100, NA, 100, NA, 100, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 
                                 NA, NA, NA, NA, NA, 72, NA, 77, NA, 94, NA, 82, NA, 79, NA, 101, 
                                 NA, 101, NA, 124, NA, 124, NA, 100, NA, 100, NA, NA, NA, NA, 
                                 NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 72, NA, 77, 
                                 NA, 94, NA, 82, NA, 79, NA, 101, NA, 101, NA, 124, NA, 124, NA, 
                                 100, NA, 100, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 
                                 NA, NA, NA, NA, NA, 72, NA, 77, NA, 94, NA, 82, NA, 79, NA, 101, 
                                 NA, 101, NA, 124, NA, 124, NA, 100, NA, NA, NA, NA, NA, NA, NA, 
                                 NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 72, NA, 77, NA, 
                                 94, NA, 82, NA, 79, NA, 101, NA, 101, NA, 124, NA, 124, NA, 100, 
                                 NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 
                                 NA, NA, NA, 100, NA, 100, NA, 100, NA, 100, NA, 100, NA, 100, 
                                 NA, 100, NA, 100, NA, 100, NA, NA, NA, NA, NA, NA, NA, NA, NA, 
                                 NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 100, NA, 100, 
                                 NA, 100, NA, 100, NA, 100, NA, 100, NA, 100, NA, 100, NA, 100, 
                                 NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 
                                 NA, NA, NA, NA, NA, 100, NA, 100, NA, 100, NA, 100, NA, 100, 
                                 NA, 100, NA, 100, NA, 100, NA, NA, NA, NA, NA, NA, NA, NA, NA, 
                                 NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 100, 
                                 NA, 100, NA, 100, NA, 100, NA, 100, NA, 100, NA, 100, NA, 100, 
                                 NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 
                                 NA, NA, NA, NA, NA, NA, NA, 100, NA, 100, NA, 100, NA, 100, NA, 
                                 100, NA, 100, NA, 100, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 
                                 NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 100, 
                                 NA, 100, NA, 100, NA, 100, NA, 100, NA, 100, NA, 100, NA, NA, 
                                 NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 
                                 NA, NA, NA, NA, NA, NA, NA, 100, NA, 100, NA, 100, NA, 100, NA, 
                                 100, NA, 100, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 
                                 NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 100, 
                                 NA, 100, NA, 100, NA, 100, NA, 100, NA, 100, NA, NA, NA, NA, 
                                 NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 
                                 NA, NA, NA, NA, NA, NA, NA, 100, NA, 100, NA, 100, NA, 100, NA, 
                                 100, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 
                                 NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 100, 
                                 NA, 100, NA, 100, NA, 100, NA, 100, NA, NA, NA, NA, NA, NA, NA, 
                                 NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 
                                 NA, NA, NA, NA, NA, NA, 100, NA, 100, NA, 100, NA, 100, NA, NA, 
                                 NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 
                                 NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 100, NA, 
                                 100, NA, 100, NA, 100, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 
                                 NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 
                                 NA, NA, NA, NA, NA, 100, NA, 100, NA, 100, NA, NA, NA, NA, NA, 
                                 NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 
                                 NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 100, NA, 100, 
                                 NA, 100, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 
                                 NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 
                                 NA, NA, NA, NA, 100, NA, 100, NA, NA, NA, NA, NA, NA, NA, NA, 
                                 NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 
                                 NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 100, NA, 100, NA, 
                                 NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 
                                 NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 
                                 NA, NA, 100, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 
                                 NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 
                                 NA, NA, NA, NA, NA, NA, NA, NA, NA, 100, NA, NA, NA, NA, NA, 
                                 NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 
                                 NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA
  ), .Dim = c(38L, 38L), 
  .Dimnames = structure(
    list(origin = 
           c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", 
             "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", 
             "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", 
             "36", "37", "38"), 
         dev = c("V1", "V2", "V3", "V4", "V5", "V6", 
                 "V7", "V8", "V9", "V10", "V11", "V12", "V13", "V14", "V15", "V16", 
                 "V17", "V18", "V19", "V20", "V21", "V22", "V23", "V24", "V25", 
                 "V26", "V27", "V28", "V29", "V30", "V31", "V32", "V33", "V34", 
                 "V35", "V36", "V37", "V38")), .Names = c("origin", "dev")), 
  class = c("triangle", 
            "matrix"))
  checkEquals(summary(MackChainLadder(MackNANTriIssue, est.sigma="Mack"))$Totals[1,1],
              1900)
}

test.Mack1993 <- function() {
  ## by Eric Dal Moro
  ## Check the additional Skewness elements addedto MachChainLadder function on the Mack 1993 triangles
  ## Results are in the paper by Eric Dal Moro:
  ## "An approximation of the non-life reserve risk distribution using the Cornish-Fisher expansion"
  ## available at SSRN: https://ssrn.com/abstract=2965384
  MRT <- MackChainLadder(Mack1993, est.sigma="Mack")
  ## Table 1 in the above paper
  
  Skewness <- c(0, 0, -0.029, -0.043, -0.001, 0.180, 0.055, 0.267, 0.286, 0.314)
  OverSkew <- 0.214
  OverSkewCalc <- MRT$OverSkew/MRT$Total.Mack.S.E^3
  
  ## test output from MackChainLadder
  checkEquals(MRT$Skewness, Skewness,tol=0.0015, checkNames = FALSE)
  checkEquals(OverSkewCalc, OverSkew,tol=0.0015, checkNames = FALSE)
}

test.SCORLiabProp <- function() {
  ## by Eric Dal Moro
  ## Check the additional Skewness elements addedto MachChainLadder function on the Mack 1993 triangles
  ## Results are in the paper by Eric Dal Moro:
  ## "An approximation of the non-life reserve risk distribution using the Cornish-Fisher expansion"
  ## available at SSRN: https://ssrn.com/abstract=2965384
  MRT <- MackChainLadder(SCORLiabProp, est.sigma="Mack")
  ## Table 1 in the above paper
  
  Skewness <- c(0, 0, -0.032, 0.157, -0.416, 0.542, 0.418, 0.392, 0.203, 0.226, 0.036, 0.048, 0.015, 0.060, 0.925)
  OverSkew <- 0.534
  OverSkewCalc <- MRT$OverSkew/MRT$Total.Mack.S.E^3
  
  ## test output from MackChainLadder
  checkEquals(MRT$Skewness, Skewness,tol=0.0015, checkNames = FALSE)
  checkEquals(OverSkewCalc, OverSkew,tol=0.0015, checkNames = FALSE)
}

test.SCORMotorNP <- function() {
  ## by Eric Dal Moro
  ## Check the additional Skewness elements addedto MachChainLadder function on the Mack 1993 triangles
  ## Results are in the paper by Eric Dal Moro:
  ## "An approximation of the non-life reserve risk distribution using the Cornish-Fisher expansion"
  ## available at SSRN: https://ssrn.com/abstract=2965384
  MRT <- MackChainLadder(SCORMotorNP, est.sigma="Mack")
  ## Table 1 in the above paper
  
  Skewness <- c(0, 0, -0.037, -0.138, -0.115, -0.026, 0.059, 0.101, 0.236, 0.185, 0.271, 0.142, 0.174, 0.278, 1.001)
  OverSkew <- 0.333
  OverSkewCalc <- MRT$OverSkew/MRT$Total.Mack.S.E^3
  
  ## test output from MackChainLadder
  checkEquals(MRT$Skewness, Skewness,tol=0.0015, checkNames = FALSE)
  checkEquals(OverSkewCalc, OverSkew,tol=0.0015, checkNames = FALSE)
}

test.EverestLiabProp <- function() {
  ## by Eric Dal Moro
  ## Check the additional Skewness elements addedto MachChainLadder function on the Mack 1993 triangles
  ## Results are in the paper by Eric Dal Moro:
  ## "An approximation of the non-life reserve risk distribution using the Cornish-Fisher expansion"
  ## available at SSRN: https://ssrn.com/abstract=2965384
  MRT <- MackChainLadder(EverestLiabProp, est.sigma="Mack")
  ## Table 1 in the above paper
  
  Skewness <- c(0, 0, 0.042, 0.087, 0.065, -0.268, -0.234, -0.164, 0.075, 0.157, 0.245, 0.289, 0.168, 0.231, 0.547)
  OverSkew <- 0.321
  OverSkewCalc <- MRT$OverSkew/MRT$Total.Mack.S.E^3
  
  ## test output from MackChainLadder
  checkEquals(MRT$Skewness, Skewness,tol=0.0015, checkNames = FALSE)
  checkEquals(OverSkewCalc, OverSkew,tol=0.0015, checkNames = FALSE)
}

test.EverestLiabNP <- function() {
  ## by Eric Dal Moro
  ## Check the additional Skewness elements addedto MachChainLadder function on the Mack 1993 triangles
  ## Results are in the paper by Eric Dal Moro:
  ## "An approximation of the non-life reserve risk distribution using the Cornish-Fisher expansion"
  ## available at SSRN: https://ssrn.com/abstract=2965384
  MRT <- MackChainLadder(EverestLiabNP, est.sigma="Mack")
  ## Table 1 in the above paper
  
  Skewness <- c(0, 0, -0.024, -0.016, -0.008, 0.100, 0.399, 0.241, 0.229, 0.129, 0.034, 0.224, 0.340, 0.017, 0.485)
  OverSkew <- 0.318
  OverSkewCalc <- MRT$OverSkew/MRT$Total.Mack.S.E^3
  
  ## test output from MackChainLadder
  checkEquals(MRT$Skewness, Skewness,tol=0.0015, checkNames = FALSE)
  checkEquals(OverSkewCalc, OverSkew,tol=0.0015, checkNames = FALSE)
}