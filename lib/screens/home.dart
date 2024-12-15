import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:random_jokes/models/joke_type_model.dart';
import 'package:random_jokes/widgets/jokeType//joke_type_grid.dart';
import 'package:random_jokes/services/api_service.dart';
import 'package:random_jokes/screens/random_joke.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<JokeType> jokeTypes = [];

  @override
  void initState() {
    super.initState();
    getJokeTypeFromAPI();
  }

  void getJokeTypeFromAPI() async {
    ApiService.getJokeTypes().then((response) {
      var data = List.from(json.decode(response.body));
      setState(() {
        jokeTypes = data.map<JokeType>((element) {

          return JokeType(type: element);
        }).toList();
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu, color: Colors.white, size: 24)),
        title: const Text("Jokes App", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [IconButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const RandomJokeScreen()));}, icon: const Icon(Icons.lightbulb_outline, color: Colors.white, size: 24))],
      ),
      body: JokeTypeGrid(jokeTypes: jokeTypes),
      backgroundColor: Colors.black,
    );
  }
}
