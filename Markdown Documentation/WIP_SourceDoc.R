##These are the packages I anticipate I may need as I complete this analysis in RStudio.
##Initial analysis on some files was completed in SQL with BigQuery and in Tableau; here I will analyze additional files.
##I may also pull in my previous queries from BigQuery in order to make tibbles out of the results.

library(janitor)
library(rmarkdown)
library(scales)
library(tidyr)
library(odbc)
library(DBI)
library(skimr)
library(bigrquery)

##Starting with loading the 3 files I think I will analyze:

OG_MinuteIntensities <- read_csv("minuteIntensitiesNarrow_merged.csv")
OG_HeartRate <- read_csv("heartrate_seconds_merged.csv")
OG_WeightLog <- read_csv("weightLogInfo_merged.csv")

##Now I will check each file for duplicate rows

nrow(OG_MinuteIntensities)
nrow(unique(OG_MinuteIntensities))
nrow(OG_HeartRate)
nrow(unique(OG_HeartRate))
nrow(OG_WeightLog)
nrow(unique(OG_WeightLog))

##Confirmed no duplicated rows in the datasets. Will now review columns and basic schema info.

skim(OG_MinuteIntensities)
skim(OG_HeartRate)
skim(OG_WeightLog)
glimpse(OG_MinuteIntensities)
glimpse(OG_HeartRate)
glimpse(OG_WeightLog)

#Initial Insights:
##ID data type is matching (dbl) in all 3 files, so that is good. 
##Date/Timestamps are being read as Strings - I want to change it into a DATE TIME format, will need to remove AM/PM? (all 3 files)
##Intensity is coded, according to spec doc (https://www.fitabase.com/media/1930/fitabasedatadictionary102320.pdf), scale is as follows: 0=Sedentary, 1 Light, 2=Moderate, 3=VeryActive
##Consider replacing intensity values with the coded value? Or, keep in numerical format so it can be analyzed as such?
##Header for HR "Value" should be renamed to "Heartrate"

##Bringing up listing of column names for each file so I can reference them as I clean
colnames(OG_HeartRate)
colnames(OG_MinuteIntensities)
colnames(OG_WeightLog)

Heartrate_v1 <- OG_HeartRate %>% 
  rename(Participant_Id=Id) %>% 
  rename(Heart_Rate=Value) %>% 
  mutate(Date_Isolated=substr(Time, 1, 9)) %>% 
  mutate(Time_Isolated=substr(Time, 11, 20)) %>% 
  mutate(Date_Time=mdy_hms(Time)) %>% 
  rename(OldTime=Time)
View(Heartrate_v1)

##will keep Heartrate_v1 version saved in environment with the date and time isolated in separate columns just in case I need those fields at any point, I can easily grab them

##Cleaned Version most likely to be used - just has the DATETIME without the isolates.  
Heartrate_Cleaned <- Heartrate_v1 %>%
  select(Participant_Id, Date_Time, Heart_Rate) %>% 
  arrange(Participant_Id, Date_Time)  



##Cleaning Intensities using similar methods.
Intensities_v1 <- OG_MinuteIntensities %>% 
  rename(Participant_Id=Id) %>%
  rename(Intensity_Level_Code=Intensity) %>% 
  mutate(Date_Isolated=substr(ActivityMinute, 1, 9)) %>% 
  mutate(Time_Isolated=substr(ActivityMinute, 11, 20)) %>% 
  mutate(Date_Time=mdy_hms(ActivityMinute)) %>% 
  mutate(
    Intensity_Level=case_when(
      Intensity_Level_Code == "0" ~ "Sedentary",
      Intensity_Level_Code == "1" ~ "Light",
      Intensity_Level_Code == "2" ~ "Moderate",
      Intensity_Level_Code == "3" ~ "Very Active"
    ))
View(Intensities_v1)

##will keep Intensities_v1 version saved in environment with date and time isolated in case it is needed in future. Creating final Cleaned version to work with:

ActivityIntensities_Cleaned <- Intensities_v1 %>% 
  select(Participant_Id, Date_Time, Intensity_Level, Intensity_Level_Code) %>% 
  arrange(Participant_Id, Date_Time)

View(ActivityIntensities_Cleaned)


##I was interested to see heart rate mapped alongside activity intensity for users 
##I hypothesize heart rate should increase as intensity increases but will be interesting if sedentary or light heart rate spikes are seen much - could indicate stress.
##Merging the datasets:

ActivityxHeartRate_Merged <- merge(ActivityIntensities_Cleaned, Heartrate_Cleaned, by=c("Participant_Id", "Date_Time"))
View(ActivityxHeartRate_Merged)

##This next plot shows that Sedentary Activity seems to be weighted to lower HR (as expected), 
##then as HR increases, the intensity gradually transitions to majority Moderate or light, 
##then mostly Very Active at highest HR.
##However, can clearly see there are instances where sedentary, light, moderate are appearing at higher HR - worth investigating further, 
## calculate occurrence of HR over average during Sed or Light activity -> poss. marketing stress relief in subscription product.

n_distinct(ActivityxHeartRate_Merged$Participant_Id)
[1] 14

