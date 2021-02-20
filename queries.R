library(pool)
library(dbplyr)
install.packages("ggplot2")

my_db <- dbPool(
  RMySQL::MySQL(), 
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest"
)

dbListTables(my_db)

dbListFields(my_db, 'CountryLanguage')

DataDB <- dbGetQuery(my_db, "select * from CountryLanguage")

class(DataDB)
head(DataDB)



library(dplyr)
esp <-  DataDB %>% filter(Language == "Spanish", Percentage > 0)

esp.df <- as.data.frame(esp) 

library(ggplot)
esp.df %>% ggplot(aes( x = CountryCode, y=Percentage, fill = IsOfficial )) + 
  geom_bin2d() +
  coord_flip()
