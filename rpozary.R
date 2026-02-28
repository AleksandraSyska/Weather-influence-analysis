# Instalacja pakietów, jeśli nie są jeszcze zainstalowane
# Załaduj pakiety
library(httr)
library(jsonlite)

# Tworzenie linku API
url1 <- "https://archive-api.open-meteo.com/v1/archive?latitude=49.299&longitude=19.9489&start_date=2015-01-01&end_date=2022-12-31&hourly=temperature_2m,relative_humidity_2m,rain,cloud_cover,shortwave_radiation&timezone=Europe%2FBerlin&tilt=49&azimuth=20"
response1 <- GET(url1)

# Sprawdzenie statusu odpowiedzi
if (http_status(response1)$category == "Success") {
  # Przetworzenie treści odpowiedzi jako tekst
  content_text1 <- content(response1, "text")
  
  # Konwersja danych JSON na listę w R
  data_list1 <- fromJSON(content_text1, flatten = TRUE)
  
  # Konwersja listy na ramkę danych (data frame)
  pogoda_zakopane <- as.data.frame(data_list1$hourly)
  
  # Wyświetlenie pierwszych kilku wierszy ramki danych
  print(head(pogoda_zakopane))
} else {
  print("Nie udało się pobrać danych z API")
}

# Zakładam, że dane są już wczytane do data_df

# Konwersja kolumny `time` na format daty i czasu
pogoda_zakopane$time <- as.POSIXct(pogoda_zakopane$time, format="%Y-%m-%dT%H:%M")

# Dodanie kolumny `year_month` w formacie "YYYY-MM"
pogoda_zakopane$year_month <- format(pogoda_zakopane$time, "%Y-%m")

# Zagregowanie danych po `year_month`
library(dplyr)
head(pogoda_zakopane)

url1 <- "https://archive-api.open-meteo.com/v1/archive?latitude=54.8314&longitude=18.313&start_date=2015-01-01&end_date=2022-12-31&hourly=temperature_2m,relative_humidity_2m,rain,cloud_cover,shortwave_radiation&timezone=Europe%2FBerlin&tilt=49&azimuth=20"
response1 <- GET(url1)

# Sprawdzenie statusu odpowiedzi
if (http_status(response1)$category == "Success") {
  # Przetworzenie treści odpowiedzi jako tekst
  content_text1 <- content(response1, "text")
  
  # Konwersja danych JSON na listę w R
  data_list1 <- fromJSON(content_text1, flatten = TRUE)
  
  # Konwersja listy na ramkę danych (data frame)
  pogoda_jas <- as.data.frame(data_list1$hourly)
  
  # Wyświetlenie pierwszych kilku wierszy ramki danych
  print(head(pogoda_jas))
} else {
  print("Nie udało się pobrać danych z API")
}

# Zakładam, że dane są już wczytane do data_df

# Konwersja kolumny `time` na format daty i czasu
pogoda_jas$time <- as.POSIXct(pogoda_jas$time, format="%Y-%m-%dT%H:%M")

# Dodanie kolumny `year_month` w formacie "YYYY-MM"
pogoda_jas$year_month <- format(pogoda_jas$time, "%Y-%m")

# Zagregowanie danych po `year_month`

head(pogoda_jas)

url1 <- "https://archive-api.open-meteo.com/v1/archive?latitude=54.1118&longitude=22.9309&start_date=2015-01-01&end_date=2022-12-31&hourly=temperature_2m,relative_humidity_2m,rain,cloud_cover,shortwave_radiation&timezone=Europe%2FBerlin&tilt=49&azimuth=20"
response1 <- GET(url1)

# Sprawdzenie statusu odpowiedzi
if (http_status(response1)$category == "Success") {
  # Przetworzenie treści odpowiedzi jako tekst
  content_text1 <- content(response1, "text")
  
  # Konwersja danych JSON na listę w R
  data_list1 <- fromJSON(content_text1, flatten = TRUE)
  
  # Konwersja listy na ramkę danych (data frame)
  pogoda_suw <- as.data.frame(data_list1$hourly)
  
  # Wyświetlenie pierwszych kilku wierszy ramki danych
  print(head(pogoda_suw))
} else {
  print("Nie udało się pobrać danych z API")
}

# Zakładam, że dane są już wczytane do data_df

# Konwersja kolumny `time` na format daty i czasu
pogoda_suw$time <- as.POSIXct(pogoda_suw$time, format="%Y-%m-%dT%H:%M")

# Dodanie kolumny `year_month` w formacie "YYYY-MM"
pogoda_suw$year_month <- format(pogoda_suw$time, "%Y-%m")

# Zagregowanie danych po `year_month`

