-- Here we are going to try to answer different problem statements about
-- Performance, Risk, Liquidity, Diversification, Market behavior

SELECT * FROM crypto.crypto_daily;

-- Data-quality overview
SELECT COUNT(*) AS row_count,
       COUNT(DISTINCT symbol) AS crypto_count,
       MIN(DATE(`observed_at`)) AS first_date,
       MAX(DATE(`observed_at`)) AS last_date,
       SUM(is_zero_volume = TRUE) AS zero_volume_rows,
       SUM(is_zero_marketcap = TRUE) AS zero_marketcap_rows
FROM crypto_daily;

