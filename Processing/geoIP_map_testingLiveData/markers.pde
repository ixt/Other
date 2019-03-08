public class LocalMarker extends SimplePointMarker {
  String text;
  float actualX;
  float actualY;
  public LocalMarker(String intext, float aX, float aY) {
    text = intext;
    actualX = aX;
    actualY = aY;
  }

  public void draw(PGraphics pg, float x, float y) {
    pg.pushStyle();
    pg.fill(0);
    pg.textSize(12);
    pg.text(text, actualX, actualY);
    pg.popStyle();
  }
}

public class DescMarker extends SimplePointMarker {
  String text;
  public DescMarker(de.fhpotsdam.unfolding.geo.Location location, String intext) {
    super(location);
    text = intext;
  }

  public void draw(PGraphics pg, float x, float y) {
    pg.pushStyle();
    pg.noStroke();
    pg.fill(200, 200, 0, 100);
    pg.ellipse(x, y, 10, 10);
    pg.fill(0);
    if ( mouseX > x-10 && mouseY > y-10 && mouseX < x+10 && mouseY < y+10) {
      pg.text(text, x, y);
    }
    pg.popStyle();
  }
}

