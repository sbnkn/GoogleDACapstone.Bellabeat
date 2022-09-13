--Removes duplicated rows, changes date to remove timestamp and AM/PM indication, changes ID data type from STRING to INT so it can be compared with DailyActivity Data

WITH NewDailySleep AS (
  SELECT 
    DISTINCT *,
    SUBSTR(Sleep_Day, 1, 9) AS NewSleepDate,
    CAST(Id AS INT) AS NewId

FROM `bbfitbit.fitabaseData.DailySleep`)

SELECT 
  NewDailySleep.NewId,
  NewDailySleep.NewSleepDate,
  NewDailySleep.Total_Minutes_Asleep,
  NewDailySleep.Total_Time_In_Bed
FROM NewDailySleep
ORDER BY
  NewDailySleep.NewId, NewDailySleep.NewSleepDate
