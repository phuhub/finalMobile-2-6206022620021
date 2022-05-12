import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_project/add.dart';
import 'package:my_project/database.dart';
import 'package:my_project/view.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Stream<QuerySnapshot> bmi =
      FirebaseFirestore.instance.collection('bmi').snapshots();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Database db;
  List docs = [];
  initialise() {
    db = Database();
    db.initiliase();
    db.read().then((value) => {
          setState(() {
            docs = value;
          })
        });
  }

  @override
  void initState() {
    super.initState();
    initialise();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(0, 0, 0, 0),
      appBar: AppBar(
        //backgroundColor: Color.fromRGBO(56, 75, 49, 1.0),
        title: Text("BMI CALCULATOR"),
      ),
      body: ListView.builder(
        itemCount: docs.length,
        itemBuilder: (BuildContext context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            View(bmi: docs[index], db: db))).then((value) => {
                      if (value != null) {initialise()}
                    });
              },
              contentPadding: EdgeInsets.only(right: 30, left: 36),
              title: Text(docs[index]['name']),
              trailing: Text(docs[index]['gender']),
              subtitle: Text('Age :' +
                  docs[index]['age'] +
                  "Weight : " +
                  docs[index]['weight'] +
                  "Height : " +
                  docs[index]['height']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Add(db: db)))
              .then((value) {
            if (value != null) {
              initialise();
            }
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
