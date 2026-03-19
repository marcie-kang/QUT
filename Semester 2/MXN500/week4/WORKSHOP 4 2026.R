#Workshop 4 2026

library(tidyverse)

diamonds_df <- ggplot2::diamonds
glimpse(diamonds_df)

dim(diamonds_df)

# Distribution of price
ggplot(diamonds_df, aes(x = price)) +
  geom_histogram(bins = 40) +
  theme_bw() +
  xlab("Price (USD)") +
  ylab("Count")

# Boxplot of price to highlight outliers
ggplot(diamonds_df, aes(y = price)) +
  geom_boxplot() +
  theme_bw() +
  ylab("Price (USD)")

ggplot(diamonds_df, aes(x = carat)) +
  geom_histogram(bins = 40) +
  theme_bw() +
  xlab("carat") +
  ylab("Count")

# Boxplot of carat to highlight outliers
ggplot(diamonds_df, aes(y = carat)) +
  geom_boxplot() +
  theme_bw() +
  ylab("carat")

# Compare raw vs log(price)
diamonds_df <- diamonds_df %>%
  mutate(log_price = log(price))

ggplot(diamonds_df, aes(x = log_price)) +
  geom_histogram(bins = 40) +
  theme_bw() +
  xlab("log(Price)") +
  ylab("Count")

# Side-by-side: raw vs log scale using facetting


diamonds_long <- diamonds_df %>%
  select(price, log_price) %>%
  pivot_longer(cols = everything(), names_to = "scale", values_to = "value")

ggplot(diamonds_long, aes(x = value)) +
  geom_histogram(bins = 40) +
  facet_wrap(~ scale, scales = "free") +
  theme_bw() +
  xlab("") +
  ylab("Count")

diamonds_df <- diamonds_df %>%
  mutate(log_price = log(price))

ggplot(diamonds_df, aes(x = log_price)) +
  geom_histogram(bins = 40) +
  theme_bw() +
  xlab("log(Price)") +
  ylab("Count")

# Create a non-negative count-like variable with zeros
diamonds_df <- diamonds_df %>%
  mutate(carat_round = round(carat, 1),
         carat_count = as.integer((carat_round - min(carat_round)) * 10)) 
# includes 0

summary(diamonds_df$carat_count)

diamonds_df <- diamonds_df %>%
  mutate(log1p_carat_count = log1p(carat_count))

ggplot(diamonds_df, aes(x = carat_count)) +
  geom_histogram(bins = 10) +
  theme_bw() +
  xlab("carat_count (toy count)") +
  ylab("Count")

ggplot(diamonds_df, aes(x = log1p_carat_count)) +
  geom_histogram(bins = 5) +
  theme_bw() +
  xlab("log1p(carat_count)") +
  ylab("Count")


diamonds_df <- diamonds_df %>%
  mutate(sqrt_carat_count = sqrt(carat_count))

diamonds_df %>%
  select(log1p_carat_count, sqrt_carat_count) %>%
  pivot_longer(cols = everything(),
               names_to = "transformation",
               values_to = "value") %>%
  ggplot(aes(x = transformation, y = value)) +
  geom_boxplot() +
  theme_bw()

# Raw relationship
ggplot(diamonds_df, aes(x = carat, y = price)) +
  geom_point(alpha = 0.2) +
  theme_bw() +
  xlab("Carat") +
  ylab("Price (USD)")

# Transform the outcome
ggplot(diamonds_df, aes(x = carat, y = log_price)) +
  geom_point(alpha = 0.2) +
  theme_bw() +
  xlab("Carat") +
  ylab("log(Price)")


# Transform both axes
diamonds_df <- diamonds_df %>% mutate(log_carat = log(carat))

ggplot(diamonds_df, aes(x = log_carat, y = log_price)) +
  geom_point(alpha = 0.2) +
  theme_bw() +
  xlab("log(Carat)") +
  ylab("log(Price)")

# Standardise price and carat
diamonds_df <- diamonds_df %>%
  mutate(z_price = as.numeric(scale(price)),
         z_carat = as.numeric(scale(carat)))

summary(diamonds_df$z_price)

ggplot(diamonds_df, aes(x = z_price)) +
  geom_histogram(bins = 40) +
  theme_bw() +
  xlab("z-score of Price") +
  ylab("Count")

ggplot(diamonds_df, aes(x = z_carat, y = z_price)) +
  geom_point(alpha = 0.2) +
  theme_bw() +
  xlab("z(Carat)") +
  ylab("z(Price)")

# Optional: Box-Cox using MASS
# install.packages("MASS")  # if needed
library(MASS)

# Box-Cox needs strictly positive data
bc <- boxcox(price ~ 1, data = diamonds_df, plotit = TRUE)

lambda_hat <- bc$x[which.max(bc$y)]
lambda_hat





