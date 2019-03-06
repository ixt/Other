public void addDevice(String ip) {
  Device currentDevice = new Device();
  currentDevice.ip = ip;
  currentDevice.deathDate = System.currentTimeMillis() + 1;
  String ip_as_array[] = split(ip, '.');
  currentDevice.local = false;
  for (int seg : localSegments) {
    if ( seg == int(ip_as_array[0]) ) {
      currentDevice.local = true;
    }
  }
  currentDevice.virtual = false;
  for (int seg : virtualSegments) {
    if ( seg == int(ip_as_array[0]) ) {
      currentDevice.virtual = true;
    }
  }
  if (! currentDevice.local && ! currentDevice.virtual) {  
    // NON-LOCAL ADDRESS  
    try {
      InetAddress ipAddress = InetAddress.getByName(ip);

      // Replace "city" with the appropriate method for your database, e.g.,
      // "country".
      CityResponse response = reader.city(ipAddress);
      Country country = response.getCountry();
      City city = response.getCity();

      String iso = country.getIsoCode() == null ? " " : country.getIsoCode();
      String name = country.getName() == null ? " " : ", " + country.getName();
      String cityname = city.getName() == null ? " " : ", " + city.getName();

      String text = iso + name + cityname;

      com.maxmind.geoip2.record.Location location = response.getLocation();
      
      de.fhpotsdam.unfolding.geo.Location locationMap = new de.fhpotsdam.unfolding.geo.Location(location.getLatitude(), location.getLongitude());
      DescMarker marker = new DescMarker(locationMap, text);
      //marker.setId(ip);
      markers.addMarker(marker);
    } 
    catch(IOException ie) {
      ie.printStackTrace();
    } 
    catch(GeoIp2Exception ge) {
      ge.printStackTrace();
    }
  }
  newDevices.put(ip, currentDevice);
}

public void addConnection(String label, String rec, String sen) {
  Connection current = new Connection();
  current.sender = sen;
  current.rec = rec;
  current.deathDate = System.currentTimeMillis() + 100;
  connections.put(label, current);
}

