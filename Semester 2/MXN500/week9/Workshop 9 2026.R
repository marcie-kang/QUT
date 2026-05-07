#Workshop 9 2026

library(tidyverse)
df <- read_csv('hfi_cc_2018.csv')

df <- filter(df,year == 2016)

ggplot() +
  geom_map(data=WorldData, map=WorldData,
           aes(x = long, y = lat, group=group, map_id=region),
           fill="white", colour="#7f7f7f", size=0.5)+
  geom_map(data = df, map = WorldData,
           aes(fill = hf_score, map_id = countries),
           colour = "#7f7f7f", size = 0.5) +
  coord_map("rectangular", lat=0, xlim=c(-180,180), ylim=c(-60, 90))+
  scale_fill_continuous(low="white", high="blue",
                        guide="colorbar")+
  scale_y_continuous(breaks=c())+
  scale_x_continuous(breaks=c())+
  labs(fill="HF Score", title="Human Freedom Index", x="", y="")+
  theme_bw()

ggplot(data = df, aes(x = pf_score, y = hf_score))+
  geom_point()+
  theme_bw()+
  labs(x = "Personal Freedom Score", y = "Human Freedom Score")

ggplot(data = df, aes(x = ef_score, y = hf_score))+
  geom_point()+
  theme_bw()+
  labs(x = "Economic Freedom Score", y = "Human Freedom Score")

personal_model <- lm(data=df, hf_score ~ pf_score)
summary(personal_model)

library(broom)
tidy(personal_model, conf.int = T, conf.level = 0.95) %>%
  select(term, estimate, conf.low, conf.high, p.value)

personal_model$coefficients[1]+personal_model$coefficients[2]*7
predict(personal_model, newdata = data.frame(pf_score = c(7)))

round(glance(personal_model)$r.squared,4)

pm.fort <- fortify(personal_model)
head(pm.fort)

ggplot(data = pm.fort, aes(x = .fitted, y = .resid))+
  geom_point()+
  theme_bw()+
  geom_smooth()+
  labs(x = expression(paste("Fitted (",hat(y[i]), ")")), y = expression(paste("Residual
(",epsilon[i],")")))

ggplot(data = pm.fort, aes(x = .resid))+
  geom_histogram(colour = "grey", fill = "coral", aes(y = ..density..))+
  theme_bw()+
  stat_function(fun = dnorm, args = list(mean = mean(pm.fort$.resid), sd =
                                           sd(pm.fort$.resid)))+
  labs(x = "Residual", y = "Density")

ggplot(data = pm.fort, aes(x = .stdresid))+
  geom_histogram(colour = "grey", fill = "coral", aes(y = ..density..))+
  theme_bw()+
  stat_function(fun = dnorm, args = list(mean = 0, sd = 1))+
  labs(x = "Standardised Residual", y = "Density")

ggplot(data=pm.fort, aes(sample=.stdresid)) +
  stat_qq() +
  geom_abline(intercept=0, slope=1) +
  coord_equal()+
  theme_bw()

