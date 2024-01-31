--SELECT *
--From PortfolioProject.dbo.CovidDeaths
--WHERE continent is not NULL
--order by 3,4

--SELECT *
--From PortfolioProject..CovidVaccinations
--order by 3,4


SELECT location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeaths
WHERE continent is not NULL
order by 1,2

-- Total Cases VS Total Deaths

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
WHERE location like '%India%' and continent is not null
order by 1,2


-- Total Cases VS Population (percentage of population got covid)

SELECT location, date, total_cases, population, (total_cases/population)*100 as InfectionPercentage
From PortfolioProject..CovidDeaths
WHERE continent is not NULL
--WHERE location like '%India%'
order by 1,2


-- Looking at countries with highest infection rate compared to population

SELECT location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as InfectionPercentage
From PortfolioProject..CovidDeaths
WHERE continent is not NULL
--WHERE location like '%India%'
GROUP BY location, population
order by InfectionPercentage DESC


-- Looking at countries with highest Death rate compared to population

SELECT location, MAX(cast(total_deaths as int )) as TotalDeathCount
From PortfolioProject..CovidDeaths
WHERE continent is not NULL
--WHERE location like '%India%'
GROUP BY location, population
order by TotalDeathCount DESC



-- Showing Continents with highest death counts


SELECT continent, MAX(cast(total_deaths as int )) as TotalDeathCount
From PortfolioProject..CovidDeaths
WHERE continent is not NULL
--WHERE location like '%India%'
GROUP BY continent
order by TotalDeathCount DESC



-- Global Numbers


SELECT date, SUM(new_cases) TotalCases, SUM(Cast(new_deaths as int)) TotalDeaths, SUM(Cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
--WHERE location like '%India%' 
Where continent is not null
Group by date
order by 1,2

SELECT SUM(new_cases) TotalCases, SUM(Cast(new_deaths as int)) TotalDeaths, SUM(Cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
--WHERE location like '%India%' 
Where continent is not null
--Group by date
order by 1,2

--------------------------------------------------

--- Total Population VS Vaccinations

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location, dea.date) RollingPeopleVaccinated
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location 
	and dea.date = vac.date
where dea.continent is not null
order by 2, 3


-- Using CTE

With PopVsVac (Continent, Location, Date, Population,New_Vaccinations, RollingPeopleVaccinated)
as(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location, dea.date) RollingPeopleVaccinated
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location 
	and dea.date = vac.date
where dea.continent is not null
--order by 2, 3
) 

Select *, (RollingPeopleVaccinated/Population)*100 PercentageVaccinated
FROM PopVsVac


-- Using TempTable

DROP TABLE IF EXISTS #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_Vaccinations numeric,
RollingPeopleVaccinated numeric
)

INSERT INTO #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location, dea.date) RollingPeopleVaccinated
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location 
	and dea.date = vac.date
where dea.continent is not null
--order by 2, 3

Select *, (RollingPeopleVaccinated/Population)*100 PercentageVaccinated
FROM #PercentPopulationVaccinated




--- Creating Views For Visualization

Create View PercentPopulationVaccinated as
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location, dea.date) RollingPeopleVaccinated
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location 
	and dea.date = vac.date
where dea.continent is not null
--order by 2, 3


SELECT * 
FROM PercentPopulationVaccinated