bigquery_connect <- dbConnect(bigrquery::bigquery(),
                              project = "bbfitbit",
                              dataset = "fitabaseData")

#List available tables
dbListTables(bigquery_connect)
#Makes me authenticate/log in first
Authentication complete.
[1] "DailyActivity"     "DailySleep"        "HeartRateSeconds"  "HourlyCalories"    "HourlyIntensities" "HourlySteps"       "MinuteCalories"   
[8] "MinuteFBMETs"      "MinuteIntensities" "MinuteSleep"       "MinuteSteps"       "WeightLogs"

##Adding one of my Previously created queries / results to R as dataFrames (Participant Activity Averages)

Query_ParticipantActivityAverages <- odbc::dbSendQuery(
  bigquery_connect,
  "
    SELECT 
      CAST(Id AS STRING) AS Participant_Id, 
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
  "
  )

##Fetch result as DF
Participant_Activity_Averages <- odbc::dbFetch(Query_ParticipantActivityAverages)

##Clearing Query and Disconnecting from BigQuery
rm(Query_ParticipantActivityAverages)
dbDisconnect(bigquery_connect)
rm(bigquery_connect)
##...............................................
##Plot Participant Activity Data

ggplot(Participant_Activity_Averages)+
  geom_smooth(mapping=aes(x=Avg_Daily_Calories, y=Avg_Daily_Distance_km))+
  labs(title="Calories Expended vs. Distance Travelled (km)", 
       subtitle="33 Participants tracked 4/12/16-5/12/16", 
       caption="Data from https://www.kaggle.com/datasets/arashnic/fitbit", 
       x="Average Daily Calories Expended", y="Avg Daily Distance (km)")

ggplot(Participant_Activity_Averages)+
  geom_smooth(mapping=aes(x=Avg_Daily_Calories, y=Avg_Daily_Steps))+
  labs(title="Calories Expended vs. Step Count", 
       subtitle="33 Participants tracked 4/12/16-5/12/16", 
       caption="Data from https://www.kaggle.com/datasets/arashnic/fitbit", 
       x="Average Daily Calories Expended", y="Avg Daily Steps")