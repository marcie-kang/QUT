#Workshop 12

df <- read_csv('ozone.csv')
df_long <- gather(df, City, Ozone, Melbourne:Hobart, factor_key = T)
df_long <- na.omit(df_long)

  ggplot(df_long, aes(y = Ozone, x = Year ))+
  geom_point(aes(colour = City))+
  theme_bw()

  ggplot(df_long, aes(y = Ozone, x = Year, colour = City)) +
    geom_point()+
    geom_smooth(method = "lm", se = F)+
    theme_bw()

#LM 1
  m_ozone <- lm(data = df_long, Ozone ~ Year)
  library(broom)
  kable(tidy(m_ozone, conf.int = T))

  augment(m_ozone,df_long) %>%
    ggplot(aes(x = .fitted, y= .resid))+
    geom_point(aes(colour = City))+
    theme_bw()
#LM2
  lm_ozone2 <- lm(data = df_long, Ozone ~ Year + City)
  kable(tidy(lm_ozone2, conf.int= T))  
  summary(lm_ozone2)  

  fortify(lm_ozone2) %>%
    ggplot(aes(x = .fitted, y = .resid))+
    geom_point(aes(colour = City))+
    theme_bw()

  fortify(lm_ozone2) %>%
    ggplot(aes(sample = .stdresid))+
    stat_qq()+
    theme_bw()+
    geom_abline()+
    coord_equal()  
#ANOVA
  anova(m_ozone, lm_ozone2)  

#LM3
  lm_ozone3 <- lm(data = df_long, Ozone ~ Year*City)
  kable(tidy(lm_ozone3, conf.int = T))

  fortify(lm_ozone3) %>%
    ggplot(aes(x = .fitted, y = .resid))+
    geom_point(aes(colour = City))+
    theme_bw()
  
  fortify(lm_ozone3) %>%
    ggplot(aes(sample = .stdresid))+
    stat_qq()+
    theme_bw()+
    geom_abline()+
    coord_equal()
  
    anova(lm_ozone2, lm_ozone3)
  