import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyPost extends StatefulWidget {
  const MyPost({super.key});

  @override
  State<MyPost> createState() => _MyPostState();
}

class _MyPostState extends State<MyPost> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePost(),
    );
  }
}

class HomePost extends StatefulWidget {
  const HomePost({super.key});

  @override
  State<HomePost> createState() => _HomePostState();
}

class _HomePostState extends State<HomePost> {
  TextEditingController nameA = TextEditingController();
  TextEditingController jobA = TextEditingController();

  String name = "";
  String job = "";
  String id = "";
  String createdAt = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("POST API"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: nameA,
            autocorrect: false,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Name",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: jobA,
            autocorrect: false,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Job",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () async {
                var response = await http.post(
                  Uri.parse("https://reqres.in/api/users"),
                  body: {"name": nameA.text, "job": jobA.text},
                );
                Map<String, dynamic> data = jsonDecode(response.body) as Map<String, dynamic>;

                setState(() {
                  name = "${data['name']}";
                  job = "${data['job']}";
                  id = "${data['id']}";
                  createdAt = "${data['createdAt']}";
                });
              },
              child: Text("Submit")),
          SizedBox(height: 20),
          Divider(),
          SizedBox(height: 20),
          Text("ID = $id"),
          SizedBox(height: 20),
          Text("Name = $name"),
          SizedBox(height: 20),
          Text("Job = $job"),
          SizedBox(height: 20),
          Text("CreatedAt = $createdAt"),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
