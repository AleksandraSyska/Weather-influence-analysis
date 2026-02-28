library(httr)
library(jsonlite)

# Tworzenie zapytania HTTP i pobieranie danych JSON
url2 <- "https://archive-api.open-meteo.com/v1/archive?latitude=52.2298&longitude=21.0118&start_date=2022-01-01&end_date=2023-12-31&hourly=dew_point_2m,rain,snowfall,snow_depth,cloud_cover,shortwave_radiation&timezone=Europe%2FBerlin&tilt=49&azimuth=20"
response2 <- GET(url2)

# Sprawdzenie statusu odpowiedzi
if (http_status(response2)$category == "Success") {
  # Przetworzenie treści odpowiedzi jako tekst
  content_text2 <- content(response2, "text")
  
  # Konwersja danych JSON na listę w R
  data_list2 <- fromJSON(content_text2, flatten = TRUE)
  
  # Konwersja listy na ramkę danych (data frame)
  warszawa_wypadki <- as.data.frame(data_list2$hourly)
  print(head(warszawa_wypadki))
} else {
  print("Nie udało się pobrać danych z API")
}


library(readxl)
# Wczytanie danych z pliku Excel
tabela <- as.data.frame(read_excel("wypadki.xlsx"))

install.packages("lubridate")
# Załaduj potrzebne pakiety
library(dplyr)
library(lubridate)

# Konwertuj kolumnę 'time' na format daty i czasu
warszawa_wypadki$time <- ymd_hm(warszawa_wypadki$time)

# Dodaj kolumnę z miesiącem
warszawa_wypadki <- warszawa_wypadki %>%
  mutate(month = floor_date(time, "month"))

# Oblicz średnie, minimalne i maksymalne wartości według miesięcy
summary_stats <- warszawa_wypadki %>%
  group_by(month) %>%
  summarise(
    mean_dew_point_2m = mean(dew_point_2m, na.rm = TRUE),
    min_dew_point_2m = min(dew_point_2m, na.rm = TRUE),
    max_dew_point_2m = max(dew_point_2m, na.rm = TRUE),
    mean_rain = mean(rain, na.rm = TRUE),
    min_rain = min(rain, na.rm = TRUE),
    max_rain = max(rain, na.rm = TRUE),
    mean_snowfall = mean(snowfall, na.rm = TRUE),
    min_snowfall = min(snowfall, na.rm = TRUE),
    max_snowfall = max(snowfall, na.rm = TRUE),
    mean_snow_depth = mean(snow_depth, na.rm = TRUE),
    min_snow_depth = min(snow_depth, na.rm = TRUE),
    max_snow_depth = max(snow_depth, na.rm = TRUE),
    mean_cloud_cover = mean(cloud_cover, na.rm = TRUE),
    min_cloud_cover = min(cloud_cover, na.rm = TRUE),
    max_cloud_cover = max(cloud_cover, na.rm = TRUE),
    mean_shortwave_radiation = mean(shortwave_radiation, na.rm = TRUE),
    min_shortwave_radiation = min(shortwave_radiation, na.rm = TRUE),
    max_shortwave_radiation = max(shortwave_radiation, na.rm = TRUE)
  )

summary_stats <- as.data.frame(summary_stats)
# Wyświetl tabelę wyników
df <- cbind(tabela, summary_stats)
# Wczytanie niezbędnych bibliotek

library(ggplot2)
library(gridExtra)

# Funkcja pomocnicza do tworzenia wykresów
create_plot <- function(x, y, xlab, ylab, title) {
  ggplot(df, aes_string(x = x, y = y)) +
    geom_line(color = "blue", size = 1) +
    labs(title = title, x = xlab, y = ylab) +
    theme_minimal() +
    theme(
      plot.title = element_text(face = "bold")
    )
}

# Tworzenie wykresów dla wypadków
p1 <- create_plot("mean_dew_point_2m", "wypadki", "Średni punkt rosy (2m)", "Liczba wypadków", "Liczba wypadków w zależności od średniego punktu rosy (2m)")
p2 <- create_plot("mean_rain", "wypadki", "Średnie opady", "Liczba wypadków", "Liczba wypadków w zależności od średnich opadów")
p3 <- create_plot("mean_snowfall", "wypadki", "Średnie opady śniegu", "Liczba wypadków", "Liczba wypadków w zależności od średnich opadów śniegu")
p4 <- create_plot("mean_snow_depth", "wypadki", "Średnia pokrywa śnieżna", "Liczba wypadków", "Liczba wypadków w zależności od średniej pokrywy śnieżnej")
p5 <- create_plot("mean_cloud_cover", "wypadki", "Średnie zachmurzenie", "Liczba wypadków", "Liczba wypadków w zależności od średniego zachmurzenia")
p6 <- create_plot("mean_shortwave_radiation", "wypadki", "Średnie promieniowanie krótkofalowe", "Liczba wypadków", "Liczba wypadków w zależności od średniego promieniowania krótkofalowego")

# Tworzenie wykresów dla zabitych
p7 <- create_plot("mean_dew_point_2m", "zabici", "Średni punkt rosy (2m)", "Liczba zabitych", "Liczba zabitych w zależności od średniego punktu rosy (2m)")
p8 <- create_plot("mean_rain", "zabici", "Średnie opady", "Liczba zabitych", "Liczba zabitych w zależności od średnich opadów")
p9 <- create_plot("mean_snowfall", "zabici", "Średnie opady śniegu", "Liczba zabitych", "Liczba zabitych w zależności od średnich opadów śniegu")
p10 <- create_plot("mean_snow_depth", "zabici", "Średnia pokrywa śnieżna", "Liczba zabitych", "Liczba zabitych w zależności od średniej pokrywy śnieżnej")
p11 <- create_plot("mean_cloud_cover", "zabici", "Średnie zachmurzenie", "Liczba zabitych", "Liczba zabitych w zależności od średniego zachmurzenia")
p12 <- create_plot("mean_shortwave_radiation", "zabici", "Średnie promieniowanie krótkofalowe", "Liczba zabitych", "Liczba zabitych w zależności od średniego promieniowania krótkofalowego")

