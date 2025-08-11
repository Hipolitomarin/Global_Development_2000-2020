WITH latest_years AS (
    SELECT
        (SELECT MAX(year) FROM economic_indicators) AS y_econ,
        (SELECT MAX(year) FROM environmental_indicators) AS y_env,
        (SELECT MAX(year) FROM technology_connectivity) AS y_tech,
        (SELECT MAX(year) FROM governance_resilience) AS y_gov,
        (SELECT MAX(year) FROM health_education) AS y_health
),

data AS (
    SELECT
        c.country_name,
        ei.gdp_per_capita,
        env.green_transition_score,
        tech.digital_connectivity_index,
        gov.global_resilience_score,
        health.life_expectancy
    FROM countries c
    LEFT JOIN economic_indicators ei ON ei.country_id = c.country_id AND ei.year = (SELECT y_econ FROM latest_years)
    LEFT JOIN environmental_indicators env ON env.country_id = c.country_id AND env.year = (SELECT y_env FROM latest_years)
    LEFT JOIN technology_connectivity tech ON tech.country_id = c.country_id AND tech.year = (SELECT y_tech FROM latest_years)
    LEFT JOIN governance_resilience gov ON gov.country_id = c.country_id AND gov.year = (SELECT y_gov FROM latest_years)
    LEFT JOIN health_education health ON health.country_id = c.country_id AND health.year = (SELECT y_health FROM latest_years)
),

normalized AS (
    SELECT *,
        (gdp_per_capita - MIN(gdp_per_capita) OVER()) / NULLIF(MAX(gdp_per_capita) OVER() - MIN(gdp_per_capita) OVER(), 0) AS norm_gdp,
        (green_transition_score - MIN(green_transition_score) OVER()) / NULLIF(MAX(green_transition_score) OVER() - MIN(green_transition_score) OVER(), 0) AS norm_env,
        (digital_connectivity_index - MIN(digital_connectivity_index) OVER()) / NULLIF(MAX(digital_connectivity_index) OVER() - MIN(digital_connectivity_index) OVER(), 0) AS norm_tech,
        (global_resilience_score - MIN(global_resilience_score) OVER()) / NULLIF(MAX(global_resilience_score) OVER() - MIN(global_resilience_score) OVER(), 0) AS norm_gov,
        (life_expectancy - MIN(life_expectancy) OVER()) / NULLIF(MAX(life_expectancy) OVER() - MIN(life_expectancy) OVER(), 0) AS norm_health
    FROM data
),

scored AS (
    SELECT *,
        ((norm_gdp IS NOT NULL) +
         (norm_env IS NOT NULL) +
         (norm_tech IS NOT NULL) +
         (norm_gov IS NOT NULL) +
         (norm_health IS NOT NULL)
        ) AS non_null_count,
        ROUND((
            COALESCE(norm_gdp, 0) +
            COALESCE(norm_env, 0) +
            COALESCE(norm_tech, 0) +
            COALESCE(norm_gov, 0) +
            COALESCE(norm_health, 0)
        ) / NULLIF(
            (norm_gdp IS NOT NULL) +
            (norm_env IS NOT NULL) +
            (norm_tech IS NOT NULL) +
            (norm_gov IS NOT NULL) +
            (norm_health IS NOT NULL),
        0), 4) AS global_score
    FROM normalized
)

SELECT
    country_name,
    global_score,
    RANK() OVER (ORDER BY global_score ASC) AS ranking
FROM scored
WHERE non_null_count >= 3
ORDER BY ranking
LIMIT 10;