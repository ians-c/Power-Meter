# Power_Meter
A Matlab program that calculates power output of cyclist from a gpx file

# Motivation
Power meters are crucial for cycling training. They are used to construst regimented schedules and workouts to optimize athlete improvement. However, being very expensive and difficult to install, many seek alternatives. From only a gpx file, this program attempts to replicate a power meter as accuractely as possible by calculating the instantaneous power output over the course of a ride. 

# Methods
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


# Results
To test the accuracy of this model, the calculated output power was compared to power meter data in three different rides.
## Test 1
<p align="center"> 
<img src="img/Test_1.png">
</p>

Calculated Average Power = 185 W
Actual Average Power = 212 W
Difference: 14%

## Test 2
<p align="center"> 
<img src="img/Test_2.png">
</p>

Calculated Average Power = 221 W
Actual Average Power = 248 W
Difference: 11%


## Test 3
<p align="center"> 
<img src="img/Test2_3.png">
</p>

Calculated Average Power = 180 W
Actual Average Power = 201 W
Difference: 11%

