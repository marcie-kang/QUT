#Workshop 10 2026

df <- read_csv("dengue.csv")

ggplot(df, aes(x = Days, y = Load)) +
  geom_point() +
  theme_bw()

ggplot(df, aes(x = Days, y = Load)) +
  geom_point() +
  scale_y_log10() +
  geom_smooth() +
  theme_bw()

lm_dengue <- lm(data = df, log(Load) ~ Days)
library(broom)
tidy(lm_dengue, conf.int = T, conf.level = 0.95) %>%
  select(term, estimate, conf.low, conf.high)

lm_fort <- fortify(lm_dengue)
ggplot(data = lm_fort, aes(x = .fitted, y = .resid)) +
  geom_point() +
  theme_bw() +
  geom_smooth()

lm_fort <- fortify(lm_dengue)
ggplot(data = lm_fort, aes(x = Days, y = .resid)) +
  geom_point() +
  theme_bw() +
  geom_smooth()

ggplot(data = lm_fort, aes(sample = .stdresid)) +
  stat_qq() +
  geom_abline(intercept = 0, slope = 1) +
  coord_equal() +
  labs(
    x = "q values from standard normal",
    y = "q values from standardised residuals"
  ) +
  theme_bw()

df <- mutate(df, LogLoad = log10(Load))
lm_dengue2 <- lm(data = df, LogLoad ~ poly(Days, 2, raw = T))
tidy(lm_dengue2) %>%
  select(term, estimate)

lm_fort2 <- fortify(lm_dengue2)
ggplot(lm_fort2, aes(x = .fitted, y = .resid)) +
  geom_point() +
  theme_bw() +
  geom_smooth()

ggplot(data = lm_fort2, aes(x = `poly(Days, 2, raw = T)`[, 1], y = .resid)) +
  geom_point() +
  theme_bw() +
  xlab("Days") +
  geom_smooth()

ggplot(data = lm_fort2, aes(sample = .stdresid)) +
  stat_qq() +
  geom_abline(intercept = 0, slope = 1) +
  coord_equal() +
  labs(
    x = "q values from standard normal",
    y = "q values from standardised residuals"
  ) +
  theme_bw()

df <- read_csv('Piemonte_data_byday.csv')
df <- na.omit(df)

df <- mutate(df, logPM10 = log(PM10))
ggplot(data = df, aes(x = logPM10, y = ..density..))+
  geom_histogram(colour = 'grey', fill = 'salmon')+
  theme_bw()+
  scale_x_continuous(name = 'Log of the Concentration of PM10')

library(GGally)
df %>%
  select(-one_of(c("Station.ID", "Date", "PM10"))) %>%
  ggpairs(mapping = aes(alpha = 0.05))

df %>%
  select("logPM10", "PREC", "WS", "TEMP") %>%
  ggpairs(mapping = aes(alpha = 0.05))

