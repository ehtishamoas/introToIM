### Description of the project:
The idea behind this project is to turn on or increase the value of LED when the light incident on the LDR becomes less. The switch is used to decide whether an LED simply turns on if light sensor value is below a certain value (like in the case of autonomous street lights), or increase the brightness of an LED when the light sensor value decreases and vice versa.  

The circuit varies the brightness of the red LED based on value from light sensor (the lower the value, the greater the brightness) when the switch is off, and turns on the green LED light if the light sensor value is below a certain value when the switch is on. While the switch is off, the green LED remains off, and while the switch is on, the red LED remains off.


#### Here is a picture of circuit schematic:
![Schematic](https://github.com/ehtishamoas/introToIM/blob/main/June17/schematic.png)

#### Here is a photograph of the project:
![Photograph](https://github.com/ehtishamoas/introToIM/blob/main/June17/Photograph.jpg)

#### Problem faced:
For the red LED brightness, I used the map function for the brightness variable, mapping the sensor value (0-1023) to (255-0) so that the value of brightness would change with an inverse proportion to the sensor values. But the brightness change with change in the light on LDR was not much visible. Using the print statements, I realized that the values of brightness differ from 100 to 175 (from turning on the lights in my room to turning them off) only, rather than 0 to 255.

#### The solution:
I set constraints on brightness values as 100 and 175,and then maped the values to 255-0 to make the brightness change effect will be more noticeable.

Here is the [link](https://drive.google.com/file/d/1yb4z0XUt7pVU0t-czz_2PGnSJTY5rHln/view?usp=sharing) to the video of the project.
