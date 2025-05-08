# R Script: Spectral Entropy for Hydrological Time Series

# Load required packages
# If you don't have the librarian package, install it first
# install.packages("librarian")

librarian::shelf(
  signal,
  pracma,
  lubridate
)

####################### Streamflow Spectral Entropy Analysis ############################

# 1. Load the data

# Define the folder path
folder_path <- "data"

df <- read.csv(file.path(folder_path, "obs.flow_sub16.csv"))
df$Date <- as.Date(df$Date)
streamflow <- df$cms

# 2. Log-transform with small epsilon to handle zeros 
epsilon <- 1e-6
log_flow <- log(streamflow + epsilon)

# 3. Demean 
log_flow_demeaned <- log_flow - mean(log_flow, na.rm = TRUE)

# 4. Apply Hann window 
hann_window <- hanning(length(log_flow_demeaned))
windowed_data <- log_flow_demeaned * hann_window

# 5. FFT and power spectrum 
fft_result <- fft(windowed_data)
power_spectrum <- Mod(fft_result)^2
n <- length(windowed_data)
freqs <- (0:(n - 1)) / n  # Cycles per day, assuming daily data

# Only keep positive frequencies up to Nyquist
positive_freqs <- freqs[1:(n %/% 2)]
positive_power <- power_spectrum[1:(n %/% 2)]

# 6. Define frequency bands (in cycles/day)
bands_days <- list(
  c(1, 10),       # 1–10 days
  c(10, 60),      # 10–60 days
  c(60, 180),     # 2–6 months
  c(180, 730),    # 6–24 months
  c(730, Inf)     # >2 years
)
bands_freq <- lapply(bands_days, function(b) c(1 / b[2], 1 / b[1]))

# 7. Compute power in each band 
band_powers <- sapply(bands_freq, function(band) {
  idx <- which(positive_freqs >= band[1] & positive_freqs < band[2])
  sum(positive_power[idx], na.rm = TRUE)
})

# 8. Normalize and compute entropy 
band_probs <- band_powers / sum(band_powers)
shannon_entropy <- -sum(band_probs * log2(band_probs), na.rm = TRUE)

# 8.a. Normzlize the entropy
n_bands <- length(band_probs)
max_entropy <- log2(n_bands)
normalized_entropy <- shannon_entropy / max_entropy

# 9. Output 
print(round(band_probs, 4))
cat("Shannon Entropy (bits):", round(shannon_entropy, 4), "\n")
cat("Normalized Spectral Entropy:", round(normalized_entropy, 4), "\n")


############################ ET Spectral Entropy Analysis ############################

# 1. Load the data
et_df <- read.csv(file.path(folder_path, "8daysET500m_subbasin_portage.csv"))
et_df$date <- as.Date(et_df$date)
et_series <- et_df$ET

# 2. Log-transform with small epsilon
epsilon <- 1e-6
log_et <- log(et_series + epsilon)

# 3. Demean 
log_et_demeaned <- log_et - mean(log_et, na.rm = TRUE)

# 4. Hann Window 
hann_window <- hanning(length(log_et_demeaned))
windowed_data <- log_et_demeaned * hann_window

# 5. FFT and Power Spectrum 
fft_result <- fft(windowed_data)
power_spectrum <- Mod(fft_result)^2
n <- length(windowed_data)
freqs <- (0:(n - 1)) / n  # in cycles per 8 days

# Keep only positive frequencies
positive_freqs <- freqs[1:(n %/% 2)]
positive_power <- power_spectrum[1:(n %/% 2)]

# --- 6. Frequency Bands (converted from days to cycles per 8 days) ---
bands_days <- list(
  c(1, 10),        # 1–10 days
  c(10, 60),       # 10–60 days
  c(60, 180),      # 2–6 months
  c(180, 730),     # 6–24 months
  c(730, Inf)      # >2 years
)
bands_freq <- lapply(bands_days, function(b) c(8 / b[2], 8 / b[1]))

# 7. Compute power in each band
band_powers <- sapply(bands_freq, function(band) {
  idx <- which(positive_freqs >= band[1] & positive_freqs < band[2])
  sum(positive_power[idx], na.rm = TRUE)
})

# 8. Normalize and Compute Entropy 
band_probs <- band_powers / sum(band_powers)
shannon_entropy <- -sum(band_probs * log2(band_probs + 1e-12))  # add epsilon to avoid log(0)
normalized_entropy <- shannon_entropy / log2(length(band_probs))

# 9. Output 
print(round(band_probs, 4))
cat("Shannon Entropy (bits):", round(shannon_entropy, 4), "\n")
cat("Normalized Spectral Entropy:", round(normalized_entropy, 4), "\n")





