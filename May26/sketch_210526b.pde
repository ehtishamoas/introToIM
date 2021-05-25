size(400, 400);

//body:
noStroke();
fill(0,200,100);
rect(185,150,30,65);

//head:
noStroke();
fill(236, 188, 180);
ellipse(200, 140, 50, 50);

//left eye:
stroke(100);
fill(255);
ellipse(190,135,15,10);
noStroke();
fill(0);
ellipse(190,135,5,5);

//right eye:
stroke(100);
fill(255);
ellipse(210,135,15,10);
noStroke();
fill(0);
ellipse(210,135,5,5);

//nose:
fill(197, 140, 133);
triangle(200,142,196, 149, 204, 149);

//mouth:
fill(255,0,0);
arc(200, 154, 15, 10, 0, radians(180));

//right arm:
stroke(0,200,100);
line(215,170,240,200);
noStroke();
fill(236, 188, 180);
ellipse(240,200,15,15);

//left arm:
stroke(0,200,100);
line(185,170,160,200);
noStroke();
fill(236, 188, 180);
ellipse(160,200,15,15);

//right leg:
stroke(0,0,255);
line(210,215,230,270);
noStroke();
fill(236, 188, 180);
ellipse(230,270,20,20);

//left leg:
stroke(0,0,255);
line(190,215,170,270);
noStroke();
fill(236, 188, 180);
ellipse(170,270,20,20);

//Hair:
stroke(0);
line(180,125,170,100);
line(190,116,182,95);
line(200,115,195,95);
line(210,116,205,95);
