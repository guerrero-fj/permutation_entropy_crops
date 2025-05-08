# R Script: Weighted Permutation Entropy for Crop Yield Time Series

# Load required packages
# If you don't have the librarian package, install it first
# install.packages("librarian")

librarian::shelf(
  dplyr,
  purrr,
  tidyr,
  entropy,
  here
)

# Define the folder path
folder_path <- "data"

# List of filenames
files <- c("corn_yield_portage_basin.csv",
           "soybean_yield_portage_basin.csv",
           "wheat_yield_portage_basin.csv")

# Read and combine the datasets
all_data <- lapply(files, function(file) {
  df <- read.csv(file.path(folder_path, file), stringsAsFactors = FALSE)
  
  
  # Add a crop identifier based on the file name
  crop_name <- gsub("_yield_portage_basin.csv", "", file)
  df$Crop <- crop_name
  
  return(df)
}) %>%
  bind_rows()

# View combined dataframe
head(all_data)

# Step 1: Find common years across all crops
common_years <- all_data %>%
  group_by(Crop) %>%
  summarise(min_year = min(year), max_year = max(year), n = n(), .groups = "drop")

# Optionally print to inspect
print(common_years)

# Step 2: Keep only years that are shared by all crops
shared_years <- all_data %>%
  group_by(year) %>%
  summarise(n_crops = n_distinct(Crop)) %>%
  filter(n_crops == length(unique(all_data$Crop))) %>%
  pull(year)

# Step 3: Filter the full data to those shared years only
all_data_balanced <- all_data %>%
  filter(year %in% shared_years)

# Step 4: Pivot to wide format
yield_df <- all_data_balanced %>%
  pivot_wider(names_from = Crop, values_from = ton_ha) %>%
  arrange(year)

# Permutation entropy function (normalized)
perm_entropy <- function(series, m = 3) {
  n <- length(series)
  if (n < m) return(NA)
  patterns <- embed(series, m)
  perms <- apply(patterns, 1, function(x) paste(order(x), collapse = ""))
  probs <- table(perms) / length(perms)
  pe <- entropy::entropy(probs, unit="log2")
  pe_max <- log2(factorial(m))
  return(pe / pe_max)
}

# Compute permutation entropy for each crop
yield_df <- yield_df %>%
  mutate(
    pe_corn = perm_entropy(corn),
    pe_wheat = perm_entropy(wheat),
    pe_soy = perm_entropy(soybean)
  )

# Normalize each year's crop yields so their total = 1
prop_df <- yield_df %>%
  select(corn, soybean, wheat) %>%
  rowwise() %>%
  mutate(total = sum(c_across(corn:wheat))) %>%
  mutate(across(corn:wheat, ~ . / total, .names = "prop_{.col}")) %>%
  ungroup()

# Calculate mean proportions per crop
y_mean <- colMeans(select(prop_df, starts_with("prop_")),na.rm = TRUE)

# Compute information gain for each crop
info_gain <- map_dbl(c("prop_corn", "prop_wheat", "prop_soybean"), function(col) {
  y_ij <- pull(prop_df, col)
  y_ij <- y_ij[y_ij > 0]  # Avoid log(0)
  y_j <- mean(y_ij)
  y_j * sum(y_ij * log2(nrow(prop_df) * y_ij))
})

names(info_gain) <- c("corn", "wheat", "soybean")

# Normalize information gains to use as weights
i_weights <- info_gain / sum(info_gain)

# Retrieve normalized permutation entropy values
total_pe <- c(
  pe_corn = unique(yield_df$pe_corn),
  pe_wheat = unique(yield_df$pe_wheat),
  pe_soy = unique(yield_df$pe_soy)
)

# Compute weighted permutation entropy
weighted_pe <- total_pe * i_weights

# Output table
weighted_pe_df <- tibble(
  crop = names(weighted_pe),
  permutation_entropy = total_pe,
  information_gain_weight = i_weights,
  weighted_permutation_entropy = weighted_pe
)

print(weighted_pe_df)
