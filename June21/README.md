### Project Description:

For this assignment, I have created a musical instrument that plays certain notes on the basis of input values from two switches and distace measured by the distance sensor. 

A potentiometer is used as a variable resistor along with the piezo buzzer, so we can change the volume of the sound from the buzzer by using the potentiometer knob (the greater the resistance, the lower the volume).

I have created two arrays, each of seven notes (all majors C,D,E,F,G,A,B). One array contains all the major 5's ( Like C5, D5,.... B5) and the other contains all the major 6's. I have chosen these two because they sounded better, in my opinion, than all the others with the piezo buzzer. Also, the sequence of the notes in the arrays is from high pitch to low, so that the pitch is higher when the object is closer, and lower when the object is far away.

If the red switch is pressed within the distance range (discussed below), the notes from the array with low pitch notes (5's) will be played based on the distance of the distance sensor from any object in front of it. If the green switch is pressed, the notes from the other array (6's) will be played. Each tone is played for 1 second, so it gives a sound effect similar to that of playing a piano key.

The distance range, of the sensor with any object in front of it, in which the instrument plays sounds is 0-15 inches. So, using the map function, I have designed the instrument in a way that each note has a range of two inches. For instance, if the sensor is 0-2 inches apart from any object, 1st note in the array will be played, if 2-4 inches apart, 2nd note will be played, and so on.

### A Picture of Circuit Schematic:
![Schematic](https://github.com/ehtishamoas/introToIM/blob/main/June21/schematic.png)

### A Photograph of the Project:
![Photograph](https://github.com/ehtishamoas/introToIM/blob/main/June21/Photograph.jpg)

### Video:
Here is the [link](https://drive.google.com/file/d/16Qd0PO8WolfDlTqJt4dbbrOZOwP4eOAW/view?usp=sharing) to the video demonstrating the working of the instrument.

