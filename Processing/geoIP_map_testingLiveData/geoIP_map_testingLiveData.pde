import com.maxmind.geoip2.*;
import com.maxmind.db.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.annotation.*;
import java.io.Closeable;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.InetAddress;
import java.util.Collections;
import java.util.List;

/**
 * On Mac OS X, first open a Terminal and execute this commmand: 
 * sudo chmod 777 /dev/bpf*
 * (This must be done each time you reboot your Mac)
 */

import java.util.Iterator;
import org.rsg.carnivore.*;
import org.rsg.carnivore.net.*;
import org.rsg.lib.Log;

import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.marker.*;
import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.data.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.providers.OpenStreetMap;
import java.util.List;

DatabaseReader reader;
UnfoldingMap map;
MarkerManager markers;
MarkerManager localDevices;

HashMap nodes = new HashMap();
float startDiameter = 100.0;
float shrinkSpeed = 0.97;
int splitter, x, y;
CarnivoreP5 c;
ArrayList<Device> devices;
HashMap newDevices = new HashMap();
HashMap connections = new HashMap();

int[] localSegments = { 
  192, 10
};

int[] virtualSegments = { 
  255, 244, 224, 0, 239
};

public void setup() {
  size(1280, 800, P2D);
  smooth();
  map = new UnfoldingMap(this, new OpenStreetMap.OpenStreetMapProvider());
  markers = new MarkerManager();
  localDevices = new MarkerManager();
  map.addMarkerManager(markers);
  map.addMarkerManager(localDevices);
  MapUtils.createDefaultEventDispatcher(this, map);

  Log.setDebug(true); // Uncomment this for verbose mode
  c = new CarnivoreP5(this);
  //c.setVolumeLimit(4);
  try {
    // A File object pointing to your GeoIP2 or GeoLite2 database
    File database = new File("/opt/db/GeoLite2-city.mmdb");

    // This creates the DatabaseReader object. To improve performance, reuse
    // the object across lookups. The object is thread-safe.
    reader = new DatabaseReader.Builder(database).build();
  } 
  catch(IOException ie) {
    ie.printStackTrace();
  }
}


synchronized void draw() {
  background(255);
  map.draw();
  drawLocalAddresses();
}

synchronized void update() {
  updateDevices();
}

// Called each time a new packet arrives
synchronized void packetEvent(CarnivorePacket packet) {
  println("[PDE] packetEvent: " + packet);
  // Remember these nodes in our hash map
  String sen = packet.senderAddress.toString();
  String rec = packet.receiverAddress.toString();
  //nodes.put(rec, str(startDiameter));
  //nodes.put(sen, str(startDiameter));
  addDevice(rec);
  addDevice(sen);
  addConnection(rec + sen, rec, sen);
}


