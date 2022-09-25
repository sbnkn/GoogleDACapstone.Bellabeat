--Now I am interested in learning more about the participant population's activity as a whole. Query for summary of data follows.
--Data datespan is 4/12/16-5/12/16 for 33 individuals of unknown demographics

SELECT
  CONCAT(MIN(ActivityDate), " to ", MAX(ActivityDate)) AS Data_DateSpan,
  COUNT(DISTINCT Id) AS Participant_Count,
  Count(*) AS grp_Total_Logs,
  AVG(Calories) AS grp_Avg_Daily_Calories,
  Avg(TotalSteps) AS grp_Avg_Daily_Steps, 
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
  Avg(SedentaryMinutes) AS grp_Avg_SED_Min

FROM `bbfitbit.fitabaseData.DailyActivity`