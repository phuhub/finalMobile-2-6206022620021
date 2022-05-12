import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'database.dart';

class View extends StatefulWidget {
  View({Key key, this.bmi, this.db}) : super(key: key);
  Map bmi;
  Database db;
  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<View> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController genderController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  TextEditingController weightController = new TextEditingController();
  TextEditingController heightController = new TextEditingController();
  TextEditingController bmicalController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    print(widget.bmi);
    nameController.text = widget.bmi['name'];
    genderController.text = widget.bmi['gender'];
    ageController.text = widget.bmi['age'];
    weightController.text = widget.bmi['weight'];
    heightController.text = widget.bmi['height'];
    bmicalController.text = widget.bmi['bmi'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(0, 0, 0, 0),
      appBar: AppBar(
        //backgroundColor: Color.fromRGBO(56, 75, 49, 1.0),
        title: Text("BMI EDIT"),
        actions: [
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                widget.db.delete(widget.bmi["id"]);
                Navigator.pop(context, true);
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
                widget.db.update(
                    widget.bmi['id'],
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
}
