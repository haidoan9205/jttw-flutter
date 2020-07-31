import 'dart:async';
import 'dart:convert';
// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prm_se130184/model/actor.dart';
import 'package:prm_se130184/model/calamity.dart';
import 'package:prm_se130184/model/equipment.dart';
import 'package:prm_se130184/model/history.dart';
import 'package:prm_se130184/model/user.dart';
// import 'package:prm_se130184/screens/deleteEquipment.dart';

class ProjectApi {
  static final baseUrl = 'https://journeytothewest.azurewebsites.net/api';

  Future<List<Actor>> getActors() async {
    var response =
        await http.get('https://journeytothewest.azurewebsites.net/api/actors');

    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      //debugPrint(response.body);
      List<Actor> actors = data.map((item) => Actor.fromJson(item)).toList();
      return actors;
    } else {
      throw Exception('Failed to get data');
    }
  }

  Future<List<Calamity>> getCalamities() async {
    var response = await http.get('$baseUrl/Calamities');

    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      //debugPrint(response.body);
      List<Calamity> calamity = data.map((e) => Calamity.fromJson(e)).toList();
      return calamity;
    } else {
      throw Exception('Failed to get data');
    }
  }

  Future<List<History>> getHistories() async {
    var response = await http.get('$baseUrl/histories');
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      List<History> history = data.map((e) => History.fromJson(e)).toList();
      return history;
    } else {
      throw Exception('Failed to get data');
    }
  }

  Future<List<Equipment>> getEquipments() async {
    var response = await http.get('$baseUrl/equipments');
    // var response = await http.get('$_baseUrl/equipments');

    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      //debugPrint(response.body);
      List<Equipment> equipment =
          data.map((e) => Equipment.fromJson(e)).toList();
      return equipment;
    } else {
      throw Exception('Failed to get data');
    }
  }

  static Future<Actor> createActor(Actor dto) async {
    final http.Response response =
        await http.post('https://journeytothewest.azurewebsites.net/api/actors',
            headers: <String, String>{
              'Content-type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'actorName': dto.actorName,
              'image': dto.image,
              'description': dto.description,
              'email': dto.email,
              'phone': dto.phone
            }));
    if (response.statusCode == 201 || response.statusCode == 200) {
      return Actor.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Actor');
    }
  }

  static Future<Equipment> createEquipment(Equipment dto) async {
    final http.Response response = await http.post('$baseUrl/equipments',
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'equipmentName': dto.equipmentName,
          'image': dto.image,
          'description': dto.description,
          'quantity': dto.quantity
        }));
    // print(response.body);
    if (response.statusCode == 200) {
      return Equipment.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Equipment');
    }
  }

  static Future<Calamity> createCalamity(Calamity dto) async {
    final http.Response response = await http.post('$baseUrl/calamities',
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'calamityName': dto.calamityName,
          'description': dto.description,
          'location': dto.location,
          'startTime': dto.startTime,
          'endTime': dto.endTime,
          'numberOfFilming': dto.numberOfFilming,
          'roleSpecification': dto.roleSpecification,
          'status': dto.status
        }));
    // print(response.body);
    if (response.statusCode == 201 || response.statusCode == 200) {
      return Calamity.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to create calamity");
    }
  }

  static Future<Actor> deleteActor(int id) async {
    final http.Response response = await http.delete(
      'https://journeytothewest.azurewebsites.net/api/actors/$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      Actor actor = Actor.fromJson(json.decode(response.body));
      return actor;
    } else {
      throw Exception('Failed to delete actor.');
    }
  }

  static Future<Equipment> deleteEquipment(int id) async {
    final http.Response response = await http.delete(
      'https://journeytothewest.azurewebsites.net/api/equipments/$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      Equipment equipment = Equipment.fromJson(json.decode(response.body));
      return equipment;
    } else {
      throw Exception('Failed to delete Equipement.');
    }
  }

  static Future<Calamity> deleteCalamity(int id) async {
    final http.Response response = await http.delete(
      'https://journeytothewest.azurewebsites.net/api/calamities/$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      Calamity calamity = Calamity.fromJson(json.decode(response.body));
      return calamity;
    } else {
      throw Exception('Failed to delete Calamity.');
    }
  }

  static Future<User> login(User dto) async {
    final http.Response response = await http.post(
        'https://journeytothewest.azurewebsites.net/api/user/login',
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, dynamic>{'userId': dto.userId, 'password': dto.password}));
    // print(response.body);
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to Login');
    }
  }

  static Future<Actor> updateActor(Actor dto) async {
    final http.Response response = await http.put('$baseUrl/actors',
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "actorId": dto.actorId,
          "actorName": dto.actorName,
          "image": dto.image,
          "description": dto.description,
          "email": dto.email,
          "phone": dto.phone,
          "isActive": true
        }));
    // print(response.body);
    if (response.statusCode == 200) {
      return Actor.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update');
    }
  }

  static Future<Calamity> updateCalamity(Calamity dto) async {
    final http.Response response = await http.put('$baseUrl/calamities',
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "calamityName": dto.calamityName,
          "description": dto.description,
          "location": dto.location,
          "startTime": dto.startTime,
          "endTime": dto.endTime,
          "numberOfFilming": dto.numberOfFilming,
          "roleSpecification": dto.roleSpecification,
          "isActive": true,
          "actorId": dto.actorId,
          "equipmentId": dto.equipmentId,
        }));
    // print(response.body);
    if (response.statusCode == 200) {
      return Calamity.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update');
    }
  }

  static Future<Equipment> updateEquipment(Equipment dto) async {
    final http.Response response = await http.put('$baseUrl/equipments',
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "equipmentId": dto.equipmentId,
          "equipmentName": dto.equipmentName,
          "quantity": dto.quantity,
          "image": dto.image,
          "description": dto.description,
          "isActive": true
        }));
    // print(response.body);
    if (response.statusCode == 200) {
      return Equipment.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update');
    }
  }

  static Future<Actor> uploadImageActor(Actor dto) async {
    final http.Response response = await http.put('$baseUrl/actors',
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "image": dto.image,
          // "equipmentName": dto.equipmentName,
          // "quantity": dto.quantity,
          // "image": dto.image,
          // "description": dto.description,
          // "isActive": true
        }));
    // print(response.body);
    if (response.statusCode == 200) {
      throw Exception('Update success');
    } else {
      throw Exception('Failed to update');
    }
  }
}
