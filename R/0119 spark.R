install.packages("sparklyr")
library(sparklyr)
spark_available_versions()
spark_install(version="3.0.0")

Sys.setenv(JAVA_HOME="C:/Program Files/Java/jdk-11.0.11")
sc <- spark_connect(master="local", version="3.0.0")
cars <- copy_to(sc, mtcars)
cars
#spark_disconnect(sc)
#spark_disconnect_all()

library(DBI)
dbGetQuery(sc, "SELECT count(*) FROM mtcars")
library(dplyr)
count(cars)

select(cars, hp, mpg) %>%sample_n(100) %>%collect() %>%plot()

model <- ml_linear_regression(cars, mpg ~ hp)
model

model %>%
  ml_predict(copy_to(sc, data.frame(hp = 250 + 10 * 1:10))) %>%
  transmute(hp = hp, mpg = prediction) %>%
  full_join(select(cars, hp, mpg)) %>%
  collect() %>% plot()

spark_write_csv(cars, "cars.csv")
cars <- spark_read_csv(sc, "cars.csv")

#install.packages("sparklyr.nested")
sparklyr.nested::sdf_nest(cars, hp) %>%
  group_by(cyl) %>%
  summarise(data = collect_list(data))

cars %>% spark_apply(~round(.x))

dir.create("input")
write.csv(mtcars, "input/cars_1.csv", row.names = F)

stream <- stream_read_csv(sc, "input/") %>%
  select(mpg, cyl, disp) %>%
  stream_write_csv("output/")

dir("output", pattern = ".csv")
write.csv(mtcars, "input/cars_2.csv", row.names = F)
dir("output", pattern = ".csv")

stream_stop(stream)

cars <- copy_to(sc, mtcars)


letters <- data.frame(x = letters, y = 1:length(letters))

dir.create("data-csv")
write.csv(letters[1:3, ], "data-csv/letters1.csv", row.names = FALSE)
write.csv(letters[1:3, ], "data-csv/letters2.csv", row.names = FALSE)

do.call("rbind", lapply(dir("data-csv", full.names = TRUE), read.csv))

library(sparklyr)
sc <- spark_connect(master = "local", version = "3.0.0")

spark_read_csv(sc, "data-csv/letters1.csv")








