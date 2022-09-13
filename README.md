# GoogleDACapstone.Bellabeat
This is a documentation of my Capstone Project for the Google Data Analytics Certificate Course on Coursera.  Portions of this project were completed in SQL via BigQuery, R via RStudio, and Tableau via Tabeleau Public. 

# Scenario Summary: 
You are working on the marketing analyst team at Bellabeat, a high-tech manufacturer of health-focused products for women. Bellabeat is a successful small company, but they have the potential to become a larger player in the global smart device market. Urška Sršen, cofounder and Chief Creative Officer of Bellabeat, believes that analyzing smart device fitness data could help unlock new growth opportunities for the company. She has asked the marketing analytics team to focus on a Bellabeat product and analyze smart device usage data in order to gain insight into how people are already using their smart devices. Then, using this information, she would like high-level recommendations for how these trends can inform Bellabeat marketing strategy


## Business Task Statement: 
Determine Growth opportunities uncovered by smart device usage trends and how Bellabeat can leverage these insights in marketing strategy

## Final Insights and Recommendations
Can be found in this [Tableau Viz](https://public.tableau.com/app/profile/samantha8455/viz/BBFitBit_Data/InsightsandRecs#2). They will also be summarized below:

1. Most users' activity levels hovered right around the threshold to where increased activity more strongly correlated with higher calorie expenditure. 
* Bellabeat can utilize this insight to emphasize personalized fitness plans and coaching in the app and membership program, coupled with tracking and immediate insights in the app in marketing messaging. The app and coaching program can offer the extra push individuals need to move past these activity level thresholds.

2. Every participant experienced abnormally high resting heart rates at some point in the study period. Overall, 6.4% of the time a heart rate was detected to be exceeding 100 bpm, the user was in a period of sedentary activity. More research will be needed to determine true causes, however stress is a common cause of high resting heart rates. 
* Marketing can utilize this insight to emphasize the mindfulness and stress management features available in app and in the coaching program in messaging.

3. Roughly 20% of daily activity data involved some sort of empty, missing, or manually entered logs; and over half of the weight log data was manually entered. In an age where convenience is key (especially with smart devices), decreasing manual work on the user's behalf will go far. According to the Fitabase site, some potential limitations in the devices used for this study, which could lead to data being missed or manual entry, were going too long without syncing device to app (device memory) and going too long between charges (battery life). Additionally, manual entry can be caused by using smart devices which don't integrate together. 
* These insights should drive marketing messaging to emphasize connectivity and focus on the seamless experience between Bellabeat product offering and app, as well as to highlight integrations with third party smart devices. Finally, marketing messaging should emphasize battery life, particularly of the Time product as it can last much longer between charges compared to other popular devices.

4. Saturdays and Tuesdays tended to have the highest levels of activity, whereas Thursday and Sunday generally showed lower levels of activity. Overall, we tend to see peaks in activity around 12-2pm and again around 5-8pm daily.  Dips in activity tend to show up between 3-4pm and 8-10pm daily overall.  On the weekends, Saturday activity peaks around mid-day (1pm), and Sunday activity is typically lowest 11am-1pm or around 4pm.
* Marketing efforts during higher levels of activity should be focused on methods that complement on-the-go activities, such as Podcast or Radio advertisements.
* Marketing efforts during lower levels of activity should be focused on methods that complement periods of rest, such as Online, Youtube, and TV Advertisements.

Note: All insights obtained from this data and analysis should be taken generally, and should be further validated with additional surveys and testing. Please see Data Relevance and Reliability section below for more information. 



## Data Sources

* Primary Data Source is from [Mobius' FitBit Dataset on Kaggle](https://www.kaggle.com/datasets/arashnic/fitbit), as directed by Coursera Project Instructions.

* The [Fitabase website](https://www.fitabase.com/resources/knowledge-base/learn-about-fitbit-data) was also used as a resource: 
  * [Spec Document](https://www.fitabase.com/media/1930/fitabasedatadictionary102320.pdf) was used to discover meanings for some of the data fields, as metadata within the files and datasets themselves were lacking
  * [FitBit Integrity Page](https://www.fitabase.com/resources/knowledge-base/learn-about-fitbit-data/data-availability-integrity/) was used to learn about potential limitations in the dataset.

## Data Relevance and Reliability
Upon reviewing the data and resources about the data, a number of concerns came to mind:

* There is no demographic data - Bellabeat is focused on creating products for women.  So, it would make most sense to analyze data from women participants - however, I cannot tell how many, if any, of the participants in this dataset were women.

* Overall sample size: Based on the number of "Devices Synced" (1.2 million) on [Bellabeat's website](https://bellabeat.com/about/), the sample size of this survey (30-33 participants total, though this is lower for certain statistics that not everyone provided data for) is not representative of the potential population of Bellabeat clients and we will be unable to rely on analysis from this data in high confidence. 

*  Outdated Data: This data is from 2016, and it is now 2022 - much has changed in the world of technology and smart devices in this time.

* Inconsistent Data Summary: The Kaggle source for the data set states there are 30 participants and data should span between 3/12/16-5/12/16. However, when the data was downloaded, I learned the true number of unique participants (Determined by Participant ID) was 33, and the true date span contained in the dataset was 4/12/16-5/12/16. This provokes even more concern regarding the reliability of this data.

Thus, my recommendations will be focused around where to focus further research efforts and general areas to look at for marketing.  All insights obtained from this data and analysis should be taken generally, and should be further validated with additional surveys and testing.

<div class='tableauPlaceholder' id='viz1663040002904' style='position: relative'><noscript><a href='#'><img alt=' ' src='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;BB&#47;BBFitBit_Data&#47;InsightsandRecs&#47;1_rss.png' style='border: none' /></a></noscript><object class='tableauViz'  style='display:none;'><param name='host_url' value='https%3A%2F%2Fpublic.tableau.com%2F' /> <param name='embed_code_version' value='3' /> <param name='path' value='views&#47;BBFitBit_Data&#47;InsightsandRecs?:language=en-US&amp;:embed=true' /> <param name='toolbar' value='yes' /><param name='static_image' value='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;BB&#47;BBFitBit_Data&#47;InsightsandRecs&#47;1.png' /> <param name='animate_transition' value='yes' /><param name='display_static_image' value='yes' /><param name='display_spinner' value='yes' /><param name='display_overlay' value='yes' /><param name='display_count' value='yes' /><param name='language' value='en-US' /></object></div>                <script type='text/javascript'>                    var divElement = document.getElementById('viz1663040002904');                    var vizElement = divElement.getElementsByTagName('object')[0];                    vizElement.style.width='1016px';vizElement.style.height='991px';                    var scriptElement = document.createElement('script');                    scriptElement.src = 'https://public.tableau.com/javascripts/api/viz_v1.js';                    vizElement.parentNode.insertBefore(scriptElement, vizElement);                </script>
