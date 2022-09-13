--First I would like to get an idea of the averages for each participant's ACTIVITY data across the span of the survey (4/12/16-5/12/16). 
-- HA Highly Active, MOD Moderately Active, LA Lightly Active, SED Sedentary

SELECT 
  Id, 
  AVG(Calories) AS Avg_Daily_Calories,
  Avg(TotalSteps) AS Avg_Daily_Steps, 
  Avg(TotalDistance) AS Avg_Daily_Distance_km,
  Avg(VeryActiveDistance) AS Avg_HA_Distance_km,
  safe_divide((Avg(VeryActiveDistance)), Avg(TotalDistance)) * 100 AS Avg_HA_Dist_percent_Total_Dist,
  Avg(ModeratelyActiveDistance) AS Avg_MOD_Distance_km,
  safe_divide(Avg(ModeratelyActiveDistance), Avg(TotalDistance)) * 100 AS Avg_MOD_Dist_percent_Total_Dist,
  Avg(LightActiveDistance) AS Avg_LA_Distance_km,
  safe_divide(Avg(LightActiveDistance), Avg(TotalDistance)) * 100 AS Avg_LA_Dist_percent_Total_Dist,
  Avg(SedentaryActiveDistance) AS Avg_SED_Distance_km,
  safe_divide(Avg(SedentaryActiveDistance), Avg(TotalDistance)) * 100 AS Avg_SED_Dist_percent_Total_Dist,
  Avg(VeryActiveMinutes+FairlyActiveMinutes+LightlyActiveMinutes+SedentaryMinutes) AS Avg_Total_Min_Tracked,
  Avg(VeryActiveMinutes) AS Avg_HA_Min,
  safe_divide(Avg(VeryActiveMinutes), Avg(VeryActiveMinutes+FairlyActiveMinutes+LightlyActiveMinutes+SedentaryMinutes)) * 100 AS avg_HA_Min_Percent_Total_Min,
  Avg(FairlyActiveMinutes) AS Avg_MOD_Min,
  safe_divide(Avg(FairlyActiveMinutes), Avg(VeryActiveMinutes+FairlyActiveMinutes+LightlyActiveMinutes+SedentaryMinutes)) * 100 AS avg_MOD_Min_Percent_Total_Min,
  Avg(LightlyActiveMinutes) AS Avg_LA_Min,
  safe_divide(Avg(LightlyActiveMinutes), Avg(VeryActiveMinutes+FairlyActiveMinutes+LightlyActiveMinutes+SedentaryMinutes)) * 100 AS avg_LA_Min_Percent_Total_Min,
  Avg(SedentaryMinutes) AS Avg_SED_Min,
  safe_divide(Avg(SedentaryMinutes), Avg(VeryActiveMinutes+FairlyActiveMinutes+LightlyActiveMinutes+SedentaryMinutes)) * 100 AS avg_SED_Min_Percent_Total_Min


FROM `bbfitbit.fitabaseData.DailyActivity` 
GROUP BY
  Id