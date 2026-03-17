# ---------------------------------------------------------------------------- #
# ------------------------------- Week 4 R Code ------------------------------ #
# ---------------------------------------------------------------------------- #

# Week 4 focus: Variable transformations (practical)
# - Why transform variables?
# - Common transformations: log, square-root, reciprocal
# - Centering / scaling (standardisation)
# - Box-Cox (optional extension)
#



# ------------------------------- Setup -------------------------------------- #
# Install packages once (if needed):
# install.packages(c("tidyverse", "MASS"))

library(tidyverse)
library(MASS)   # for boxcox()



# --------------------------- 0. Load example data --------------------------- #
# We'll use a built-in dataset: 'mtcars'.
# Variables:
#   mpg  = miles per gallon (continuous)
#   wt   = weight (1000 lbs)
#   hp   = gross horsepower
#   cyl  = number of cylinders (categorical-like)

df <- mtcars %>%
  as_tibble(rownames = "car")

str(df)
summary(df)



# --------------------- 1. Quick visual check: skewness ---------------------- #
# Many transformations are motivated by skewed distributions.

# Histogram of horsepower (often right-skewed)
ggplot(df, aes(x = hp)) +
  geom_histogram(bins = 15) +
  labs(title = "Horsepower (hp) distribution")

# Histogram of weight
ggplot(df, aes(x = wt)) +
  geom_histogram(bins = 12) +
  labs(title = "Weight (wt) distribution")

# Scatterplot: mpg vs hp (possible non-linear relationship)
p <- ggplot(df, aes(x = hp, y = mpg)) +
  geom_point() +
  labs(title = "mpg vs hp")
print(p)
ggsave("hp_original_mpg_scatter.png", plot = p, width = 6, height = 4, dpi = 300)

# --------------------- 2. Log transformation (common) ----------------------- #
# Log transforms are often used for positive variables with right skew.
# NOTE: log() requires strictly positive values.

# Create log-transformed versions of hp and wt
# (using natural log; log10() would be base-10)
df_log_hp_wt <- df %>%
  mutate(
    log_hp = log(hp),
    log_wt = log(wt)
  )

summary(df_log_hp_wt$hp)
summary(df_log_hp_wt$log_hp)

# Compare histograms before/after log
p0 <- ggplot(df_log_hp_wt, aes(x = hp)) +
  geom_histogram(bins = 15) +
  labs(title = "hp (original)")
print(p0)
ggsave("hp_original_hist.png", plot = p0, width = 6, height = 4, dpi = 300)

p01 <- ggplot(df_log_hp_wt, aes(x = log_hp)) +
  geom_histogram(bins = 15) +
  labs(title = "log(hp)")
print(p01)
ggsave("hp_log_hist.png", plot = p01, width = 6, height = 4, dpi = 300)

# Scatterplot with log transform on x-axis
p02 <- ggplot(df_log_hp_wt, aes(x = log_hp, y = mpg)) +
  geom_point() +
  labs(title = "mpg vs log(hp)")
print(p02)
ggsave("hp_log_mpg_scatter.png", plot = p02, width = 6, height = 4, dpi = 300)


# --- Mini-exercise ----------------------------------------------- #
# (A) Create a new variable log_mpg = log(mpg).
# (B) Plot log_mpg vs log_hp.
# (C) Compare this to mpg vs hp.


df_log_mpg_hp <- df_log_hp_wt %>% mutate(log_mpg = log(mpg))
p03 <- ggplot(df_log_mpg_hp, aes(x = log_hp, y = log_mpg)) + geom_point()
print(p03)
ggsave("hp_log_mpg_log_scatter.png", plot = p03, width = 6, height = 4, dpi = 300)


# --------------------- 3. Square-root transformation ------------------------ #
# sqrt() is useful for positive, right-skewed variables (often counts).
# It's milder than log.

# We'll demonstrate on hp (just as an example)
df_sq_hp <- df %>%
  mutate(sqrt_hp = sqrt(hp))

# Compare histograms
p04 <- ggplot(df_sq_hp, aes(x = sqrt_hp)) +
  geom_histogram(bins = 15) +
  labs(title = "sqrt(hp)")
