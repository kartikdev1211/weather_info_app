import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weather_info/providers/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
        title: const Text(
          "Weather Deatils",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<WeatherProvider>(context, listen: false).fetchData(
                  Provider.of<WeatherProvider>(context, listen: false)
                      .weather!
                      .cityName);
            },
            icon: const Icon(
              CupertinoIcons.refresh,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Align(
                alignment: const AlignmentDirectional(3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(-3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF673AB7),
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, -1.2),
                child: Container(
                  height: 300,
                  width: 600,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFAB40),
                  ),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
                ),
              ),
              Consumer<WeatherProvider>(
                builder: (context, weatherProvider, child) {
                  if (weatherProvider.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (weatherProvider.weather == null) {
                    return const Center(
                      child: Text("No data available"),
                    );
                  } else {
                    final weather = weatherProvider.weather;
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: h / 40,
                          ),
                          Text(
                            "📍 ${weather!.cityName}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                fontSize: 20),
                          ),
                          SizedBox(
                            height: h / 20,
                          ),
                          Center(
                            child: SizedBox(
                              height: h * 0.3,
                              child: Image.network(
                                'https://openweathermap.org/img/wn/${weather.icon}@2x.png',
                                filterQuality: FilterQuality.high,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              weather.description.toUpperCase(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            height: h / 30,
                          ),
                          Text(
                            "Temperature: ${weather.temperature} Celsius",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Humidity: ${weather.humidity}%",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Wind Speed: ${weather.windSpeed}m/s",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
