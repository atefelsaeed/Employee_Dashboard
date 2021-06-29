import 'package:employee_dashboard/shared/component/e_component.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'employee_model.dart';

class AddEmployee extends StatefulWidget {
  @override
  _AddEmployeeState createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  var nameController = TextEditingController();
  var positionController = TextEditingController();
  var ageController = TextEditingController();
  var birthDateController = TextEditingController();
  final formKey = new GlobalKey<FormState>();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Employee'),
      ),
      body: SingleChildScrollView(
        child: _isLoading
            ? Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Container(
                padding: EdgeInsets.all(15.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      //========name=======================
                      defaultFormField(
                        controller: nameController,
                        type: TextInputType.text,
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
                        height: 15.0,
                      ),
                      //=========position=====================
                      defaultFormField(
                        controller: positionController,
                        type: TextInputType.text,
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
                        height: 15.0,
                      ),
                      //=========age==================
                      defaultFormField(
                        controller: ageController,
                        type: TextInputType.number,
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
                        height: 15.0,
                      ),
                      //===========birthDate==============
                      defaultFormField(
                        controller: birthDateController,
                        type: TextInputType.datetime,
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.parse('1930-12-01'),
                            lastDate: DateTime.now(),
                          ).then((value) {
                            birthDateController.text =
                                DateFormat.yMMMd().format(value!);
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

                      SizedBox(
                        height: 25.0,
                      ),
                      //============add================
                      Consumer<Employees>(
                          builder: (ctx, value, _) => Container(
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: FlatButton(
                                    textColor: Colors.white,
                                    child: Text("Add Employee"),
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        try {
                                          setState(() {
                                            _isLoading = true;
                                          });
                                          value
                                              .add(
                                            id: DateTime.now().toString(),
                                            name: nameController.text,
                                            position: positionController.text,
                                            age: ageController.text,
                                            birthDate: birthDateController.text,
                                          )
                                              .then((_) {
                                            setState(() {
                                              _isLoading = false;
                                            });
                                            Navigator.pop(context);
                                          });
                                        } catch (e) {
                                          print(e);
                                        }
                                      }
                                    }),
                              )),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
