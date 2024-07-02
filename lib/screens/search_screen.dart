import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_info/providers/provider.dart';
import 'package:weather_info/screens/home_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Provider.of<WeatherProvider>(context, listen: false)
            .loadLastCityWeather();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: "Enter City name",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              onPressed: () {
                if (searchController.text.isNotEmpty) {
                  Provider.of<WeatherProvider>(context, listen: false)
                      .fetchData(searchController.text);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                }
              },
              icon: const Icon(CupertinoIcons.search),
              label: const Text("Get Weather"),
            ),
            Consumer<WeatherProvider>(
              builder: (context, weatherProvider, child) {
                if (weatherProvider.isLoading) {
                  return const CircularProgressIndicator();
                } else if (weatherProvider.error != null) {
                  return Text(
                    weatherProvider.error!,
                    style: const TextStyle(color: Colors.red),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
