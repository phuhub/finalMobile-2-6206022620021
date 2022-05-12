import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'database.dart';

class Add extends StatefulWidget {
  Add({Key key, this.db}) : super(key: key);
  Database db;
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  double _result;
  TextEditingController nameController = new TextEditingController();
  TextEditingController genderController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  TextEditingController weightController = new TextEditingController();
  TextEditingController heightController = new TextEditingController();
  TextEditingController bmicalController = new TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(0, 0, 0, 0),
      appBar: AppBar(
        //backgroundColor: Color.fromRGBO(56, 75, 49, 1.0),
        title: Text("Add Data"),
        actions: [
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                // widget.db.delete(widget.country["id"]);
                // Navigator.pop(context, true);
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: inputDecoration("Name"),
                controller: nameController,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: inputDecoration("Gender"),
                controller: genderController,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: inputDecoration("Age"),
                controller: ageController,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: inputDecoration("Weight"),
                controller: weightController,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: inputDecoration("Height"),
                controller: heightController,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: inputDecoration("Height for calculator"),
                controller: _heightController,
              ),
              SizedBox(height: 20),
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: inputDecoration("Weight for calculator"),
                controller: _weightController,
              ),
              SizedBox(height: 15),
              RaisedButton(
                color: Color.fromARGB(255, 2, 2, 2),
                child: Text(
                  "Calculate",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: calculateBMI,
              ),
              SizedBox(height: 15),
              Text(
                _result == null
                    ? "Enter Value"
                    : "${_result.toStringAsFixed(2)}",
                style: TextStyle(
                  color: Color.fromARGB(255, 7, 7, 7),
                  fontSize: 19.4,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: inputDecoration("Add BMI After Calculator"),
                controller: bmicalController,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        color: Colors.transparent,
        child: BottomAppBar(
          color: Colors.transparent,
          child: OutlinedButton(
              //color: Colors.black,
              onPressed: () {
                widget.db.create(
                    nameController.text,
                    genderController.text,
                    ageController.text,
                    weightController.text,
                    heightController.text,
                    bmicalController.text);
                Navigator.pop(context, true);
              },
              child: Text(
                "Save",
                style: TextStyle(color: Colors.white),
              )),
        ),
      ),
    );
  }

  InputDecoration inputDecoration(String labelText) {
    return InputDecoration(
      focusColor: Colors.white,
      labelStyle: TextStyle(color: Colors.white),
      labelText: labelText,
      fillColor: Colors.white,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: BorderSide(color: Colors.white),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: BorderSide(
          color: Colors.white,
          width: 2.0,
        ),
      ),
    );
  }

  void calculateBMI() {
    double height = double.parse(_heightController.text) / 100;
    double weight = double.parse(_weightController.text);

    double heightSquare = height * height;
    double result = weight / heightSquare;

    _result = result;

    setState(() {});
  }
}
