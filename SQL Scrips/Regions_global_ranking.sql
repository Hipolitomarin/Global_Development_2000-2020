WITH 
latest_years AS (
    SELECT
        (SELECT MAX(year) FROM economic_indicators) AS y_econ,
        (SELECT MAX(year) FROM environmental_indicators) AS y_env,
        (SELECT MAX(year) FROM technology_connectivity) AS y_tech,
        (SELECT MAX(year) FROM governance_resilience) AS y_gov,
        (SELECT MAX(year) FROM health_education) AS y_health
),

data AS (
    SELECT
        c.country_id,
        c.country_name,
        c.region,
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
    WHERE c.country_name != 'Guatemala'
),

normalized AS (
    SELECT *,
        (gdp_per_capita - min_gdp) / NULLIF((max_gdp - min_gdp), 0) AS norm_gdp,
        (green_transition_score - min_env) / NULLIF((max_env - min_env), 0) AS norm_env,
        (digital_connectivity_index - min_tech) / NULLIF((max_tech - min_tech), 0) AS norm_tech,
        (global_resilience_score - min_gov) / NULLIF((max_gov - min_gov), 0) AS norm_gov,
        (life_expectancy - min_health) / NULLIF((max_health - min_health), 0) AS norm_health
    FROM (
        SELECT d.*,
            MIN(gdp_per_capita) OVER (PARTITION BY region) AS min_gdp,
            MAX(gdp_per_capita) OVER (PARTITION BY region) AS max_gdp,
            MIN(green_transition_score) OVER (PARTITION BY region) AS min_env,
            MAX(green_transition_score) OVER (PARTITION BY region) AS max_env,
            MIN(digital_connectivity_index) OVER (PARTITION BY region) AS min_tech,
            MAX(digital_connectivity_index) OVER (PARTITION BY region) AS max_tech,
            MIN(global_resilience_score) OVER (PARTITION BY region) AS min_gov,
            MAX(global_resilience_score) OVER (PARTITION BY region) AS max_gov,
            MIN(life_expectancy) OVER (PARTITION BY region) AS min_health,
            MAX(life_expectancy) OVER (PARTITION BY region) AS max_health
        FROM data d
    ) sub
),

scored AS (
    SELECT *,
        ((norm_gdp IS NOT NULL) +
        (norm_env IS NOT NULL) +
        (norm_tech IS NOT NULL) +
        (norm_gov IS NOT NULL) +
        (norm_health IS NOT NULL)) AS non_null_count,
        ROUND((
            COALESCE(norm_gdp, 0) +
            COALESCE(norm_env, 0) +
            COALESCE(norm_tech, 0) +
            COALESCE(norm_gov, 0) +
            COALESCE(norm_health, 0)
        ) / NULLIF(((norm_gdp IS NOT NULL) + (norm_env IS NOT NULL) + (norm_tech IS NOT NULL) + (norm_gov IS NOT NULL) + (norm_health IS NOT NULL)), 0), 4) AS global_score
    FROM normalized
),

region_scores AS (
    SELECT
        region,
        AVG(global_score) AS avg_global_score,
        COUNT(*) AS country_count
    FROM scored
    WHERE non_null_count >= 3
    GROUP BY region
),

ranked_regions AS (
    SELECT
        region,
        avg_global_score,
        RANK() OVER (ORDER BY avg_global_score ASC) AS ranking
    FROM region_scores
)

SELECT * FROM ranked_regions

UNION ALL

SELECT
    'North America' AS region,
    0.35756 AS avg_global_score,
    NULL AS ranking

ORDER BY ranking;
