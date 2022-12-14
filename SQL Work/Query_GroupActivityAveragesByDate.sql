--Now I would  like the group activity averages per day. Data datespan 4/12/16-512/16

SELECT
  ActivityDate,
  COUNT(DISTINCT Id) AS Participant_Count,
  AVG(Calories) AS grp_Avg_Daily_Calories,
  Avg(TotalSteps) AS grp_Avg_Daily_Steps, 
  Count(*) AS grp_Total_Logs,
  COUNTIF(TotalSteps=0 AND TotalDistance=0) AS grp_Empty_Logs,
  (COUNTIF(TotalSteps=0 AND TotalDistance=0) / Count(*)) * 100 AS grp_Percentage_EmptyLogs,
  COUNTIF(LoggedActivitiesDistance != 0) AS grp_Manual_Logs,
  (COUNTIF(LoggedActivitiesDistance != 0) / Count(*)) * 100 AS grp_Percentage_ManualEntry,
  Avg(TotalDistance) AS grp_Avg_Daily_Distance_km,
  Avg(VeryActiveDistance) AS grp_Avg_HA_Distance_km,
  Avg(ModeratelyActiveDistance) AS grp_Avg_MOD_Distance_km,
  Avg(LightActiveDistance) AS grp_Avg_LA_Distance_km,
  Avg(SedentaryActiveDistance) AS grp_Avg_SED_Distance_km,
  Avg(VeryActiveMinutes+FairlyActiveMinutes+LightlyActiveMinutes+SedentaryMinutes) AS grp_Avg_Total_Min_Tracked,
  Avg(VeryActiveMinutes) AS grp_Avg_HA_Min,
  Avg(FairlyActiveMinutes) AS grp_Avg_MOD_Min,
  Avg(LightlyActiveMinutes) AS grp_Avg_LA_Min,
  Avg(SedentaryMinutes) AS grp_Avg_SED_Min,
  CASE 
    WHEN EXTRACT(DAYOFWEEK FROM ActivityDate) =1 THEN "Sunday"
    WHEN EXTRACT(DAYOFWEEK FROM ActivityDate) =2 THEN "Monday"
    WHEN EXTRACT(DAYOFWEEK FROM ActivityDate) =3 THEN "Tuesday"
    WHEN EXTRACT(DAYOFWEEK FROM ActivityDate) =4 THEN "Wednesday"
    WHEN EXTRACT(DAYOFWEEK FROM ActivityDate) =5 THEN "Thursday"
    WHEN EXTRACT(DAYOFWEEK FROM ActivityDate) =6 THEN "Friday"
    WHEN EXTRACT(DAYOFWEEK FROM ActivityDate) =7 THEN "Saturday"
    ELSE "Unknown"
    END AS Day_of_Week

FROM `bbfitbit.fitabaseData.DailyActivity`
GROUP BY ActivityDate
ORDER BY ActivityDate