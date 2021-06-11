## Penguin Rush

### Game Description:
Penguine Rush would be a 2D platform game where a player character (a penguin) can be controlled using arrow keys. The player's target would be to move around the map and collect fishes while avoiding the seals and traps. This idea is inspired by the summer heat these days, and of course my love for the penguins.

### Progress:

#### June 8, 2021: 
I have gathered all the assets required for the game like penguin sprites, platform images, background images, and sounds etc.  
Here is a screenshot of few image assets I have collected for the game:  
![assests_screenshot](https://github.com/ehtishamoas/introToIM/blob/main/midtermProject/assets_screenshot.png)  

I have also started working on the initial structure of the code.

#### June 9, 2021:
I have created gameCharacters class where I included all the important attributes and methods like gravity, update, and display. Then, I created two subclasses one for enemies (seals) and one for the player character (penguin) and inherited both of these classes from the gameCharacters class. I have also created a platform class which will be used to create blocks where the penguin would be able to stand and move by jumping on it.

My next goal is to create the 'game' class where I will create ArrayLists of enemies and platforms and will decide on gameover and restart etc.  

#### June 10, 2021:
I randomly selected the y coordinates from lower part of the canvas (600) for ground, where all the seals and player will move. Then, I created game class where I initiated instances of Penguin class (to display a penguin which is controlled by user) and Seal class (I created 2 seals using an array which appear at a random x direction on canvas).  

I have also roughly figured out math to detect collision between penguin and any seal, and when detected, the screen fills with white color with a text "game over" in the middle of the canvas. Then, when the user clicks anywhere on the screen, the game restarts.

Here is the [link](https://drive.google.com/file/d/1xW_otxVhifuPz0dJM12wCh62Gi3rXxcd/view?usp=sharing) to the video of gameplay.

Here is the code for my game class:

```
class Game {
  int w, h;
  float g, x_shift;
  Penguin penguin;
  ArrayList<Seal> seal = new ArrayList<Seal>();

  Game(int _w, int _h, float _g) { //g is the ground height. It is chosen as 600 right now.
    w = _w;
    h = _h;
    g = _g;
    
    penguin = new Penguin(100, 100, 35, g, "penguin.png", 57, 65, 4); // 11 is number of sprites in an image
    
    for (int i = 0; i<2; i++) {
      seal.add(new Seal(random(200, 1100), 100, 35, g, "seal.png", 203, 80, 3, 200, 1100));
    }
  }

  void  display() {
    if (penguin.alive == false) {
      fill(0);
      textMode(CENTER);
      textSize(40);
      text("Game over", width/2, height/2);
      return;
    }

    for (int i = 0; i < game.seal.size(); i++) {
      game.seal.get(i).display();
    }
    penguin.display();
  }
}
```

#### June 11, 2021:
I have created an ArrayList of PImage objects in Game class, and added all the background layers in the list using for loop. I also created a functionality where the background layers scroll at a different speed when the player moves to the right or left.  

I have also created a Platform class which allows the player to jump onto a platform.

Here is the [link](https://drive.google.com/file/d/1uUqRb82YS-rx_NIwLMy65pXgnoKvLM4U/view?usp=sharing) to the video of the gameplay.
