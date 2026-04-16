#Workshop 7 2026

coral <- read.csv("coral_growth_nutrient_regimes.csv")
coral$Nutrient_Regime <- factor(coral$Nutrient_Regime)
str(coral)
summary(coral$Nutrient_Regime)
nrow(coral)

library(ggplot2)
ggplot(coral, aes(x = Nutrient_Regime, y = Growth_cm_per_year)) +
  geom_boxplot() +
  geom_jitter(width = 0.08, alpha = 0.7) +
  labs(title = "Coral growth by nutrient regime",
       x = "Nutrient regime", y = "Growth rate (cm/year)")
ggplot(coral, aes(x = Growth_cm_per_year)) +
  geom_histogram(binwidth = 0.2, colour = "black", fill = "lightblue")+
  facet_wrap(~ Nutrient_Regime, ncol = 2) +
  labs(title = "Histograms by regime",
       x = "Growth rate (cm/year)", y = "Count")

group_means <- tapply(coral$Growth_cm_per_year, coral$Nutrient_Regime,
                      mean)
group_sds <- tapply(coral$Growth_cm_per_year, coral$Nutrient_Regime,
                    sd)
group_ns <- tapply(coral$Growth_cm_per_year, coral$Nutrient_Regime,
                   length)
group_means
group_sds
group_ns

anova_fit <- aov(Growth_cm_per_year ~ Nutrient_Regime, data =
                   coral)
fitted_vals <- fitted(anova_fit)
residual_vals <- residuals(anova_fit)

qqnorm(residual_vals, main = "ANOVA residuals: normal Q-Q plot")
qqline(residual_vals, col = "red", lwd = 2)
plot(fitted_vals, residual_vals,
     xlab = "Fitted values", ylab = "Residuals",
     main = "Residual plot")
abline(h = 0, lty = 2, col = "red", lwd = 2)

sd_ratio <- max(group_sds) / min(group_sds)
sd_ratio
bartlett.test(Growth_cm_per_year ~ Nutrient_Regime, data = coral)
print(bartlett_out)

anova_table <- summary(anova_fit)
anova_table

df1 <- 3
df2 <- 36
alpha <- 0.05

# critical value
f_crit <- qf(1 - alpha, df1, df2)

# x range
x <- seq(0, 20, length.out = 2000)
y <- df(x, df1, df2)

# plot curve FIRST
plot(x, y,
     type = "l",
     lwd = 2,
     col = "black",
     xlab = "F value",
     ylab = "Density",
     main = "F(3,36): α = 0.05 with rejection region")

# SHADE rejection region (must come after plot)
x_shade <- x[x >= f_crit]

polygon(c(f_crit, x_shade, max(x)),
        c(0, df(x_shade, df1, df2), 0),
        col = rgb(1, 0, 0, 0.3), border = NA)

# add critical line
abline(v = f_crit, col = "blue", lwd = 2)

# add observed F line
abline(v = 12.74, col = "darkgreen", lwd = 2, lty = 2)

# labels
text(f_crit, max(y)*0.9, labels = "F critical", pos = 4, col = "blue")
text(12.74, max(y)*0.7, labels = "F = 12.74", pos = 4, col = "darkgreen")

f_stat <- anova_table[[1]][["F value"]][1]
p_value <- anova_table[[1]][["Pr(>F)"]][1]

tukey_out <- TukeyHSD(anova_fit)
tukey_out