print(p04)
ggsave("hp_sq_hist.png", plot = p04, width = 6, height = 4, dpi = 300)



# --------------------- 4. Reciprocal transformation ------------------------- #
# reciprocal (1/x) can compress large values strongly.
# Useful sometimes, but interpretability can be harder.

# Create reciprocal weight (for demonstration)
df_rec_wt <- df %>%
  mutate(inv_wt = 1 / wt)

summary(df_rec_wt$wt)
summary(df_rec_wt$inv_wt)

# Visualise relationship with inverse
p05 <- ggplot(df_rec_wt, aes(x = inv_wt, y = mpg)) +
  geom_point() +
  labs(title = "mpg vs 1/wt")
print(p05)
ggsave("mpg_rec_wt.png", plot = p05, width = 6, height = 4, dpi = 300)

# --- Mini-exercise ----------------------------------------------- #
# (A) Create inv_hp = 1/hp.
# (B) Plot mpg vs inv_hp.
# (C) Which plot looks more linear: mpg vs hp, mpg vs log(hp), or mpg vs 1/hp?

# --- Mini-exercise ----------------------------------------------- #
library(ggplot2)

# (A) Create inv_hp = 1/hp
df$inv_hp <- 1 / df$hp

# (B) Plot mpg vs inv_hp
p06 <- ggplot(df, aes(x = inv_hp, y = mpg)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(x = "1 / hp", y = "mpg",
       title = "mpg vs 1/hp")
print(p06)
ggsave("mpg_rec_hp.png", plot = p06, width = 6, height = 4, dpi = 300)

# (C) Compare linearity: mpg vs hp, mpg vs log(hp), mpg vs 1/hp
df$log_hp <- log(df$hp)

p1 <- ggplot(df, aes(x = hp, y = mpg)) +
  geom_point() + geom_smooth(method = "lm", se = FALSE) +
  labs(x = "hp", y = "mpg", title = "mpg vs hp")

p2 <- ggplot(df, aes(x = log_hp, y = mpg)) +
  geom_point() + geom_smooth(method = "lm", se = FALSE) +
  labs(x = "log(hp)", y = "mpg", title = "mpg vs log(hp)")

p3 <- ggplot(df, aes(x = inv_hp, y = mpg)) +
  geom_point() + geom_smooth(method = "lm", se = FALSE) +
  labs(x = "1/hp", y = "mpg", title = "mpg vs 1/hp")

#print(p1); print(p2); print(p3)

#install.packages("patchwork")   # if needed
library(patchwork)              # must be attached
p1 + p2 + p3 + plot_layout(ncol = 3)  # 1 row, 3 columns


# Optional: quick numeric check via R^2 (bigger is "more linear" under lm)
summary(lm(mpg ~ hp, data = df))$r.squared
summary(lm(mpg ~ log_hp, data = df))$r.squared
summary(lm(mpg ~ inv_hp, data = df))$r.squared


# --------------------- 5. Centering and scaling ----------------------------- #
# Centering: subtract the mean
# Scaling/standardisation: (x - mean(x)) / sd(x)
# These help with:
#   - comparing variables on different scales
#   - interpretation (e.g., “per 1 SD increase”)
#   - numerical stability for some models

# Center and scale hp (manual)
hp_centered <- df$hp - mean(df$hp)
hp_scaled   <- (df$hp - mean(df$hp)) / sd(df$hp)

mean(hp_centered)   # should be ~0
sd(hp_scaled)       # should be 1

# Use scale() (returns a matrix by default)
df <- df %>%
  mutate(
    hp_z = as.numeric(scale(hp)),
    wt_z = as.numeric(scale(wt))
  )
?scale()
#scale() is a quick way to center and/or standardize a numeric vector (or each column of a matrix/data frame).

summary(df$hp_z)
summary(df$wt_z)

# Quick check: z-scored variables have mean ~0 and sd ~1
mean(df$hp_z)
#is essentially 0; 
#It’s a tiny nonzero number because of floating-point rounding (computers can’t represent many decimals perfectly).
sd(df$hp_z)


# --- Mini-exercise ----------------------------------------------- #
# (A) Add mpg_z = scale(mpg).
# (B) Make a scatterplot of mpg_z vs hp_z.

df <- df %>%
  mutate(
    mpg_z = as.numeric(scale(mpg))
  )

ggplot(df, aes(x = hp_z, y = mpg_z)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(
    x = "hp (z-score)",
    y = "mpg (z-score)",
    title = "mpg_z vs hp_z"
  )



# ---------------- 6. Transformations in a simple model (preview) ------------ #
# Week 4 is *not* about regression yet, but it's helpful to see
# why a transformation might make a relationship “more linear”.
#
# We'll fit a simple model purely for demonstration:

m1 <- lm(mpg ~ hp, data = df)
m2 <- lm(mpg ~ log_hp, data = df)
m3 <- lm(log(mpg) ~ log_hp, data = df)

summary(m1)
summary(m2)
summary(m3)

# Compare residual plots quickly
par(mfrow = c(1, 3))
plot(m1, which = 1, main = "mpg ~ hp")
plot(m2, which = 1, main = "mpg ~ log_hp")
plot(m3, which = 1, main = "log_mpg ~ log_hp")
par(mfrow = c(1, 1))

# Note:
# - We are NOT interpreting coefficients deeply yet.
# - This is just to see how transformations can change fit/linearity patterns.



# --------------------- 7. Box-Cox transformation (extension) ---------------- #
# Box-Cox is a family of power transforms indexed by lambda (λ).
# It requires y > 0.
#
# We'll consider transforming mpg (positive).

# Fit a baseline model (for boxcox we typically supply a model)
base_mod <- lm(mpg ~ hp + wt, data = df, x = TRUE, y = TRUE)

#class(df)
#is.data.frame(df)
# Find lambda that maximises log-likelihood
bc <- MASS::boxcox(base_mod, plotit = TRUE)

# Extract the best lambda (approx)
best_lambda <- bc$x[which.max(bc$y)]
best_lambda

# Apply Box-Cox transform to mpg with best lambda
# If lambda ~= 0, Box-Cox is approximately log(y).
boxcox_transform <- function(y, lambda) {
  if (any(y <= 0)) stop("Box-Cox requires y > 0")
  if (abs(lambda) < 1e-8) {
    return(log(y))
  } else {
    return((y^lambda - 1) / lambda)
  }
}

df <- df %>%
  mutate(mpg_bc = boxcox_transform(mpg, best_lambda))

# Compare distributions
p_mpg_org <- ggplot(df, aes(x = mpg)) +
  geom_histogram(bins = 12) +
  labs(title = "mpg (original)")

p_mpg_bc <- ggplot(df, aes(x = mpg_bc)) +
  geom_histogram(bins = 12) +
  labs(title = "mpg (Box-Cox transformed)")

p_mpg_org + p_mpg_bc + plot_layout(ncol = 2)


# --- Mini-exercise ----------------------------------------------- #
# (A) Run boxcox() on a model with log(mpg) as the response.
# (B) Does the best lambda come out close to 0? What would that suggest?

# Model with log(mpg) as outcome
mod_logy <- lm(log(mpg) ~ hp + wt, data = df, x = TRUE, y = TRUE)

# Box-Cox on that model
bc_logy <- boxcox(mod_logy, plotit = TRUE)

# Best lambda (approx)
best_lambda_logy <- bc_logy$x[which.max(bc_logy$y)]
best_lambda_logy
#Since λ ≈ 0.71 is closer to 1 than to 0, 
#it suggests log(mpg) probably doesn’t need a further log-type transform (λ≈0 would hint at another log).

#Box–Cox is saying: “If you insist on transforming log(mpg), 
#a mild power transform might improve normality/variance a bit,” but it’s not screaming for a log.




# ----------------------------- Wrap-up -------------------------------------- #
# Key takeaways:
# 1) Transformations are used to address skewness, improve linearity,
#    and stabilise variance.
# 2) Log/sqrt/reciprocal are common, but always check domain constraints.
# 3) Centering/scaling changes units, not “shape”, and is useful for comparison.
# 4) Box-Cox helps you choose a power transform systematically (when y>0).


