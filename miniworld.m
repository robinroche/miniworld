% MiniWorld model, based on "Systems and models" by H. Bossel, p. 105
% http://www.systo.org/miniworld.html
% Implementation by Robin Roche, UTBM - 2014
 
clear all
% Model parameters
birthRate = 0.03;
deathRate = 0.01;
birthControl = 1;
threshold = 1;
absorptionRate = 0.1;
pollutionFactor = 0.02;
consumptionGoal = 10;
capitalGrowthRate = 0.05;
 
% Simulation settings
tend = 250;
tinit = 1;
dt = 1;
 
% Variables initialization
population(1) = 1;
pollution(1) = 1;
capital(1) = 1;
time(1) = 1;
 
 
% Main simulation loop
for t = tinit:tend
    % Intermediary variables update
    quality(t) = threshold/pollution(t);
    consumption(t) = capital(t);
    births(t) = birthRate * population(t) * birthControl * quality(t) * consumption(t);
    deaths(t) = deathRate * population(t) * pollution(t);
    pollutionRate(t) = pollutionFactor * consumption(t) * population(t);
    if(quality(t)>1)
        absorption(t) = absorptionRate*pollution(t);
    else
        absorption(t) = absorptionRate*threshold;
    end
    capitalGrowth(t) = capitalGrowthRate * capital(t) * pollution(t) * (1 - capital(t)*pollution(t)/consumptionGoal));
 
 
    % State variables update
    population(t+1) = population(t) + (births(t)-deaths(t))*dt;
    pollution(t+1) = pollution(t) + (pollutionRate(t)-absorption(t))*dt;
    capital(t+1) = capital(t) + capitalGrowth(t)*dt;
    time(t+1) = time(t) + dt;
end
 
 
% Plot results
plot(time,population,'b',time,pollution,'r',time,capital,'g')
legend('Population','Pollution','Capital')
xlabel('Time [years]')
ylabel('State variables')
xlim([0 tend])
