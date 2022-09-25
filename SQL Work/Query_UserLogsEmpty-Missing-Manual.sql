--I have noticed there are some entries with 0's across the board in daily activities. 
--There are also instances where there are no records logging a certain day for individuals.
--The Fitabase website noted data limitations where data entries would not be logged if the user did not log into the app and sync data frequently enough, or if the battery were too low. 
--I think this data could provide insight into how often users are unable to obtain value from these devices 
--(whether due to limitations in device such as memory/ battery life, or due to lifestyle such as neglecting to wear device; 
--However, further data would be needed to determine cause and actionable insights)
--Also interested in determining how often a user will add manual entries as this could provide insight how importan the ability to add manual logs is to individuals.


SELECT
  Id AS Participant_ID,
  Count(*) AS Total_Logs,
  COUNTIF(TotalSteps=0 AND TotalDistance=0) AS Empty_Logs,
  (COUNTIF(TotalSteps=0 AND TotalDistance=0) / Count(*)) * 100 AS Percentage_EmptyLogs,
  (31 - COUNTIF(Id=Id)) AS Missing_Logs,
  ((31 - COUNTIF(Id=Id)) / 31) * 100 AS Percentage_MissingLogs,
  COUNTIF(LoggedActivitiesDistance != 0) AS Manual_Logs,
  (COUNTIF(LoggedActivitiesDistance != 0) / Count(*)) * 100 AS Percentage_ManualEntry,

FROM `bbfitbit.fitabaseData.DailyActivity` 
GROUP BY
  Id