import 'dart:convert';
import 'package:http/http.dart' as http;

class OfficessList {
  List<Office> offices;
 OfficessList({required this.offices});

 factory OfficessList.fromJson(Map<String, dynamic> json) {

   var officesJson = json['offices'] as List;
   List<Office> officessList = officesJson.map((i) => Office.fromJson(i)).toList();

   return OfficessList(
     offices: officessList
     );
 }
}

class Office {
final String name;
final String address;
final String image;

Office({required this.name, required this.address, required this.image});

factory Office.fromJson(Map <String, dynamic> json) {
  return Office(
    name: json['name'] as String, 
    address:json['address'] as String, 
    image: json['image'] as String
    );
 }
}

Future<OfficessList> getOfficesList() async {
  const url = 'https://about.google/static/data/locations.json';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200){
    return OfficessList.fromJson(json.decode(response.body));
  }
  else {
    throw Exception ('Error: ${response.statusCode}');
  }

}