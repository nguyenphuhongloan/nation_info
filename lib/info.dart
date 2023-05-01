import 'package:flutter/material.dart';
import 'package:nation_info/models/country.dart';
import 'package:intl/intl.dart' as intl;

class InfoScreen extends StatefulWidget {
  final Country country;
  const InfoScreen({super.key, required this.country});
  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.country.countryName)),
      body: Column(children: [
        const SizedBox(
          height: 35,
        ),
        Center(
          child: Image(
            image: NetworkImage(widget.country.getMapImageUrl()),
            width: 300,
            height: 300,
            fit: BoxFit.contain,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          ),
        ),
        SizedBox(
          width: 300,
          height: 190,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Name: ${widget.country.countryName}",
                  style: const TextStyle(fontSize: 19)),
              Text("Capital: ${widget.country.capital}",
                  style: const TextStyle(fontSize: 19)),
              Text(
                  "Population: ${intl.NumberFormat.decimalPattern("eu").format(widget.country.population)}",
                  style: const TextStyle(fontSize: 19)),
              Text(
                  "Area In Km: ${intl.NumberFormat.decimalPattern("eu").format(widget.country.areaInSqKm)}",
                  style: const TextStyle(fontSize: 19))
            ],
          ),
        )
      ]),
    );
  }
}
