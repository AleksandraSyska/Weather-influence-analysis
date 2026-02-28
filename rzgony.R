
library(tidyr)
library(readr)
library(data.table)
# Instalacja pakietu readxl (jeśli jeszcze nie jest zainstalowany)
if (!requireNamespace("readxl", quietly = TRUE)) {
  install.packages("readxl")
}

# Załadowanie pakietu readxl
library(readxl)
library(dplyr)

# Wczytanie pliku Excel o nazwie "zgony.xlsx"
dane_zgony <- as.data.frame(read_excel("zgony.xlsx"))[1:8,]

# Wyświetlenie pierwszych kilku wierszy załadowanego pliku
print(dane_zgony)

# Upewnij się, że wszystkie kolumny miesięczne są typu double
dane_zgony <- dane_zgony %>%
  mutate(across(-Rok, as.double))

# Przekształć tabelę za pomocą pivot_longer
dane_zgony <- dane_zgony %>%
  pivot_longer(cols = -Rok, names_to = "Miesiąc", values_to = "Zgony") %>%
  mutate(Miesiąc = factor(Miesiąc, levels = c("Styczeń", "Luty", "Marzec", "Kwiecień", "Maj", "Czerwiec", "Lipiec", "Sierpień", "Wrzesień", "Październik", "Listopad", "Grudzień")))

# Tworzymy kolumnę z rokiem i miesiącem
dane_zgony <- dane_zgony %>%
  mutate(year_month = paste0(Rok, "-", sprintf("%02d", as.numeric(Miesiąc))))

# Usuwamy kolumny Rok i Miesiąc, które już nie są potrzebne
dane_zgony <- dane_zgony %>%
  select(year_month, Zgony)

# Wyświetlamy pierwsze wiersze przekształconej tabeli
head(dane_zgony)

# Instalacja pakietów httr i jsonlite (jeśli jeszcze nie są zainstalowane)
if (!requireNamespace("httr", quietly = TRUE)) {
  install.packages("httr")
}
if (!requireNamespace("jsonlite", quietly = TRUE)) {
  install.packages("jsonlite")
}

# Załadowanie pakietów
library(httr)
library(jsonlite)

# URL API
url <- "https://archive-api.open-meteo.com/v1/archive?latitude=52.2298&longitude=21.0118&start_date=2015-01-01&end_date=2022-12-31&hourly=temperature_2m,surface_pressure&timezone=Europe%2FBerlin"

# Wykonanie zapytania GET do API
response <- GET(url)

# Sprawdzenie statusu odpowiedzi
if (http_status(response)$category == "Success") {
  # Przetworzenie treści odpowiedzi jako tekst
  content_text <- content(response, "text")
  
  # Konwersja danych JSON na listę w R
  data_list <- fromJSON(content_text, flatten = TRUE)
  
  # Konwersja listy na ramkę danych (data frame)
  data_df <- as.data.frame(data_list$hourly)
  
  # Wyświetlenie pierwszych kilku wierszy ramki danych
  print(head(data_df))
} else {
  print("Nie udało się pobrać danych z API")
}

# Zakładam, że dane są już wczytane do data_df

# Konwersja kolumny `time` na format daty i czasu
data_df$time <- as.POSIXct(data_df$time, format="%Y-%m-%dT%H:%M")

# Dodanie kolumny `year_month` w formacie "YYYY-MM"
data_df$year_month <- format(data_df$time, "%Y-%m")

# Zagregowanie danych po `year_month`
library(dplyr)

aggregated_data <- data_df %>%
  group_by(year_month) %>%
  summarize(
    mean_temperature = mean(temperature_2m, na.rm = TRUE),
    max_temperature = max(temperature_2m, na.rm = TRUE),
    min_temperature = min(temperature_2m, na.rm = TRUE),
    mean_pressure = mean(surface_pressure, na.rm = TRUE),
    max_pressure = max(surface_pressure, na.rm = TRUE),
    min_pressure = min(surface_pressure, na.rm = TRUE)
  )
aggregated_data <- aggregated_data[1:96,]
# Wyświetlenie zagregowanych danych
head(aggregated_data)
head(dane_zgony)

x <- cbind(aggregated_data, dane_zgony[2])
head(x)
# Załaduj wymagane pakiety
library(ggplot2)
library(gridExtra)

# Tworzymy wykresy dla każdej zmiennej pogodowej w odniesieniu do liczby zgonów
plot1 <- ggplot(x, aes(x = mean_temperature, y = Zgony)) +
  geom_point(col = "grey") +
  geom_smooth(method = "lm", col = "red", se = FALSE) +
  labs(title = "Średnia temperatura vs Liczba zgonów", x = "Średnia temperatura (°C)", y = "Liczba zgonów") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"))
plot2 <- ggplot(x, aes(x = max_temperature, y = Zgony)) +
  geom_point(col = "grey") +
  geom_smooth(method = "lm", col = "red", se = FALSE) +
  labs(title = "Maksymalna temperatura vs Liczba zgonów", x = "Maksymalna temperatura (°C)", y = "Liczba zgonów") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"))

plot3 <- ggplot(x, aes(x = min_temperature, y = Zgony)) +
  geom_point(col = "grey") +
  geom_smooth(method = "lm", col = "red", se = FALSE) +
  labs(title = "Minimalna temperatura vs Liczba zgonów", x = "Minimalna temperatura (°C)", y = "Liczba zgonów") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"))

plot4 <- ggplot(x, aes(x = mean_pressure, y = Zgony)) +
  geom_point(col = "grey") +
  geom_smooth(method = "lm", col = "red", se = FALSE) +
  labs(title = "Średnie ciśnienie vs Liczba zgonów", x = "Średnie ciśnienie (hPa)", y = "Liczba zgonów") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"))

plot5 <- ggplot(x, aes(x = max_pressure, y = Zgony)) +
  geom_point(col = "grey") +
  geom_smooth(method = "lm", col = "red", se = FALSE) +
  labs(title = "Maksymalne ciśnienie vs Liczba zgonów", x = "Maksymalne ciśnienie (hPa)", y = "Liczba zgonów") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"))

plot6 <- ggplot(x, aes(x = min_pressure, y = Zgony)) +
  geom_point(col = "grey") +
  geom_smooth(method = "lm", col = "red", se = FALSE) +
  labs(title = "Minimalne ciśnienie vs Liczba zgonów", x = "Minimalne ciśnienie (hPa)", y = "Liczba zgonów") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"))

# Wyświetlamy wykresy w układzie 2x3
grid.arrange(plot1, plot2, plot3, plot4, plot5, plot6, ncol = 2)


#grid.arrange(plot1, plot1a)


