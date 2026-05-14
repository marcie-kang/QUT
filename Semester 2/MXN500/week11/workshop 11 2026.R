#Workshop 11 2026

library(broom)
library(tidyverse)
df <- read_csv("dengue.csv")
df <- mutate(df, LogLoad = log10(Load))
lm_dengue2 <- lm(data = df, LogLoad ~ poly(Days, 2, raw = T))
tidy(lm_dengue2) %>%
  select(term, estimate)

beta_vec <- tidy(lm_dengue2) %>%
  select(estimate)
beta_1 <- beta_vec$estimate[2]
beta_2 <- beta_vec$estimate[3]

newdata <- data.frame(Days = c(-beta_1 / (2 * beta_2)))

max_Load <- predict(object = lm_dengue2, newdata = newdata, interval = "conf", level = 0.95)
max_Load

max_Load_actual <- 10^max_Load
max_Load_actual

newdata <- data.frame(Days = seq(-5, 6, by = 0.5))
lm_dengue2 <- lm(data = df, log(Load) ~ poly(Days, 2, raw = T))

pred_load <- data.frame(predict(object = lm_dengue2, newdata = newdata, interval = "conf", level = 0.95))

pred_load <- bind_cols(newdata, pred_load)

ggplot(data = df, aes(x = Days)) +
  geom_point(aes(y = log(Load))) +
  geom_ribbon(
    data = pred_load,
    aes(ymin = lwr, ymax = upr),
    fill = "lightskyblue",
    colour = NA,
    alpha = 0.25
  ) +
  geom_line(data = pred_load, aes(y = fit)) +
  theme_bw()

lm_dengue <- lm(data = df, log(Load) ~ Days)
lm_dengue2 <- lm(data = df, log(Load) ~ poly(Days, 2, raw = T))

summary(lm_dengue)
summary(lm_dengue2)

anova(lm_dengue, lm_dengue2)

df <- read_csv('Piemonte_data_byday.csv')
df <- na.omit(df)

df <- mutate(df, logPM10 = log(PM10))

library(GGally)
df %>%
  select(-one_of(c("Station.ID", "Date", "PM10"))) %>%
  ggpairs(mapping = aes(alpha = 0.05))

df %>%
  select(-one_of(c("Station.ID", "Date", "UTMX", "UTMY"))) %>%
  ggpairs()

lm1 <- lm(data = df, logPM10 ~ WS)

library(broom)
library(knitr)
tidy(lm1, conf.int = T) %>%
  kable()
summary(lm1)

lm1.aug <- augment(lm1, df)

ggplot(data  = lm1.aug, aes(x = .fitted, y = .resid))+
  geom_point(alpha = 0.2)+
  geom_smooth()+
  theme_bw()

ggplot(data = lm1.aug, aes(sample = .std.resid))+
  stat_qq()+
  geom_abline()+
  coord_equal()+
  theme_bw()

ggplot(data = lm1.aug, aes( x = PREC, y = .resid))+
  geom_point(alpha = 0.2)+
  geom_smooth()+
  scale_x_continuous(name = "Precipitation")+
  theme_bw()


lm2 <- lm(data = df, logPM10 ~ WS + PREC )

library(broom)

tidy(lm2, conf.int = T) %>%
  kable()

lm2.aug <- augment(lm2, df)

ggplot(data = lm2.aug, aes(x = .fitted, y = .resid))+
  geom_point(alpha=0.2)+
  geom_smooth()+
  theme_bw()

ggplot(data = lm2.aug, aes(sample = .std.resid))+
  stat_qq()+
  geom_abline()+
  coord_equal()+
  theme_bw()

anova(lm1, lm2)

lm3 <- lm(data = df, logPM10 ~ WS*PREC)
tidy(lm3, conf.int = T) %>%
  kable()

lm3.aug <- augment(lm3, df)

ggplot(data = lm3.aug, aes(x = .fitted, y = .resid))+
  geom_point(alpha=0.2)+
  geom_smooth()+
  theme_bw()

ggplot(data = lm3.aug, aes(sample = .std.resid))+
  stat_qq()+
  geom_abline()+
  coord_equal()+
  theme_bw()

anova(lm2, lm3)

lm4 <- lm(data = df, logPM10 ~ WS + TEMP + HMIX + EMI + PREC + A)

tidy(lm4, conf.int = T) %>%
  kable()

lm4.aug <-augment(lm4, df)

ggplot(data = lm4.aug, aes(x = .fitted, y = .resid))+
  geom_point(alpha = 0.2)+
  geom_smooth()+
  theme_bw()

ggplot(data=lm4.aug, aes(x=.fitted, y=.resid)) +
  geom_point(alpha = 0.2) +
  facet_wrap( ~ Station.ID)+
  theme_bw()


