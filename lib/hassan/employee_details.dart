import 'package:employee_dashboard/shared/component/e_component.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'employee_model.dart';

// ignore: must_be_immutable
class EmployeeDetails extends StatelessWidget {
  final String id;
  final String name;
  final String position;
  final String age;
  final String birthDate;

  EmployeeDetails(
    this.id,
    this.name,
    this.position,
    this.age,
    this.birthDate,
  );

  TextEditingController nameController = TextEditingController();
  var birthDateController = TextEditingController();
  var positionController = TextEditingController();
  var ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<Employee> empList =
        Provider.of<Employees>(context, listen: true).employeesList;

    //, orElse: ()=>null
    var filteredItem = empList.firstWhere((element) => element.id == id);

    return Scaffold(
      appBar: AppBar(
        title: filteredItem == null ? null : Text(filteredItem.name),
      ),
      body: filteredItem == null
          ? null
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  buildCard(filteredItem.name, filteredItem.position,
                      filteredItem.age, filteredItem.birthDate, context),
                  SizedBox(height: 80),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //=======================Edit_FloatingActionButton======================
                      FloatingActionButton(
                        heroTag: 'id',
                        backgroundColor: Colors.green,
                        onPressed: () =>
                            Provider.of<Employees>(context, listen: false)
                                .updateData(
                          id,nameController.text,positionController.text, ageController.text,birthDateController.text
                        ),
                        // name, position, age, birthDate
                        child: Icon(Icons.edit, color: Colors.white),
                      ),

                      SizedBox(
                        width: 25,
                      ),
                      //=======================Delete_FloatingActionButton======================
                      FloatingActionButton(
                        heroTag: 'del',
                        backgroundColor: Colors.red,
                        onPressed: () {
                          Navigator.pop(context, filteredItem.id);
                        },
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  Card buildCard(String name, String position, String age, String birthDate,
      BuildContext context) {
    nameController.text = name;
    ageController.text = age;
    positionController.text = position;
    birthDateController.text = birthDate;

    return Card(
      elevation: 3,
      margin: EdgeInsets.all(7),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //========Name=======================
            defaultFormField(
              controller: nameController,
              type: TextInputType.text,
              onSave: (val) => nameController.text = val,
              initialValue: name,
              validate: (value) {
                if (value.isEmpty) {
                  return 'name must not be empty';
                }
                return null;
              },
              label: 'Name',
              prefix: Icons.person,
            ),
            SizedBox(
              height: 15,
            ),
            //========Position=======================
            defaultFormField(
              controller: positionController,
              type: TextInputType.text,
              onSave: (val) => name = val,
              initialValue: position,
              validate: (value) {
                if (value.isEmpty) {
                  return 'position must not be empty';
                }
                return null;
              },
              label: 'Position',
              prefix: Icons.title,
            ),
            SizedBox(
              height: 15,
            ),
            //========Age=======================
            defaultFormField(
              controller: ageController,
              type: TextInputType.number,
              onSave: (val) => ageController.text = val,
              initialValue: age,
              validate: (value) {
                if (value.isEmpty) {
                  return 'age must not be empty';
                }
                return null;
              },
              label: 'Age',
              prefix: Icons.calendar_today,
            ),
            SizedBox(
              height: 15,
            ),
            //========BirthDate=======================
            defaultFormField(
              controller: birthDateController,
              type: TextInputType.datetime,
              onSave: (val) => birthDateController.text = val,
              initialValue: birthDate,
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.parse('1930-12-01'),
                  lastDate: DateTime.now(),
                ).then((value) {
                  birthDateController.text = DateFormat.yMMMd().format(value!);
                });
              },
              validate: (value) {
                if (value.isEmpty) {
                  return 'birthDate must not be empty';
                }
                return null;
              },
              label: 'BirthDate',
              prefix: Icons.calendar_today_outlined,
            ),
          ],
        ),
      ),
    );
  }
}
