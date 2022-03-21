-- looking at total population vs vaccination
-- USE CTE
with PopvsVac (continent, location, date, population, new_vaccinations, RollingPeopleVaccinated)
as
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
 sum(convert(vac.new_vaccinations, unsigned)) over (partition by dea.location order by dea.location,
 dea.date) as RollingPeopleVaccinated
-- , (RollingPeaopleVacccinated/population)*100
FROM coviddb.covid_death dea
JOIN coviddb.covid_vax vac
  on dea.location = vac.location
  and dea.date = vac.date
  where dea.continent is not null
  -- order by 2, 3
  )
  select *, (RollingPeopleVaccinated/population)*100
  from PopvsVac
  
  -- Temp TABLE

Drop table if exists PercentPopulationVaccinated
Create table PercentPopulationVaccinated
(continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_Vaccinations numeric,
RollingPeopleVaccinated numeric)
Insert into PercentPopulationVaccinated  
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
 sum(convert(vac.new_vaccinations, unsigned)) over (partition by dea.location order by dea.location,
 dea.date) as RollingPeopleVaccinated
-- , (RollingPeaopleVacccinated/population)*100
FROM coviddb.covid_death dea
JOIN coviddb.covid_vax vac
  on dea.location = vac.location
  and dea.date = vac.date
  where dea.continent is not null
  -- order by 2, 3;
  select *, (RollingPeopleVaccinated/population)*100
  from PercentPopulationVaccinated;
  
  
-- creatingg view to store data for later visualization

create view PercentPopulationVaccinated as
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
 sum(convert(vac.new_vaccinations, unsigned)) over (partition by dea.location order by dea.location,
 dea.date) as RollingPeopleVaccinated
-- , (RollingPeaopleVacccinated/population)*100
FROM coviddb.covid_death dea
JOIN coviddb.covid_vax vac
  on dea.location = vac.location
  and dea.date = vac.date
 where dea.continent is not null
-- order by 2, 3
;