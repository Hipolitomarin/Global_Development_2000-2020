"""
🌍 Global Development Indicators - Exploratory Data Analysis
------------------------------------------------------------

Presentation Link : https://docs.google.com/presentation/d/1Z9Fsf2t3ZC5NKyGQZSKE6SLsBo0XWO2Ex3GL2BoZ6mU/edit?slide=id.g37368cef7d1_0_54#slide=id.g37368cef7d1_0_54

📝 Description
This comprehensive dataset merges global economic, environmental, technological, and human development indicators from 2000 to 2020. Sourced and transformed from multiple public datasets via Google BigQuery, it is designed for advanced exploratory data analysis, machine learning, policy modeling, and sustainability research.

Curated by combining and transforming data from the Google BigQuery Public Data program, this dataset offers a harmonized view of global development across more than 40 key indicators spanning over two decades (2000–2020). It supports research across multiple domains such as:

Economic Growth
Climate Sustainability
Digital Transformation
Public Health
Human Development
Resilience and Governance

🎯 Objectives:
- Understand trends over time (e.g., GDP, emissions, life expectancy)
- Compare development patterns across regions/income groups
- Explore relationships among health, environment, and digital growth
- Highlight pandemic period effects and resilience metrics
- Create a machine learning model to predict the GPD depending of other variables.

📚 Libraries Used

- **pandas**: For data manipulation and handling tabular data structures.
- **numpy**: Provides support for numerical operations on arrays and matrices.
- **scikit-learn (sklearn)**: Offers machine learning tools including data splitting, preprocessing, modeling (Random Forest), evaluation metrics, and feature importance analysis.
- **matplotlib.pyplot**: Used for creating visualizations and plots.
- **seaborn**: Provides enhanced statistical plotting capabilities built on top of matplotlib.

📅 Temporal Coverage
Years: 2000–2020

Includes calculated features:

years_since_2000
years_since_century
is_pandemic_period (binary indicator for pandemic periods)

📋 **Column Descriptions** 

**year**: Year of the recorded data, representing a time series for each country.  
**country_code**: Unique code assigned to each country (ISO-3166 standard).  
**country_name**: Name of the country corresponding to the data.  
**region**: Geographical region of the country (e.g., Africa, Asia, Europe).  
**income_group**: Income classification based on Gross National Income (GNI) per capita (low, lower-middle, upper-middle, high income).  
**currency_unit**: Currency used in the country (e.g., USD, EUR).  
**gdp_usd**: Gross Domestic Product (GDP) in USD (millions or billions).  
**population**: Total population of the country for the given year.  
**gdp_per_capita**: GDP divided by population (economic output per person).  
**inflation_rate**: Annual rate of inflation (price level rise).  
**unemployment_rate**: Percentage of the labor force unemployed but seeking employment.  
**fdi_pct_gdp**: Foreign Direct Investment (FDI) as a percentage of GDP.  
**co2_emissions_kt**: Total CO₂ emissions in kilotons (kt).  
**energy_use_per_capita**: Energy consumption per person (kWh).  
**renewable_energy_pct**: Percentage of energy consumption from renewable sources.  
**forest_area_pct**: Percentage of total land area covered by forests.  
**electricity_access_pct**: Percentage of the population with access to electricity.  
**life_expectancy**: Average life expectancy at birth.  
**child_mortality**: Deaths of children under 5 per 1,000 live births.  
**school_enrollment_secondary**: Percentage of population enrolled in secondary education.  
**health_expenditure_pct_gdp**: Percentage of GDP spent on healthcare.  
**hospital_beds_per_1000**: Hospital beds per 1,000 people.  
**physicians_per_1000**: Physicians (doctors) per 1,000 people.  
**internet_usage_pct**: Percentage of population with internet access.  
**mobile_subscriptions_per_100**: Mobile subscriptions per 100 people.  
**calculated_gdp_per_capita**: Alternative calculation or updated GDP per capita data.  
**real_economic_growth_indicator**: Real GDP growth, adjusted for inflation.  
**econ_opportunity_index**: Economic opportunities available (e.g., job availability, ease of doing business).  
**co2_emissions_per_capita_tons**: CO₂ emissions per person in tons.  
**co2_intensity_per_million_gdp**: CO₂ emissions per million units of GDP.  
**green_transition_score**: Score representing progress toward a greener economy.  
**ecological_preservation_index**: Index measuring ecological system preservation.  
**renewable_energy_efficiency**: Efficiency of renewable energy use.  
**human_development_composite**: Composite index combining health, education, and income indicators.  
**healthcare_capacity_index**: Index measuring healthcare system capacity.  
**digital_connectivity_index**: Digital connectivity score, including internet and mobile network access.  
**health_development_ratio**: Ratio of health indicators relative to overall development.  
**education_health_ratio**: Ratio of education indicators relative to health indicators.  
**years_since_2000**: Years since the year 2000, used for time series analysis.  
**years_since_century**: Years since the start of the current century (2001).  
**is_pandemic_period**: Binary indicator marking periods affected by a global pandemic (e.g., COVID-19).  
**human_development_index**: Measures achievements in health, education, and standard of living.  
**climate_vulnerability_index**: Measures vulnerability to climate change, including exposure to extreme weather and resilience.  
**digital_readiness_score**: Preparedness for the digital economy, including infrastructure and education.  
**governance_quality_index**: Measures governance quality (e.g., corruption control, political stability).  
**global_resilience_score**: Composite score of resilience to global crises.  
**global_development_resilience_index**: Measures resilience to global challenges like climate change and economic shifts.


  
