import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Model/catclass.dart';
class apiclass extends StatefulWidget {
  const apiclass({super.key});

  @override
  State<apiclass> createState() => _apiclassState();
}

class _apiclassState extends State<apiclass> {

  Future<CatFact> fetchCatDetails() async{
  var resp = await http.get(Uri.parse("https://catfact.ninja/fact"));
  print(resp.body);
  print(resp.statusCode);

  return CatFact.fromJson(jsonDecode(resp.body));

  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fetch Data Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<CatFact>(
            future: fetchCatDetails(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Text(snapshot.data!.fact.toString()),
                    Text(snapshot.data!.length.toString())
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
