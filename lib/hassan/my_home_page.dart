import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_employee.dart';
import 'employee_details.dart';
import 'employee_model.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? id;

  bool _isLoading = true;

  @override
  void initState() {
    Provider.of<Employees>(context, listen: false)
        .featchData()
        .then((_) => _isLoading = false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Employee> empList =
        Provider.of<Employees>(context, listen: true).employeesList;

    Widget detailCard(id, name, position, age, birthDate, ctx) {
      return InkWell(
          onTap: () {
            Navigator.push(
              ctx,
              MaterialPageRoute(
                  builder: (_) =>
                      EmployeeDetails(id, name, position, age, birthDate)),
            ).then((id) =>
                Provider.of<Employees>(context, listen: false).delete(id));
          },
          child: Column(
            children: [
              SizedBox(height: 5),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: CircleAvatar(
                          radius: 40.0,
                          child: Text(
                            name,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              position,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              birthDate,
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              age.toString(),
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ));
    }

    return Scaffold(
      appBar: AppBar(title: Text('Employee')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : (empList.isEmpty
              ? Center(
                  child: Text('No Employees Added.',
                      style: TextStyle(fontSize: 22)))
              : Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ListView(
                    children: empList
                        .map((item) => Builder(
                            builder: (ctx) => detailCard(item.id, item.name,
                                item.position, item.age, item.birthDate, ctx)))
                        .toList(),
                  ),
                )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => AddEmployee())),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
