
# WRF Yellow Sea

For this project, we run the wrf real case in a 2-nested domain over the yellow to observe marine fog and do forecasting for the FATIMA project. The FATIMA project essentially is a ship navigating through the yellow sea and collecting meaningful data to study marine fog.

### WRF-ARW Modeling System  ###

We request that all new users of WRF please register. This allows us to better determine how to support and develop the model. Please register using this form:[https://www2.mmm.ucar.edu/wrf/users/download/wrf-regist.php](https://www2.mmm.ucar.edu/wrf/users/download/wrf-regist.php).

For an overview of the WRF modeling system, along with information regarding downloads, user support, documentation, publications, and additional resources, please see the WRF Model Users' Web Site: [https://www2.mmm.ucar.edu/wrf/users/](https://www2.mmm.ucar.edu/wrf/users/).
 
Information regarding WRF Model citations (including a DOI) can be found here: [https://www2.mmm.ucar.edu/wrf/users/citing_wrf.html](https://www2.mmm.ucar.edu/wrf/users/citing_wrf.html).

The WRF Model is open-source code in the public domain, and its use is unrestricted. The name "WRF", however, is a registered trademark of the University Corporation for Atmospheric Research. The WRF public domain notice and related information may be found here: [https://www2.mmm.ucar.edu/wrf/users/public.html](https://www2.mmm.ucar.edu/wrf/users/public.html).



## Documentation

We held daily meetings for the FATIMA project during the month of June and July 2023 at 9 p.m. EST to give a 3-day forecasts for the ship. 

The PowerPoint slides for the daily meetings are given on [here.](http://www.yorku.ca/pat/FATIMA-WRF/Yellow%20Sea%20daily%20forecasts/index.html)

We ran the simulation and then plotted the 2m-relative humidity and the cloud mixing ratio (g/kg) for the Yellow sea and then we also plotted the relative humidity against height to be able to better identify marine fog or low-level clouds. The graphs for relative humidity vs height below are at different platforms in the sea where measurements were being taken and also they were aligned with the path of the ship. 

Below, I have a short gif for a 3-day forecasts on the 5th-7th July where we were able to see a low-pressure system coming from the South and travelling up North of the Yellow sea.  


## Demo

This was the forecast for 5th July 2023. The westerly winds change to southerly winds. Some moisture was present along the coastlines as well around 12:00 UTC.

![](https://github.com/Piyush-T31/WRF_Projects_YellowSea/blob/6fa76b932cc7de44d3581663978368fc5b2b79b5/test/em_real/RHD1.gif)


This was the forecast for 6th July 2023. The southerly winds picks up which brings a band of moisture from the South to the North and around 12:00 UTC we observe a low pressure system coming from the south with wind speeds reaching 25-30 knots during the evening.

![](https://github.com/Piyush-T31/WRF_Projects_YellowSea/blob/b57b7a4b5da60721750cd2df26e8e77e97f9db4b/test/em_real/RHD2.gif)

The final day of the simulation, 7th July 2023. We can see the system moving up North and it weakens with time (wind speeds around 10 knots). We also observe how the wind influences the moisture as it is moving along the system.

![](https://github.com/Piyush-T31/WRF_Projects_YellowSea/blob/b57b7a4b5da60721750cd2df26e8e77e97f9db4b/test/em_real/RHD3.gif)

Below I am showing how relative humidity changes with height for the 3 days at the G-ORS platform which was in the south just above the red dots found in the plots above. This gave us more insight on the height of the moist air and gave us a better idea if fog was present. We can see that on July 5th, it was relatively dry and so no chances of fog occurrence. For July 6th, it was moist and a bit patchy for the first 12 hours. There were chances of precipitation as the relative humidity was high at around 6km and going down. On July 7th, the first few hours, the chances of precipitation persist and it is a bit patchy. Then, due to the low pressure system going North, we can see dryer air in the afternoon till the evening. 

![](https://github.com/Piyush-T31/WRF_Projects_YellowSea/blob/b57b7a4b5da60721750cd2df26e8e77e97f9db4b/test/em_real/RHG-ORS.png)