ggplot(data = ActivityxHeartRate_Merged)+
  geom_point(mapping = aes(x = Date_Time, y = Heart_Rate, color = Intensity_Level))+
  labs(title="Activity Intensity and Heart Rate",
       subtitle="Participants tracked 4/12/16-5/12/16",
       caption = "Data from https://www.kaggle.com/datasets/arashnic/fitbit",
       x="Date", y="Heart Rate")
  

##Now I want to dive deeper into the HRxActivity data to see if I can identify the percentage of high HR in sedentary activity. 
##According to Mayo Clinic, normal resting HR range for adults is between 60-100 bpm.(NOTE:I am making assumption survey participants were adults)
##Since I don't have access to demographic info like ages, I can't calculate or identify normal ranges for any level of activity, even light.
##So, I will only look at Sedentary status with > 100 HR


High_HR_while_Sedentary <- subset(ActivityxHeartRate_Merged, Heart_Rate > 100 & Intensity_Level_Code < 1)
nrow(High_HR_while_Sedentary)
nrow(subset(ActivityxHeartRate_Merged, Heart_Rate > 100))
935 / 14573
nrow(subset(ActivityxHeartRate_Merged, Heart_Rate > 100 & Intensity_Level_Code < 2))
HR_Over_100 <- subset(ActivityxHeartRate_Merged, Heart_Rate > 100)


##The above determined that there were 935 instances of HR>100 during Sedentary Activity levels, and 14573 total instances of HR >100. 
##So, about 6.42% of the time an individual's HR was >100, they were sedentary - this isn't a huge occurrence, but may be worth looking at this population for marketing opps

ggplot(data = High_HR_while_Sedentary)+
  geom_point(mapping=aes(x=Date_Time, y=Heart_Rate), color="purple")+
  labs(title="Occurrances of High Heart Rate during Sedentary Activity",
       subtitle="Participants tracked 4/12/16-5/12/16",
       caption = "Data from https://www.kaggle.com/datasets/arashnic/fitbit",
       x="Date", y="Heart Rate")

###The above chart zooms in on the >100 HR occurrences during times where the individual was sedentary

##Now to review and clean weight data. Since the data spans only a month, I don't think there is enough time for meaningful weight change vs activity analysis.
##Instead, I will focus analysis on frequency of weight logs and how often individuals are logging weight manually vs automatically with a connected smart device.

WeightLog_v1 <- OG_WeightLog %>% 
  rename(Participant_Id=Id) %>%
  mutate(Date_Isolated=substr(Date, 1, 9)) %>% 
  mutate(Time_Isolated=substr(Date, 11, 20)) %>% 
  mutate(Date_Time=mdy_hms(Date)) %>% 
  rename(Weight_Lbs=WeightPounds) %>% 
  rename(Weight_Kg=WeightKg) %>% 
  rename(BodyFat_Percentage=Fat) %>% 
  rename(Is_Manual_Report=IsManualReport) %>% 
  rename(Log_Id=LogId)
View(WeightLog_v1)

WeightLog_Cleaned <- WeightLog_v1 %>% 
  select(Participant_Id, Date_Isolated, Date_Time, Is_Manual_Report, Weight_Lbs, BMI, Log_Id) %>% 
  arrange(Participant_Id, Date_Time)

## WL_Enries_Per_Date <- WeightLog_Cleaned %>% 
##  group_by(Date_Isolated) %>% 
##  nrow(Date_Isolated)
## Entries_By_Date_WL <- WL_Enries_Per_Date %>% 
##  rename(Num_Entries=n)
## rm(WL_Enries_Per_Date)

Entries_By_Date_WL <- WeightLog_Cleaned %>% 
  group_by(Date_Isolated) %>% 
  summarize(Num_Entries=n())

WeightLog_Cleaned %>% 
  summarize(Start_Date=min(Date_Isolated), End_Date=max(Date_Isolated), Num_Participants=n_distinct(Participant_Id), Total_Entries=nrow(WeightLog_Cleaned))

> 67/31
[1] 2.16129
> 67/8
[1] 8.375
> 31/8.375
[1] 3.701493

##67 total entries over 31 days (last entry made a few days before survey span ended though the final days were still applicable to datespan) - group avgd 2.16 entries/day; 
##8 unique participants; avg 8.375 total logs per participant, avg 3.7 days per participant log

ggplot(WeightLog_Cleaned)+
  geom_bar(mapping=aes(x=Is_Manual_Report, fill=Is_Manual_Report), show.legend = FALSE)+
  scale_x_discrete(labels = c("FALSE" = "Automatic/Synced", "TRUE" = "Manually Entered"))+
  labs(title="WeightLogs Data Entry Method", 
       subtitle="Sample of 8 Participants between 4/12/16-5/12/16", 
       caption="Data from https://www.kaggle.com/datasets/arashnic/fitbit", 
       x="Entry Method", y="Number of Entries")

##This graphic shows that entries were made manually >40 times, and were automatically synced <30 times. So, it suggests that manual entry is more frequent
##However, due to limitations of this data set (low number  of participants and undetermined relevance to our target demographic), further surveys would be recommended to confirm this trend as well as search for causes.
