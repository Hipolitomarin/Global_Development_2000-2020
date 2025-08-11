-- Crear base de datos (opcional)
CREATE DATABASE IF NOT EXISTS sustainable_data;
USE sustainable_data;

-- Country table (metadata)
CREATE TABLE countries (
  country_id VARCHAR(200) PRIMARY KEY,
  country_name VARCHAR(200),
  region VARCHAR(200),
  income_group VARCHAR(200),
  currency_unit VARCHAR(200),
  INDEX idx_region (region),
  INDEX idx_income_group (income_group)
);

-- Economic indicators
CREATE TABLE economic_indicators (
  year INT,
  country_id VARCHAR(200),
  gdp_usd DECIMAL(15,2) CHECK (gdp_usd >= 0),
  gdp_per_capita DECIMAL(15,2) CHECK (gdp_per_capita >= 0),
  fdi_pct_gdp DECIMAL(5,2) CHECK (fdi_pct_gdp >= 0),
  inflation_rate DECIMAL(5,2),
  unemployment_rate DECIMAL(5,2) CHECK (unemployment_rate >= 0),
  real_economic_growth_indicator DECIMAL(5,2),
  PRIMARY KEY (year, country_id),
  FOREIGN KEY (country_id) REFERENCES countries(country_id),
  INDEX idx_year_economic (year)
);

-- Environmental indicators
CREATE TABLE environmental_indicators (
  year INT,
  country_id VARCHAR(200),
  co2_emissions_kt DECIMAL(15,2) CHECK (co2_emissions_kt >= 0),
  co2_emissions_per_capita_tons DECIMAL(10,2) CHECK (co2_emissions_per_capita_tons >= 0),
  renewable_energy_pct DECIMAL(5,2) CHECK (renewable_energy_pct BETWEEN 0 AND 100),
  forest_area_pct DECIMAL(5,2) CHECK (forest_area_pct BETWEEN 0 AND 100),
  green_transition_score DECIMAL(5,2),
  co2_intensity_per_million_gdp DECIMAL(10,2),
  PRIMARY KEY (year, country_id),
  FOREIGN KEY (country_id) REFERENCES countries(country_id),
  INDEX idx_year_env (year)
);

-- Technology and connectivity
CREATE TABLE technology_connectivity (
  year INT,
  country_id VARCHAR(200),
  internet_usage_pct DECIMAL(5,2) CHECK (internet_usage_pct BETWEEN 0 AND 100),
  mobile_subscriptions_per_100 DECIMAL(5,2),
  digital_readiness_score DECIMAL(5,2),
  digital_connectivity_index DECIMAL(5,2),
  PRIMARY KEY (year, country_id),
  FOREIGN KEY (country_id) REFERENCES countries(country_id),
  INDEX idx_year_tech (year)
);

-- Governance and resilience
CREATE TABLE governance_resilience (
  year INT,
  country_id VARCHAR(200),
  governance_quality_index DECIMAL(5,2),
  global_resilience_score DECIMAL(5,2),
  human_development_composite DECIMAL(5,2),
  ecological_preservation_index DECIMAL(5,2),
  PRIMARY KEY (year, country_id),
  FOREIGN KEY (country_id) REFERENCES countries(country_id),
  INDEX idx_year_gov (year)
);

-- Health and education
CREATE TABLE health_education (
  year INT,
  country_id VARCHAR(200),
  life_expectancy DECIMAL(5,2) CHECK (life_expectancy >= 0),
  child_mortality DECIMAL(5,2) CHECK (child_mortality >= 0),
  school_enrollment_secondary DECIMAL(5,2) CHECK (school_enrollment_secondary BETWEEN 0 AND 100),
  healthcare_capacity_index DECIMAL(5,2),
  health_development_ratio DECIMAL(5,2),
  PRIMARY KEY (year, country_id),
  FOREIGN KEY (country_id) REFERENCES countries(country_id),
  INDEX idx_year_health (year)
);