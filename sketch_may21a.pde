/*******************************************************
Define some variable
********************************************************/
String inputText = "Hello!";
String inputFile = "input/globe.png";
String inputFile2 = "input/globe-overlay.png";
String inputFile3 = "input/globe-underlay.png";

String theFont = "";

// output resolution
int ix = 2560;
int iy = 1600;

//color backgroundColor = color(0, 32, 162);
//color backgroundColor = color(0);
//#286D21
//40, 109, 33
float r = 40;
float g = 109;
float b = 33;
color backgroundColor = color(r+random(20), g+random(20), b+random(20));
color lineColor = color(r+50.0+random(50), g+50.0+random(50), b+50.0+random(50), 20+random(10));

// define padding that dots would not appear in %
float border = 0.07;

ArrayList dots1a = new ArrayList();
ArrayList dots1b = new ArrayList();
ArrayList dots2 = new ArrayList();

/*******************************************************
** Node Class to represent dots
********************************************************/
class Node {
  float x;
  float y;
  float l;
  float s;

  Node (float x, float y, float l) {
    this.x = x;
    this.y = y;
    this.l = l;
    this.s = 3.0 + random(2);
  }

  Node (float x, float y, float l, float s) {
    this.x = x;
    this.y = y;
    this.l = l;
    this.s = s + random(3);
  }

  void drawSelf() {
    fill(255, 255, 255, 255*l );
    noStroke();
    ellipse(this.x, this.y, this.s, this.s);
  }
}

int xy(int x, int y) {
  return x+y*width;
}

/*******************************************************
** Renders
********************************************************/
void addDotToDots1a(int howMany, float theTransparancy, float theSize){
  for (int i = 0; i < howMany; i++) {
    int x, y;
    do {
      x = (int)random(width);
      y = (int)random(height);
    }
    while (pixels[xy (x, y)] == color(255));
    dots1a.add(new Node(x, y, theTransparancy, theSize));
  }
}

void addDotToDots1b(int howMany, float theTransparancy, float theSize){
  for (int i = 0; i < howMany; i++) {
    int x, y;
    do {
      x = (int)random(width);
      y = (int)random(height);
    }
    while (pixels[xy (x, y)] == color(255));
    dots1b.add(new Node(x, y, theTransparancy, theSize));
  }
}

void addDotToDots2(int howMany, float theTransparancy, float theSize){
  for (int i = 0; i < howMany; i++) {
    int x, y;
    do {
      x = (int)random(width-height*border*2)+(int)(height*border);
      y = (int)random(height*(1.0-border*2))+(int)(height*border);
    }
    while (pixels[xy (x, y)] != color(255));
    dots2.add(new Node(x, y, theTransparancy, theSize));
  }
}

void connectDots(int howMany, ArrayList d, ArrayList dd){
   for (int i = 0; i < howMany; i++) {
    int x, y, xx, yy;
    int dSize = d.size()-1;
    int ddSize = dd.size()-1;
    Node n = ((Node)d.get((int)random(dSize)));
    Node nn = ((Node)dd.get((int)random(ddSize)));
    line(n.x, n.y, nn.x, nn.y);
  } 
}

void drawDots(int howMany, ArrayList dots){
  for (int j = 0; j < howMany; j++){
    for (int i = 0; i < dots.size(); i++) {
      ((Node)dots.get(i)).drawSelf();
    }     
  }
}

/*******************************************************
** Main
********************************************************/
void setup() {
  int inputMode = 2;
  // set resolution of the image
  size(ix, iy);
  fill(0);
  background(255); 
  strokeWeight(1);
  stroke(lineColor);

if (inputMode == 0){
        inputText = inputText.toUpperCase();
        PFont font = loadFont("GothamHTF-Bold-48.vlw");
        textFont(font, 400);
        float tx = textWidth(inputText);
        float ty = textAscent();
        println(textAscent());
        println(textDescent());    
        println(ty);
        text(inputText, width/2-tx/2, height/2+ty/2);
        loadPixels();
        background(backgroundColor);
        addDotToDots1a( width*12, 0.5, 0.5 ); // setup uncolored region as sparse, large, transparen 
        addDotToDots2( width/2, 0.3, 5.0 ); // setup uncolored region as sparse, large, transparen 
        connectDots(width*1, dots1a, dots1a); 
        connectDots(width*1, dots1a, dots2);
        drawDots(1, dots1a);
        drawDots(1, dots2);
}else if (inputMode == 1){
        PImage p = loadImage(inputFile);
        image(p, width/2-p.width/2, height/2-p.height/2);
        loadPixels();
            
        background(backgroundColor);
        addDotToDots1a( width*12, 0.5, 0.5 ); // setup uncolored region as sparse, large, transparen 
        addDotToDots2( width/2, 0.3, 5.0 ); // setup uncolored region as sparse, large, transparen 
        connectDots(width*1, dots1a, dots1a); 
        connectDots(width*1, dots1a, dots2);
        drawDots(1, dots1a);
        drawDots(1, dots2);
}else if (inputMode == 2){
        background(255);        
        PImage p = loadImage(inputFile);
        image(p, width/2-p.width/2, height/2-p.height/2);
        loadPixels();
        addDotToDots1a( width*3, 0.3, 0.5 ); // setup colored region as dense, small, opaque

        background(255);        
        PImage p2 = loadImage(inputFile2);
        image(p2, width/2-p2.width/2, height/2-p2.height/2);
        loadPixels();
        addDotToDots1b( width*6, 0.5, 0.5 ); // setup colored region as dense, small, opaque

        background(255);        
        PImage p3 = loadImage(inputFile3);
        image(p3, width/2-p3.width/2, height/2-p3.height/2);
        loadPixels();
        addDotToDots2( width/2, 0.3, 5.0 ); // setup uncolored region as sparse, large, transparen 

        background(backgroundColor);
        connectDots((int)(width*0.5), dots1a, dots1a); 
        connectDots((int)(width*0.5), dots1b, dots1b); 
        connectDots((int)(width*0.5), dots1b, dots2);
        drawDots(1, dots1a);
        drawDots(1, dots1b);
        drawDots(1, dots2);
}
  String savePath = selectOutput();  // Opens file chooser
  if (savePath != null) {
    save(savePath);
  }
}


