
load("./test.RData")
test <- st.cancer1@plots
saveRDS(test, "debugPlots.rds")

plots <- readRDS("./debugPlots.rds")
saveRDS(sessionInfo(), "debugSessionInfo.rds")


