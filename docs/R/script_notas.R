#================================================
# Script para testes iniciais
# Ícaro Vidal Freire
# https://github.com/icaro-freire/estat_2020.1
#================================================

# Carregando pacotes ----------------------------------------------------------
library(tidyverse)

# Tabela Base -----------------------------------------------------------------
tabela_nota <- tribble(
  ~matricula   , ~nome,     ~licoes, ~atv_ava, ~prova_01, ~prova_02,
  "201610405"  , "bruno"    ,  96.0,     87.5,      82.0,      60.0,
  "2018208291" , "mateus"   ,  88.8,     90.7,      76.0,      40.0,
  "201411204"  , "nilson"   ,  92.8,     90.7,      73.0,      47.0,
  "2017204467" , "rosenilda", 100.0,     95.0,      93.0,      90.0,
  "201311500"  , "sheila"   ,  96.0,     90.7,      61.0,      24.0,
  "2017204690" , "tiago"    ,  94.8,     95.0,      93.0,     100.0,
  "2017204556" , "yago"     ,  96.7,     95.0,      95.0,     100.0
)

# Adicionando media de prova e parcial ----------------------------------------
nota_estat <- tabela_nota %>%
  mutate(
    media_prova = round((prova_01 + prova_02)/2, 1),
    parcial = (3 * licoes + 3 * atv_ava + 4 * media_prova)/100
  )

# Vetor para o ponto extra ----------------------------------------------------
ponto_extra <- c(1, 0, 1, 0, 0, 1, 1)

# Adicionando Ponto Extra -----------------------------------------------------
nota_estat <- nota_estat %>%
  mutate(
    extra = ponto_extra
  )

# Nota final ------------------------------------------------------------------
nota_estat <- nota_estat %>%
  mutate(
    nota = round(if_else(parcial + extra < 10, parcial + extra, 10), 1)
  )

# Escrevendo csv --------------------------------------------------------------
## Retirando o nome
nota_final <- nota_estat %>%
  select(!nome)

## Criando csv
write_csv(nota_final, "dados/nota_estat.csv")
