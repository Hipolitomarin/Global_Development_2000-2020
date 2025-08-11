SELECT
  year,
  AVG(gdp_usd) AS avg_gdp_usd
FROM economic_indicators
GROUP BY year
ORDER BY year;