import 'package:flutter/material.dart';
import 'package:nation_info/data/country_repository.dart';
import 'package:nation_info/info.dart';
import 'package:nation_info/models/country.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late Future<List<Country>> countryList;
  @override
  void initState() {
    super.initState();
    countryList = getAllCountry();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text("Nation Info")),
        body: Center(
          child: FutureBuilder(
              future: countryList,
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    children: snapshot.data!
                        .map((e) => GestureDetector(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => InfoScreen(country: e,))),
                          child: SizedBox(
                              width: size.width,
                              height: 95,
                              child: Center(
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 15),
                                  width: size.width - 18,
                                  height: 85,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(
                                            blurRadius: 5, color: Colors.grey)
                                      ]),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(right: 8),
                                        child: Image(
                                          image:
                                              NetworkImage(e.getFlagImageUrl()),
                                          width: 100,
                                          fit: BoxFit.contain,
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent? loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return Center(
                                              child: CircularProgressIndicator(
                                                value: loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        loadingProgress
                                                            .expectedTotalBytes!
                                                    : null,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          e.countryName,
                                          style: const TextStyle(fontSize: 17),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )),
                        ))
                        .toList(),
                  );
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return const CircularProgressIndicator();
              })),
        ),
      ),
    );
  }
}
