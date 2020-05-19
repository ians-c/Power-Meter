# Power_Meter
A Matlab program that calculates power output of cyclist from a gpx file

# Table of contents
* [Motivation](#Motivation)
* [Methods](#Methods)
* [Results](#Results)
* [Conclusion](#Conclusion)

# Motivation
Power meters are crucial for cycling training. They are used to construst regimented schedules and workouts to optimize athlete improvement. However, being very expensive and difficult to install, many seek alternatives. From only a gpx file, this program attempts to replicate a power meter as accuractely as possible by calculating the instantaneous power output over the course of a ride. 

# Methods
## Equations
The total force exerted by a rider in motion is the sum of the force of gravity _F<sub>g</sub>_, the force needed to accelerate _F<sub>a</sub>_, the force of rolling resistance _F<sub>r</sub>_, and the force of air resistance _F<sub>w</sub>_, divided by the drive-train efficiency η.
<p align="center"> 
<img src="img/Ftot2.gif">
</p>

For each individual force, we can write the follwing equations:
<p align="center"> 
<img src="img/Forces.gif">
</p>

Where Φ is the angle of incline, _C<sub>rr</sub>_ is the rolling coefficient, _C<sub>d</sub>_ is the drag coefficient, and ρ is air density. 

Thus we can write the power output of the rider as:
<p align="center"> 
<img src="img/Power2.gif">
</p>

## Derivation of Variables

- Wind magnitude and direction are extracted from nearby weather stations using Meteostat API. 
- The rolling coefficient _C<sub>rr</sub>_ is dependent on the width and quality of tires. The default is 0.004, the typical value for a standard road bike. 
- The drag coefficient _C<sub>d</sub>_, by default is 0.4, but can be adjusted to accomodate group rides or variations in clothing.
- The expose area A, by default is 0.7 m<sub>2</sub>, but can be adjusted to accomodate rider height or different riding positions. 
- The drive-train efficiency η, by default is .95, but can be adjusted to accomodate bicycle type and wear.
- "Instantaneous" velocity, acceleration, and slope of incline are calculated from longitude, latitude, and elevation within the gpx file.
- Mass of rider and bike are taken as inputs. 

# Results
To test the accuracy of this model, the calculated output power was compared to power meter data in three different rides.
## Test 1
<p align="center"> 
<img src="img/Test_1.png">
</p>

Calculated Average Power = 198 W<br/>
Actual Average Power = 212 W<br/>
Difference: 6.8%<br/>

## Test 2
<p align="center"> 
<img src="img/Test_2.png">
</p>

Calculated Average Power = 221 W<br/>
Actual Average Power = 248 W<br/>
Difference: 7.9%<br/>


## Test 3
<p align="center"> 
<img src="img/Test2_3.png">
</p>

Calculated Average Power = 186 W<br/>
Actual Average Power = 201 W<br/>
Difference: 5.6%<br/>

## Conclusion
This model proves to be an excellent substitute for a power meter. While it is unable detect short spikes in power, it can calculate average power within 8% of the true value. Offering a diligent consideration of wind resistance and a vast adaptability, this model is also proves more accurate than other gpx-based power meters (eg. Strava). Future projects could involve the incorporation of personalized FTP and power zones to enable a more advanced training companion. 

# License
This project is licensed under the MIT License




