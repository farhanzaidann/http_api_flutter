import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:node_api/post.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String id;
  late String email;
  late String name;

  @override
  void initState() {
    id = "";
    email = "";
    name = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GET API"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("ID = $id"),
            SizedBox(
              height: 15,
            ),
            Text("Email = $email"),
            SizedBox(
              height: 15,
            ),
            Text("Name = $name"),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () async {
                  var response = await http
                      .get(Uri.parse("https://reqres.in/api/users/2"));
                  if (response.statusCode == 200) {
                    print("Berhasil");
                    Map<String, dynamic> data =
                        jsonDecode(response.body) as Map<String, dynamic>;
                    print(data["data"]);
                    setState(() {
                      id = data["data"]["id"].toString();
                      email = data["data"]["email"].toString();
                      name = "${data["data"]["first_name"]} ${data["data"]["last_name"]}";
                    });
                  } else {
                    print("ERROR! ${response.statusCode}");
                  }
                },
                child: Text("GET")),
                SizedBox(height: 50,),
                ElevatedButton(onPressed: () {
                   Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyPost()),
            );
                }, child: Text("Go Post Page"))
          ],
        ),
      ),
    );
  }
}
