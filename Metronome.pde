import ddf.minim.*;

Minim minim;
AudioSample high, low;

PFont f;
int fRate = 60;
int tempo = 120;
int beatsPerBar = 4;
int currentBeat = 0;
int tickSize = (fRate * 60)/tempo;
boolean play = true;

color green = color(142, 255, 199);
color red = color(250, 101, 101);


void setup() {
  size(800, 400, OPENGL);
  background(255);
  f = createFont("Georgia",128);
  frameRate(fRate);
  // Setup the audio player
  minim = new Minim(this);
  high = minim.loadSample("High.aif", 512);
  low = minim.loadSample("Low.aif", 512);
}

void draw() {
  background(255); 
  textSize(64);
  textAlign(CENTER, height/2);
  textFont(f);
  
  if(play) {
    fill(green);
    if(frameCount % tickSize == 0) {
      if(currentBeat % beatsPerBar == 0) {
        high.trigger();
      } else {
        low.trigger();
      }
      currentBeat +=1;  
    }
    tickSize = (fRate * 60)/tempo; 
  } else {
    fill(red);
  }
  text(tempo + " bpm", width/2, height/2);
}

void keyPressed() {
  if(key == CODED) {
      if(keyCode == UP) {
         tempo += 1;
       } else if (keyCode == DOWN) {
           tempo -= 1;
      }
  } else if(key == ' ') {
    play = !play;
    // Ensure we start at zero when we resume
    currentBeat = 0;
  }
}



