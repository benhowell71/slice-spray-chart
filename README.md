# slice-spray-chart
Code used to create a baseball spray chart that uses slices to divy up the baseball field rather than using the plotted points.

The hardest part of creating these charts is getting the slices assigned for the location of each BBE. Using TrackMan data, one can use the bearing of the batted ball, designated by "Bearing," to do create those slices. Here, I just manaully created the data frame to hold the five slices and a random amount of BBEs per slice for this exercise. Baseball Savant data does not currently provide Bearing as a part of their available data.

However, it is possible to derive Spray Angle from StatCast data based off of work previously done by Jim Albert:
- https://baseballwithr.wordpress.com/2018/01/15/chance-of-hit-as-function-of-launch-angle-exit-velocity-and-spray-angle/
- https://baseballwithr.wordpress.com/2018/01/22/spray-charts-from-statcast-data/

From there, you can divy up the Spray Angle into different slices; I prefer five right now, although the code can be altered to accomodate more slices.

![Image](https://github.com/benhowell71/slice-spray-chart/blob/main/slice_chart.jpeg)
