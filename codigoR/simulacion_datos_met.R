
# Simulating Data ---------------------------------------------------------

# Packages
library(readr)
library(purrr)

# 1 Import Data -----------------------------------------------------------
cp_data <- read_csv("datos/datos_met.csv")

# 2 Simluate triplicates -------------------------------------------------
set.seed(5) # For reproducibility

trip_data <- map2(cp_data$Promedio, cp_data$DE, rnorm, n = 3)
trip_data <- unlist(trip_data)
trip_data <- signif(trip_data, 3)

# 3 Data fram with the triplicates ---------------------------------------

main_data <- data.frame(
  Metabolito  = rep(cp_data$Metabolito, each = 3),
  Tiempo = rep(cp_data$Tiempo, each = 3),
  Muestra = rep(1:3), # Replicate number
  CR   = trip_data
)

# 3.1 Save main data
write_csv(main_data, "datos/datos_met_completos.csv")