# Tworzenie wykresów dla rannych
p13 <- create_plot("mean_dew_point_2m", "ranni", "Średni punkt rosy (2m)", "Liczba rannych", "Liczba rannych w zależności od średniego punktu rosy (2m)")
p14 <- create_plot("mean_rain", "ranni", "Średnie opady", "Liczba rannych", "Liczba rannych w zależności od średnich opadów")
p15 <- create_plot("mean_snowfall", "ranni", "Średnie opady śniegu", "Liczba rannych", "Liczba rannych w zależności od średnich opadów śniegu")
p16 <- create_plot("mean_snow_depth", "ranni", "Średnia pokrywa śnieżna", "Liczba rannych", "Liczba rannych w zależności od średniej pokrywy śnieżnej")
p17 <- create_plot("mean_cloud_cover", "ranni", "Średnie zachmurzenie", "Liczba rannych", "Liczba rannych w zależności od średniego zachmurzenia")
p18 <- create_plot("mean_shortwave_radiation", "ranni", "Średnie promieniowanie krótkofalowe", "Liczba rannych", "Liczba rannych w zależności od średniego promieniowania krótkofalowego")

# Wyświetlenie wykresów
grid.arrange(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, ncol = 3)
print(p18)

m1 <- create_plot("max_dew_point_2m", "wypadki", "Maksymalny punkt rosy (2m)", "Liczba wypadków", "Liczba wypadków w zależności od maksymalnego punktu rosy (2m)")
m2 <- create_plot("max_rain", "wypadki", "Maksymalne opady", "Liczba wypadków", "Liczba wypadków w zależności od maksymalnych opadów")
m3 <- create_plot("max_snowfall", "wypadki", "Maksymalne opady śniegu", "Liczba wypadków", "Liczba wypadków w zależności od maksymalnych opadów śniegu")
m4 <- create_plot("max_snow_depth", "wypadki", "Maksymalna pokrywa śnieżna", "Liczba wypadków", "Liczba wypadków w zależności od maksymalnej pokrywy śnieżnej")
m5 <- create_plot("max_cloud_cover", "wypadki", "Maksymalne zachmurzenie", "Liczba wypadków", "Liczba wypadków w zależności od maksymalnego zachmurzenia")
m6 <- create_plot("max_shortwave_radiation", "wypadki", "Maksymalne promieniowanie krótkofalowe", "Liczba wypadków", "Liczba wypadków w zależności od maksymalnego promieniowania krótkofalowego")

# Tworzenie wykresów dla zabitych
m7 <- create_plot("max_dew_point_2m", "zabici", "Maksymalny punkt rosy (2m)", "Liczba zabitych", "Liczba zabitych w zależności od maksymalnego punktu rosy (2m)")
m8 <- create_plot("max_rain", "zabici", "Maksymalne opady", "Liczba zabitych", "Liczba zabitych w zależności od maksymalnych opadów")
m9 <- create_plot("max_snowfall", "zabici", "Maksymalne opady śniegu", "Liczba zabitych", "Liczba zabitych w zależności od maksymalnych opadów śniegu")
m10 <- create_plot("max_snow_depth", "zabici", "Maksymalna pokrywa śnieżna", "Liczba zabitych", "Liczba zabitych w zależności od maksymalnej pokrywy śnieżnej")
m11 <- create_plot("max_cloud_cover", "zabici", "Maksymalne zachmurzenie", "Liczba zabitych", "Liczba zabitych w zależności od maksymalnego zachmurzenia")
m12 <- create_plot("max_shortwave_radiation", "zabici", "Maksymalne promieniowanie krótkofalowe", "Liczba zabitych", "Liczba zabitych w zależności od maksymalnego promieniowania krótkofalowego")

# Tworzenie wykresów dla rannych
m13 <- create_plot("max_dew_point_2m", "ranni", "Maksymalny punkt rosy (2m)", "Liczba rannych", "Liczba rannych w zależności od maksymalnego punktu rosy (2m)")
m14 <- create_plot("max_rain", "ranni", "Maksymalne opady", "Liczba rannych", "Liczba rannych w zależności od maksymalnych opadów")
m15 <- create_plot("max_snowfall", "ranni", "Maksymalne opady śniegu", "Liczba rannych", "Liczba rannych w zależności od maksymalnych opadów śniegu")
m16 <- create_plot("max_snow_depth", "ranni", "Maksymalna pokrywa śnieżna", "Liczba rannych", "Liczba rannych w zależności od maksymalnej pokrywy śnieżnej")
m17 <- create_plot("max_cloud_cover", "ranni", "Maksymalne zachmurzenie", "Liczba rannych", "Liczba rannych w zależności od maksymalnego zachmurzenia")
m18 <- create_plot("max_shortwave_radiation", "ranni", "Maksymalne promieniowanie krótkofalowe", "Liczba rannych", "Liczba rannych w zależności od maksymalnego promieniowania krótkofalowego")

# Wyświetlenie wykresów
grid.arrange(m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12, m13, m14, m15, m16, m17, m18, ncol = 3)
print(m18)
