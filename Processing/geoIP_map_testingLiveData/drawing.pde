synchronized void drawLocalAddresses() {
  pushStyle();
  rect(0, 0, 200, 800);
  int textPlacementY = 10; 

  Iterator<String> it = newDevices.keySet().iterator();
  while (it.hasNext ()) {
    String ip = (String)it.next();
    Device current = (Device)newDevices.get(ip);
    if (current.local) {
      textPlacementY += 16;
      current.x = 10;
      current.y = textPlacementY;
      fill(0);
      textSize(12);
      text(ip, current.x, current.y);
      //LocalMarker currentMarker = new LocalMarker(ip, current.x, current.y);
      //localDevices.addMarker(currentMarker);
    }  
    newDevices.put(ip, current);
  }
  popStyle();
}


synchronized void drawConnections() {
  //
}


//synchronized void drawNodes() {
//  Iterator it = nodes.keySet().iterator();
//  while (it.hasNext ()) {
//    String ip = (String)it.next();
//    String ip_as_array[] = split(ip, '.');
//    boolean isLocal = false;
//    for (int seg : localSegments) {
//      if ( seg == int(ip_as_array[0]) ) {
//        isLocal = true;
//      }
//    }
//    if (!isLocal) {
//      doIP(ip);
//    }
//  }
//}
