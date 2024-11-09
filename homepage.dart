import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
 
class HomePage extends StatefulWidget {
  const HomePage({super.key});
 
  @override
  State<HomePage> createState() => _HomePageState();
}
 
class _HomePageState extends State<HomePage> {
  final TextEditingController name = TextEditingController();
  String api = "https://sugoi-api.vercel.app/pokemon?name=" ;
  String imgurl = "";
 
  void fetchData() async {
    Uri apiurl = Uri.parse(api + name.text);
    http.Response response = await http.get(apiurl);
    String body = response.body;
 
    dynamic data = json.decode(body);
    String link = data["sprites"]["other"]["official-artwork"]["front_default"];
 
    setState(() {
      imgurl = link;
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokemon App"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                  image: (imgurl != "") ? DecorationImage(
                      image: NetworkImage(imgurl)) : null
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 300,
              child: TextField(
                decoration: InputDecoration(border: OutlineInputBorder()),
                controller: name,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: fetchData, child: Text("Search Pokemon"))
          ],
        ),
      ),
    );
  }
}
