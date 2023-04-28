#  Big Query
# Consultas CSV-Global Table
#  TOP 10 PAISES COM CASOS ACUMULATIVOS
    - Substituir `aulas-bc-26-nayara-n3-372217.Projetofinal.DF3_GLOBAL_TABLE`  por nome da tabela criada no Big Query

```sql
#  TOP 10 PAISES COM CASOS ACUMULATIVOS 
SELECT
pais,regiao, (casos_cumulativos_totais) as total
FROM
`aulas-bc-26-nayara-n3-372217.Projetofinal.DF3_GLOBAL_TABLE` 
order by total DESC
LIMIT 10
```

---

#  Quantidade de casos por região

```sql
SELECT
regiao,
(max(casos_cumulativos_por_100mil_hab)) as casos 
FROM `aulas-bc-26-nayara-n3-3722⁸17.Projetofinal.DF3_GLOBAL_TABLE` 
WHERE regiao is not null
GROUP BY regiao
ORDER BY casos desc
```

---

- % DE MORTES COMPARADO AO NUMERO DE CASOS  TOTAIS

```sql
#  % de mortes comparado ao n de casos total
SELECT 
pais,
casos_cumulativos_totais,
mortes_cumulativas_totais,
TRUNC(( mortes_cumulativas_totais / casos_cumulativos_totais),3) *100 AS PORCENTAGEM_MORTES
FROM `aulas-bc-26-nayara-n3-372217.Projetofinal.DF3_GLOBAL_TABLE`
where casos_cumulativos_totais <> 0
AND 
mortes_cumulativas_totais <> 0
ORDER BY PORCENTAGEM_MORTES desc;
```

---

- % DE MORTES COMPARADO AO NUMERO DE CASOS  NOS ULTIMOS 7 DIAS

```sql
#  % de mortes comparado ao n de casos x mortes 7 dias 
SELECT 
pais,
casos_cumulativos_totais,
mortes_cumulativas_totais,
TRUNC(( mortes_nos_ultimos_7dias / casos_nos_ultimos_7dias),3) * 100 AS PORCENTAGEM_MORTES
FROM `aulas-bc-26-nayara-n3-372217.Projetofinal.DF3_GLOBAL_TABLE`
where casos_nos_ultimos_7dias <> 0
AND 
mortes_nos_ultimos_7dias <> 0
ORDER BY PORCENTAGEM_MORTES desc
```

---

```sql
#  % de mortes comparado ao n de casos total a cada 100HBT
SELECT 
pais,
casos_cumulativos_por_100mil_hab,
mortes_cumulativas_totais_por_100mil_hab,
TRUNC(( mortes_cumulativas_totais_por_100mil_hab / casos_cumulativos_por_100mil_hab),3) *100 AS PORCENTAGEM_MORTES_100HAB
FROM `aulas-bc-26-nayara-n3-372217.Projetofinal.DF3_GLOBAL_TABLE`
where casos_cumulativos_por_100mil_hab <> 0
AND 
mortes_cumulativas_totais_por_100mil_hab <> 0
ORDER BY PORCENTAGEM_MORTES_100HAB desc
```

```sql
# media
SELECT 
pais,
avg(casos_cumulativos_totais) AS MEDIA_CASOS_TOTAIS,
avg(mortes_cumulativas_totais) AS MEDIA_S_TOTAIS,
avg(casos_nos_ultimos_7dias) AS MEDIA_CASO_7DIAS,
avg(mortes_nos_ultimos_7dias) AS MEDIA_MORTE_7DIAS,

FROM `aulas-bc-26-nayara-n3-372217.Projetofinal.DF3_GLOBAL_TABLE`
WHERE casos_nos_ultimos_7dias <> 0 AND mortes_nos_ultimos_7dias <> 0

GROUP BY  pais 
ORDER BY pais
```

# Consultas CSV-Global Json Europa

#  FILTRAR CASOS PELA SEMANA - ( Semanas vão de 01 a 53)
- FROM `aulas-bc-26-nayara-n3-372217.Projetofinal.DF1_EUROPA_COVID`

```sql
#  FILTRAR CASOS PELA SEMANA - ( Semanas vão de 01 a 53) 
SELECT 
ano,
semana, 
novos_casos, 
pais, 
FROM `aulas-bc-26-nayara-n3-372217.Projetofinal.DF1_EUROPA_COVID`
where semana = 'W32'
ORDER BY novos_casos desc
```

---

```sql
#  MAX de mortes comparado ao n de casos total
SELECT 
pais,
max(novos_casos) as max_novos_casos,
max(taxa_positiva) as  max_positivo,
FROM `aulas-bc-26-nayara-n3-372217.Projetofinal.DF1_EUROPA_COVID` 
where taxa_positiva <> 0 AND novos_casos <> 0
group by pais
order by max_novos_casos desc
```

```sql
#  MAX de mortes comparado ao n de casos total
SELECT
pais,
max(populacao) as MAX_POPULACAO,
max(novos_casos) MAX_CASOS_TOTAIS,
max(teste_ok) as TESTES_FEITOS,
FROM `aulas-bc-26-nayara-n3-372217.Projetofinal.DF1_EUROPA_COVID` 
# where novos_casos > 1
group by pais
order by MAX_CASOS_TOTAIS ASC
```

#  Consultas CSV-GLOBAL DATA

#  Quantidade de tipos de vacina por pais
- FROM `aulas-bc-26-nayara-n3-372217.Projetofinal.DF1_EUROPA_COVID`

```sql

```

---

# Consultas CSV-Vacinas

#   Quantidade de tipos de vacina por pais
- FROM `aulas-bc-26-nayara-n3-372217.Projetofinal.DF1_EUROPA_COVID`

```sql
SELECT
pais, count(*) as QNT_TIPOS_VACINAS
FROM
`aulas-bc-26-nayara-n3-372217.Projetofinal.VACINAS`
#  WHERE pais = 'Brasil'
GROUP by pais
 
ORDER BY QNT_TIPOS_VACINAS DESC
```

---

```sql
#  Primeiros paises a começar a vacinação
SELECT 
pais, 
data_de_inicio,
produto,
empresa
FROM `aulas-bc-26-nayara-n3-372217.Projetofinal.VACINAS`
WHERE  data_de_inicio IS NOT NULL
ORDER BY  data_de_inicio ASC
```

---

```sql
#  CONSULTAR PAISES QUE RECEBERAM AUTORIZAÇÃO ENTRE DIA 01/08/2021 A 31/08/2021
SELECT data_de_autorizacao,data_de_inicio, pais
FROM `aulas-bc-26-nayara-n3-372217.Projetofinal.VACINAS`
WHERE data_de_autorizacao >= '2021-08-01' AND data_de_autorizacao < '2021-08-31'
ORDER BY data_de_autorizacao
```

---

```sql
#  Intervalo entre autorização e começo de vacinação top 10 ASC/DESC
SELECT
pais,
DATE_DIFF(data_de_inicio, data_de_autorizacao, DAY) AS INTERVALO_DIAS,
DATE_DIFF(data_de_inicio, data_de_autorizacao, WEEK) AS INTERVALO_SEMANAS

FROM `aulas-bc-26-nayara-n3-372217.Projetofinal.VACINAS`
WHERE data_de_inicio is not null and data_de_autorizacao is not null 

ORDER BY data_de_autorizacao
```


