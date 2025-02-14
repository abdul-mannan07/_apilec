import 'dart:convert';
import 'dart:math';

import 'package:_apilec/models/modelclass.dart';
import 'package:_apilec/models/newModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  //********custom class model*********** ////
  // List<classModel> modelList = [];
  // Future<List<classModel>> getUser() async {
  //   final response =
  //       await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
  //   var data = jsonDecode(response.body.toString());
  //   if (response.statusCode == 200) {
  //     for (Map i in data) {
  //       classModel classmodel =
  //           classModel(id: i["id"], email: i["email"], name: i["name"]);
  //       modelList.add(classmodel);
  //     }
  //     return modelList;
  //   } else {
  //     return throw ("execptions");
  //   }
  // }

  List<ClassModelNew> newList = [];
  Future<List<ClassModelNew>> newUser() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      for (Map i in jsonData) {
        newList.add(ClassModelNew.fromJson(i as Map<String, dynamic>));
      }
      return newList;
    } else {
      return throw (e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: newUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("error");
            } else if (snapshot.data == null || snapshot.data!.isEmpty) {
              return Text("user not found");
            } else {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, i) {
                    return Column(children: [
                      ListTile(
                        title: Text(snapshot.data![i].username.toString()),
                        subtitle: Text(snapshot.data![i].email),
                      )
                    ]);
                  });
            }
          }),
    );
  }
}
