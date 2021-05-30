### The Moiré Pattern

The Moiré pattern is well known in Mathematics and Physics. It is an interference pattern ceated when two similar but offset templates overlay (inexact superimposition). 

In this assignment, I have created a program which allows user to create different Moiré patterns using two set of verticle lines. Users are allowed to interact with the program using the mouse, with which, they can move and rotate the second set of lines in order to form different interesting patterns.

Hese is a [link](https://drive.google.com/file/d/171gMOHYZsz195hOGGCe7wdBgZ0l9viOd/view?usp=sharing) to the video, where I showed how a user can use mouseX and mouseY to create different Moiré patterns.


### Problems faced and solved, and the interesting thing I discovered:

I faced a major problem while trying to figure out how to move the second set of verticle lines across the screen using mouseX, and then how to rotate it using mouseY. With the help I got through web, I discovered the amazing map function. 

I had first created the for loop with starting x as 0 going all the way till the width. But while giving the parameters to the map function for getting the value of 'pos2', I felt the need of having a connection with how I built the lines. So, in the for loop, I set the initial value of x as -width/2, and final as width/2, used the translate function to put the lines onto the center of the screen, and finally, gave the first start stop points parameters to the map() function as 0 and the width, and the second as -width/2 and width/2. Doing this also helped me figure out the required parameters to the map function for 'rotaionAngle' value.



