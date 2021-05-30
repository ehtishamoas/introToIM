### The Moiré Pattern

The Moiré pattern is a well-known interference pattern in Mathematics and Physics. It is created when two similar but offset templates overlay (inexact superimposition). 

In this assignment, I have created a program which allows user to create different Moiré patterns using two set of verticle lines. Users are allowed to interact with the program using the mouse, with which, they can move and rotate the second set of lines in order to form different interesting patterns.

Here is a [link](https://drive.google.com/file/d/171gMOHYZsz195hOGGCe7wdBgZ0l9viOd/view?usp=sharing) to the video, where I showed how a user can use mouseX and mouseY to create different Moiré patterns.


### Problems faced and solved, and the interesting thing I discovered:

I faced a major problem while trying to figure out how to move the second set of verticle lines across the screen using mouseX, and then how to rotate it using mouseY. With the help I got through web, I discovered the amazing map() function, which allows re-mapping a number from one range to another. So, I couls easily convert the values of mouseX and mouseY into the required ranges, and thus we accurately move and rotate the second set of lines according to the input.



