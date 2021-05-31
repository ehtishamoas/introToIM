## Random Walkers

#### Description of the assignment and the role of Object Oriented Programming

For this assignment, I have created a random walkers code using the circles. A circle is created at the desired location and then the subsequent circles are created in any direction but only 10 units apart from the previous circle. This gives the walking effect.

This program is created using Object Oriented Programming, so the user is allowed to create as many circles as they want and start them at any location they want by providing the coordinates to the constuctor. I have created 5 circles, 4 of which start at the corners and 1 at the center.

Here is the [link](https://drive.google.com/file/d/171gMOHYZsz195hOGGCe7wdBgZ0l9viOd/view?usp=sharing) to the video which illustrates this artwork.


#### Problem I ran into and How I fixed:

While creating the code, I faced the problem that the circles would leave the canvas and keep walking off screen. First I though of using if conditions to prevent them from leaving the anvas but then I searched online for an efficient way to do this job and discovered the constrain() function, which does the job only in one line. So, I used this function for both x and y coordinates.

#### An interesting thing about my program:

First I decided to give random colors to the subseqent circles in order to make my artwork more appealing. But then after watching the video about perlin noise assigned for today, I decided to use that concept and stick with only one color (pink) where the different shades of that color appeared randomly, but the change was also very smooth due to the use of noise() function.

Note: This assignment was inspired by the following two videos:
[Video 1](https://www.youtube.com/watch?v=rqecAdEGW6I)
[Video 2](https://www.youtube.com/watch?v=8ZEMLCnn8v0)
