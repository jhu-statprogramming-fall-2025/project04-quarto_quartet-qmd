rm(list = ls())
gc()

NSF_data <- readRDS("~/Downloads/NSF_Cleaned.rds")

head(NSF_data)
str(NSF_data)
summary(NSF_data)
class(NSF_data)


NIH_data <- readRDS("~/Downloads/nih_data_clean.rds")

head(NIH_data)
str(NIH_data)

library(dplyr)
library(tidyr)
library(tidytext)
library(stringr)

nih_text <- NIH_data %>%
  rename(
    title = `Project Title`,
    phr   = `Project Abstract`
  ) %>%
  mutate(
    source = "NIH"
  )

nsf_text <- NSF_data %>%
  rename(
    title    = `Project Title`,
    abstract = Abstract
  ) %>%
  mutate(
    source = "NSF"
  )

rm(NSF_data, NIH_data)


combined_data <- bind_rows(
  nih_text %>%
    select(title, abstract = phr, source),
  nsf_text %>%
    select(title, abstract, source)
)

saveRDS(combined_data, "~/Downloads/combined_data.rds")

head(combined_data)
str(combined_data)
summary(combined_data)
class(combined_data)
dim(combined_data)
dim(nsf_text)
dim(nih_text)
