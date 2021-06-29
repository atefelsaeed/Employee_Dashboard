import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Employee {
  final String id;
  final String name;
  final String position;
  final String age;
  final String birthDate;

  Employee({
    required this.id,
    required this.name,
    required this.position,
    required this.age,
    required this.birthDate,
  });
}

class Employees with ChangeNotifier {
  List<Employee> employeesList = [];

  Future<void> featchData() async {
    var url = Uri.parse(
        'https://employee-dashboard-4dc98-default-rtdb.firebaseio.com/employee.json');
    try {
      final http.Response res = await http.get(url);
      final extractedData = json.decode(res.body) as Map<String, dynamic>;
      extractedData.forEach((empId, empData) {
        final empIndex =
        employeesList.indexWhere((element) => element.id == empId);

        if (empIndex >= 0) {
          employeesList[empIndex] = Employee(
            id: empId,
            name: empData['name'],
            position: empData['position'],
            age: empData['age'],
            birthDate: empData['birthDate'],
          );
        } else {
        employeesList.add(Employee(
          id: empId,
          name: empData['name'],
          position: empData['position'],
          age: empData['age'],
          birthDate: empData['birthDate'],
        ));
      }
          }
          );

      notifyListeners();
    } catch (error) {
      print('errorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr$error');
      throw error;
    }
  }

  Future<void> updateData(
    String id,
    String name,
    String position,
    String age,
    String birthDate,
  ) async {
    var url = Uri.parse(
        'https://employee-dashboard-4dc98-default-rtdb.firebaseio.com/employee/$id.json');

    final empIndex = employeesList.indexWhere((element) => element.id == id);
    if (empIndex >= 0) {
      await http.patch(url,
          body: json.encode({
            'name': name,
            'position': position,
            'age': age,
            'birthDate': birthDate,
          }));

      employeesList[empIndex] = Employee(
        id: id,
        name: name,
        position:position,
        age: age,
        birthDate:birthDate,
      );

      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> add(
      {required String id,
      required String name,
      required String position,
      required String age,
      required String birthDate}) async {
    var url = Uri.parse(
        'https://employee-dashboard-4dc98-default-rtdb.firebaseio.com/employee.json');
    try {
      http.Response res = await http.post(url,
          body: json.encode({
            'id': id,
            'name': name,
            'position': position,
            'age': age,
            'birthDate': birthDate,
          }));

      print(json.decode(res.body));

      employeesList.add(Employee(
        id: json.decode(res.body)['name'],
        name: name,
        position: position,
        age: age,
        birthDate: birthDate,
      ));
      print('product add');
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> delete(String id) async {
    var url = Uri.parse(
        'https://employee-dashboard-4dc98-default-rtdb.firebaseio.com/employee/$id.json');

    final empIndex = employeesList.indexWhere((element) => element.id == id);

    Employee empItem = employeesList[empIndex];
    employeesList.removeAt(empIndex);
    notifyListeners();

    var res = await http.delete(url);
    if (res.statusCode >= 400) {
      employeesList.insert(empIndex, empItem);
      notifyListeners();
      print("Could not  delete item");
    } else {
       // prodItem=null;
      print("Item Deleted");
    }
  }
}
