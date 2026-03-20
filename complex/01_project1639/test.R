
test <- list(x = new.env())
test$x$n = 1
test$x$n

test2 <- test 
test2$x$m <- 2

test$x$m

test2 <- test 


