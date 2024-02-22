Select *
From PortfolioProject..[covid deaths]
Order by 3,4

Select *
From PortfolioProject..[covid vaccinations 1]
Order by 3,4

--select the data that we are going to be using

Select Location, date, total_cases,new_cases,total_deaths, population
From PortfolioProject..[covid deaths]
Order by 1,2

--converting data types to float before calculation

ALTER TABLE PortfolioProject..[covid deaths]
ALTER COLUMN total_cases FLOAT;

ALTER TABLE PortfolioProject..[covid deaths]
ALTER COLUMN total_deaths FLOAT;

--Looking at the total cases vs total deaths
--This shows the likelihood of dying if you contract covid, in your country

Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100.0 as deathpercentage
From PortfolioProject..[covid deaths]
Where location like '%kingdom%'
Order by 1,2

--Looking at total cases vs population

Select Location, date, population, total_cases, (total_cases/population)*100.0 as totalcasespercentage
From PortfolioProject..[covid deaths]
Where location like '%kingdom%'
order by 2

--Looking at countries with highest infection rate compared to population
Select Location, population, MAX(total_cases) as max_totalcases, MAX((total_cases/population))*100.0 as totalcases_percentage
From PortfolioProject..[covid deaths]
group by location, population
Order by totalcases_percentage desc

--Countries with highest death rate per population
Select Location, MAX(total_deaths) as totaldeathcount
From PortfolioProject..[covid deaths]
Where continent is not null
Group by location
Order by totaldeathcount desc

--Continents with highest death rate
Select continent, MAX(total_deaths) as totaldeathcount
From PortfolioProject..[covid deaths]
Where continent is not null
Group by continent
Order by totaldeathcount desc

--Global numbers

Select SUM(cast(new_cases as float))as totalcases, SUM(cast(new_deaths as float)) as totaldeaths, 
	   SUM(cast(new_deaths as float))/SUM(cast(new_cases as float))  as deathpercentage
From PortfolioProject..[covid deaths]
Where continent is not null
Order by 1,2

--Looking at Total Population vs vaccinations

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
From PortfolioProject..[covid deaths] dea
Join PortfolioProject..[covid vaccinations 1] vac
	ON dea.location = vac.location
	AND dea.date = vac.date
Where dea.continent is not null
Order by 2,3


