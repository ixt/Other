synchronized void updateDevices() {
  Iterator<String> it = newDevices.keySet().iterator();
  while (it.hasNext ()) {
    String ip = (String)it.next();
    Device current = (Device)newDevices.get(ip);
    if (current.deathDate < System.currentTimeMillis()) {
      newDevices.remove(ip);
    }
  }
}


synchronized void updateConnections() {
  Iterator<String> it = connections.keySet().iterator();
  while (it.hasNext ()) {
    String label = (String)it.next();
    Connection current = (Connection)connections.get(label);
    //Device sender = newDevices.get(current.sender);
    //Device rec = newDevices.get(current.rec);

    if (current.deathDate < System.currentTimeMillis()) {
      connections.remove(label);
    }
  }
}
