
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class Locations {
  List<Offices> offices;
  List<Regions> regions;

  Locations({this.offices, this.regions});

  Locations.fromJson(Map<String, dynamic> json) {
    if (json['offices'] != null) {
      offices = new List<Offices>();
      json['offices'].forEach((v) {
        offices.add(new Offices.fromJson(v));
      });
    }
    if (json['regions'] != null) {
      regions = new List<Regions>();
      json['regions'].forEach((v) {
        regions.add(new Regions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.offices != null) {
      data['offices'] = this.offices.map((v) => v.toJson()).toList();
    }
    if (this.regions != null) {
      data['regions'] = this.regions.map((v) => v.toJson()).toList();
    }
    return data;
  }


}

Future<Locations> getGoogleOffices() async {
  const googleLocationsURL = 'https://about.google/static/data/locations.json';
  // Retrieve the locations of Google offices
  final response = await http.get(googleLocationsURL);
  if (response.statusCode == 200) {
   return Locations.fromJson(json.decode(response.body));
  } else {
    throw HttpException(
        'Unexpected status code ${response.statusCode}:'
        ' ${response.reasonPhrase}',
        uri: Uri.parse(googleLocationsURL));
  }
}
class Offices {
  String address;
  String id;
  String image;
  double lat;
  double lng;
  String name;
  String phone;
  String region;

  Offices(
      {this.address,
      this.id,
      this.image,
      this.lat,
      this.lng,
      this.name,
      this.phone,
      this.region});

  Offices.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    id = json['id'];
    image = json['image'];
    lat = json['lat'];
    lng = json['lng'];
    name = json['name'];
    phone = json['phone'];
    region = json['region'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['id'] = this.id;
    data['image'] = this.image;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['region'] = this.region;
    return data;
  }
}

class Regions {
  Coords coords;
  String id;
  String name;
  double zoom;

  Regions({this.coords, this.id, this.name, this.zoom});

  Regions.fromJson(Map<String, dynamic> json) {
    coords =
        json['coords'] != null ? new Coords.fromJson(json['coords']) : null;
    id = json['id'];
    name = json['name'];
    zoom = json['zoom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.coords != null) {
      data['coords'] = this.coords.toJson();
    }
    data['id'] = this.id;
    data['name'] = this.name;
    data['zoom'] = this.zoom;
    return data;
  }
}

class Coords {
  double lat;
  double lng;

  Coords({this.lat, this.lng});

  Coords.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}