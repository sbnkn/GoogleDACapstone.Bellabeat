--Adding Average sleep data with high-level average activity data for easier comparison, grouped by participant.
--Survey Data DateSpan 4/12/22-5/12/22
-- HA Highly Active, MOD Moderately Active, LA Lightly Active, SED Sedentary

WITH NewDailySleep AS (
    SELECT 
      DISTINCT *,
      SUBSTR(Sleep_Day, 1, 9) AS NewSleepDate,
      CAST(Id AS INT) AS NewId

  FROM `bbfitbit.fitabaseData.DailySleep`
),
ParticipantActivitySummary AS (
  SELECT
    Id, 
    AVG(Calories) AS Avg_Daily_Calories,
    Avg(TotalSteps) AS Avg_Daily_Steps, 
    Avg(TotalDistance) AS Avg_Daily_Distance_km,
    Avg(VeryActiveMinutes) AS Avg_HA_Min,
    Avg(FairlyActiveMinutes) AS Avg_MOD_Min,
    Avg(LightlyActiveMinutes) AS Avg_LA_Min,
    Avg(SedentaryMinutes) AS Avg_SED_Min,    

  FROM `bbfitbit.fitabaseData.DailyActivity`
  GROUP BY Id
  )

SELECT 
  ParticipantActivitySummary.Id,
  Avg(ParticipantActivitySummary.Avg_Daily_Calories) AS avg_daily_calories,
  Avg(ParticipantActivitySummary.Avg_Daily_Steps) AS avg_daily_steps,
  Avg(ParticipantActivitySummary.Avg_Daily_Distance_km) AS avg_daily_distance_km,
  Avg(ParticipantActivitySummary.Avg_HA_Min) AS avg_HA_min,
  Avg(ParticipantActivitySummary.Avg_MOD_Min) AS avg_MOD_min,
  Avg(ParticipantActivitySummary.Avg_LA_Min) AS avg_LA_min,
  Avg(ParticipantActivitySummary.Avg_SED_Min) AS avg_SED_min,
  Avg(NewDailySleep.Total_Time_In_Bed) AS Avg_TotalMin_InBed_min,
  Avg(NewDailySleep.Total_Minutes_Asleep) AS Avg_Min_Asleep,

FROM ParticipantActivitySummary
LEFT JOIN NewDailySleep 
  ON ParticipantActivitySummary.Id=NewDailySleep.NewId
GROUP BY ParticipantActivitySummary.Id
ORDER BY Avg(ParticipantActivitySummary.Avg_HA_Min) DESC