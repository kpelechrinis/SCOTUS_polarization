library(tidyverse)
library(readr)

mq <- read_csv("justices.csv")

mq <- mq %>%
  mutate(post_sd = (post_975 - post_025) / (2 * 1.96))

mq <- mq %>%
  mutate(prob_neutral = pnorm(0.5, mean = post_mn, sd = post_sd) - 
           pnorm(-0.5, mean = post_mn, sd = post_sd))

# while there are 9 justices per term we do this to avoid missing data for a judge
justices_per_term <- mq %>%
  group_by(term) %>%
  summarise(n_justices = n_distinct(justice))

mq <- mq %>%
  left_join(justices_per_term, by = "term") %>%
  mutate(expected_neutral_normalized = prob_neutral / n_justices)

mq <- mq %>%
  mutate(decade = floor(term / 10) * 10)

summary_by_decade <- mq %>%
  group_by(decade) %>%
  summarise(expected_neutrals_per_decade = sum(expected_neutral_normalized))

ggplot(summary_by_decade, aes(x = decade, y = expected_neutrals_per_decade)) +
  geom_col(fill = "lightcoral", alpha = 0.7, width = 8) +
  geom_smooth(method = "loess", span = 0.6, se = TRUE, color = "darkred", fill = "salmon", linewidth = 1.5) +
  labs(
    title = "Expected Number of Neutral Justices per Decade",
    subtitle = "Neutral defined as Martin–Quinn score between -0.5 and 0.5",
    x = "Decade",
    y = "xNeutral Justices (Summed, Normalized per Term)"
  ) +
  theme_minimal(base_size = 14)
