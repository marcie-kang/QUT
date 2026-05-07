#Week 8 2026

penguins_df <- read.csv("penguins_balanced_workshop8.csv")
penguins_df$species <- factor(penguins_df$species,
                              levels = c("Adelie", "Chinstrap", "Gentoo"))
penguins_df$sex <- factor(penguins_df$sex,
                          levels = c("female", "male"))
nrow(penguins_df)
nlevels(penguins_df$species)
nlevels(penguins_df$sex)
cell_counts <- table(penguins_df$species, penguins_df$sex)
cell_counts

str(penguins_df)
head(penguins_df)
summary(penguins_df$species)
summary(penguins_df$sex)
nrow(penguins_df)
penguins_df$cell <- interaction(penguins_df$species, penguins_df$sex, sep = ":")
summary(penguins_df$cell)

library(ggplot2)
ggplot(penguins_df, aes(x = cell, y = body_mass_g)) +
  geom_boxplot() +
  geom_jitter(width = 0.08, alpha = 0.5) +
  labs(title = "Penguin body mass by factor combination",
       x = "Factor combination", y = "Body mass (g)")

library(dplyr)
cell_summary <- penguins_df %>%
  group_by(species, sex) %>%
  summarise(
    mean_mass = mean(body_mass_g),
    sd_mass = sd(body_mass_g),
    n = n(),
    .groups = "drop"
  )
ggplot(cell_summary,
       aes(x = sex, y = mean_mass, group = species, linetype = species)) +
  geom_line() +
  geom_point(size = 2) +
  labs(title = "Interaction plot of cell means",
       x = "Sex", y = "Mean body mass (g)")

cell_means <- tapply(penguins_df$body_mass_g, penguins_df$cell, mean)
cell_sds <- tapply(penguins_df$body_mass_g, penguins_df$cell, sd)
cell_ns <- tapply(penguins_df$body_mass_g, penguins_df$cell, length)
cell_means
cell_sds
cell_ns

full_fit <- aov(body_mass_g ~ species * sex, data = penguins_df)
fitted_vals <- fitted(full_fit)
residual_vals <- residuals(full_fit)

qqnorm(residual_vals, main = "Two-way ANOVA residuals: normal Q-Q plot")
qqline(residual_vals, col = "red", lwd = 2)
plot(fitted_vals, residual_vals,
     xlab = "Fitted values", ylab = "Residuals",
     main = "Residual plot")
abline(h = 0, lty = 2, col = "red", lwd = 2)

cell_sds <- tapply(penguins_df$body_mass_g, penguins_df$cell, sd)
sd_ratio <- max(cell_sds) / min(cell_sds)
sd_ratio

bartlett.test(body_mass_g ~ cell, data = penguins_df)

anova_table_full <- summary(full_fit)
anova_table_full

additive_fit <- aov(body_mass_g ~ species + sex, data = penguins_df)
summary(additive_fit)

follow_up <- TukeyHSD(additive_fit)
follow_up