head(pogoda_suw)

url1 <- "https://archive-api.open-meteo.com/v1/archive?latitude=52.2298&longitude=21.0118&start_date=2015-01-01&end_date=2022-12-31&hourly=temperature_2m,relative_humidity_2m,rain,cloud_cover,shortwave_radiation&timezone=Europe%2FBerlin&tilt=49&azimuth=20"
response1 <- GET(url1)

# Sprawdzenie statusu odpowiedzi
if (http_status(response1)$category == "Success") {
  # Przetworzenie treści odpowiedzi jako tekst
  content_text1 <- content(response1, "text")
  
  # Konwersja danych JSON na listę w R
  data_list1 <- fromJSON(content_text1, flatten = TRUE)
  
  # Konwersja listy na ramkę danych (data frame)
  pogoda_wawa <- as.data.frame(data_list1$hourly)
  
  # Wyświetlenie pierwszych kilku wierszy ramki danych
  print(head(pogoda_wawa))
} else {
  print("Nie udało się pobrać danych z API")
}

# Zakładam, że dane są już wczytane do data_df

# Konwersja kolumny `time` na format daty i czasu
pogoda_wawa$time <- as.POSIXct(pogoda_wawa$time, format="%Y-%m-%dT%H:%M")

# Dodanie kolumny `year_month` w formacie "YYYY-MM"
pogoda_wawa$year_month <- format(pogoda_wawa$time, "%Y-%m")

# Zagregowanie danych po `year_month`

colnames(pogoda_jas) <- c("time_jas","temp_jas", "hum_jas","rain_jas","cloud_jas","rad_jas","year_month_jas")
colnames(pogoda_zakopane) <- c("time_zakopane","temp_zakopane", "hum_zakopane","rain_zakopane","cloud_zakopane","rad_zakopane","year_month_zakopane")
colnames(pogoda_wawa) <- c("time_wawa","temp_wawa", "hum_wawa","rain_wawa","cloud_wawa","rad_wawa","year_month")
colnames(pogoda_suw) <- c("time_suw","temp_suw", "hum_suw","rain_suw","cloud_suw","rad_suw","year_month_suw")

pogoda_cala <- cbind(pogoda_jas, pogoda_suw, pogoda_zakopane, pogoda_wawa)[, -c(1,7,8,14,15,21,22)]

head(pogoda_cala)
library(dplyr)
srednie_roczne_miesieczne <- pogoda_cala %>%
  group_by(year_month) %>%
  summarise(
    mean_temp = mean(c(temp_jas, temp_suw, temp_zakopane, temp_wawa), na.rm = TRUE),
    max_temp = max(c(temp_jas, temp_suw, temp_zakopane, temp_wawa), na.rm = TRUE),
    min_temp = min(c(temp_jas, temp_suw, temp_zakopane, temp_wawa), na.rm = TRUE),
    mean_rain = mean(c(rain_jas, rain_suw, rain_zakopane, rain_wawa), na.rm = TRUE),
    max_rain = max(c(rain_jas, rain_suw, rain_zakopane, rain_wawa), na.rm = TRUE),
    min_rain = min(c(rain_jas, rain_suw, rain_zakopane, rain_wawa), na.rm = TRUE),
    mean_hum = mean(c(hum_jas, hum_suw, hum_zakopane, hum_wawa), na.rm = TRUE),
    max_hum = max(c(hum_jas, hum_suw, hum_zakopane, hum_wawa), na.rm = TRUE),
    min_hum = min(c(hum_jas, hum_suw, hum_zakopane, hum_wawa), na.rm = TRUE),
    mean_cloud = mean(c(cloud_jas, cloud_suw, cloud_zakopane, cloud_wawa), na.rm = TRUE),
    max_cloud = max(c(cloud_jas, cloud_suw, cloud_zakopane, cloud_wawa), na.rm = TRUE),
    min_cloud = min(c(cloud_jas, cloud_suw, cloud_zakopane, cloud_wawa), na.rm = TRUE),
    mean_rad = mean(c(rad_jas, rad_suw, rad_zakopane, rad_wawa), na.rm = TRUE),
    max_rad = max(c(rad_jas, rad_suw, rad_zakopane, rad_wawa), na.rm = TRUE),
    min_rad = min(c(rad_jas, rad_suw, rad_zakopane, rad_wawa), na.rm = TRUE)
  )

pogoda <- srednie_roczne_miesieczne[1:96,]
head(pogoda)

library(readxl)

# Wczytanie danych z pliku Excel
fires <- read_excel("pozary.xlsx")

pogoda <- cbind(pogoda, fires[2])
colnames(pogoda)[17]<- "fires"
head(pogoda)

