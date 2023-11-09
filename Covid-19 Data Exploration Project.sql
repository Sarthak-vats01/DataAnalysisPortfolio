SELECT location , date , total_cases , new_cases , total_deaths , population
FROM covid.covid_deaths
ORDER BY 3,4;

-- Looking at the Death percentage 
-- Shows the likelihood of you dying if you contract covid-19 in your country
SELECT location , date , total_cases , new_cases , total_deaths , population , (total_deaths/total_cases)*100 AS death_percentage
FROM covid.covid_deaths
-- where location like "%india%"
ORDER BY 3,4;


-- Percentage of population if infected by covid-19 in your country 
SELECT location , date , total_cases , new_cases , total_deaths , population , (total_cases/population)*100 AS infection_rate
FROM covid.covid_deaths
-- where location like "%india%"
ORDER BY 3,4;

-- Countries sorted by infection rate
SELECT location,population,MAX(total_cases) AS infection_count ,MAX((total_cases/population)*100) AS infection_rate
FROM covid.covid_deaths
GROUP BY location 
order by infection_rate desc;

-- Countries sorted by death count
SELECT location,population,max(total_deaths) as total_death_count
FROM covid.covid_deaths
WHERE continent is not null
GROUP BY location 
order by total_death_count desc;

-- Continents sorted by death count
SELECT continent,max(total_deaths) as total_death_count
FROM covid.covid_deaths
WHERE continent is not null
GROUP BY continent
order by total_death_count desc;



-- GLOBAL NUMBERS (EXPLORATION) 




-- Death percentage globally according to date
SELECT date , sum(new_cases) as total_cases , sum(new_deaths) as total_deaths , (sum(new_deaths)/sum(new_cases))*100 as death_percentage
FROM covid.covid_deaths
WHERE continent is not null
GROUP BY date
ORDER BY death_percentage DESC;

-- Death percentage globally
SELECT sum(new_cases) as total_cases , sum(new_deaths) as total_deaths , (sum(new_deaths)/sum(new_cases))*100 as death_percentage
FROM covid.covid_deaths
WHERE continent is not null
ORDER BY death_percentage DESC;




-- Joining death and vaccinations table 



-- Looking at vaccination vs population
SELECT dea.location , dea.continent , dea.population , vac.new_vaccinations
FROM covid.covid_deaths dea
JOIN covid.covidvaccinations vac
ON 
dea.date = vac.date
WHERE dea.continent is not null
order by vac.new_vaccinations desc;

