import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/weather.dart';

import '../bloc/weather_bloc.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget
  getWeatherIcon(int code) {
    switch (code) {
      case > 200 && <= 300:
        return Image.asset('assets/3.png');
      case > 300 && <= 400:
        return Image.asset('assets/4.png');
      case > 500 && <= 600:
        return Image.asset('assets/5.png');
      case > 600 && <= 700:
        return Image.asset('assets/6.png');
      case > 700 && <= 800:
        return Image.asset('assets/7.png');
      case == 800:
        return Image.asset('assets/8.png');
      case > 800 && 804:
        return Image.asset('assets/9.png');
      default:
        return Image.asset('assets/11.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.deepPurple),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(-3, -0.3),
                  child: Container(
                    height: 300,
                    width: 300,
                    decoration:
                    const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF673AB7)), // BoxDecoration
                  ), // Container
                ),
                Align(
                  alignment: const AlignmentDirectional(0, -1.2),
                  child: Container(
                      height: 200,
                      width: 400,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xFFFFAB40))), // BoxDecoration
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.00),
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.transparent),
                  ),
                ),
                BlocBuilder<WeatherBloc, WeatherBlocState>(
                  builder: (context, state) {
                    print('--------> has value ${state.hashCode}');
                    if(state is WeatherBlocInitial) {
                      print('Bloc Initial state...............................');
                    }
        
                    if(state is WeatherBlocLoading) {
                      print('Bloc Loading state...............................${state.props}');
                    }
        
                    if(state is WeatherBlocFailure) {
                      // return Text('📍 ${state.props}');
                      print('Bloc Failure state...............................${state.props}');
                    }
        
                    if(state is WeatherBlocSucess) {
                      print('==== Bloc Sucess State...............................');
        
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '📍 ${state.weather.areaName}',
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text(
                              'Good morning',
                              style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            getWeatherIcon(state.weather.weatherConditionCode! ),
                            Center(
                              child: Text(
                                '${state.weather.temperature!.celsius!.round()}℃',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 55, fontWeight: FontWeight.w600),
                              ),
                            ),
                            Center(
                              child: Text(state.weather.weatherMain!.toUpperCase(),
                                  style:
                                  const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500)),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Center(
                              child: Text(
                                DateFormat ('EEEE, d MMM yyyy HH:mm').add_jm().format(state.weather.date!).toString(),
                                //'Sunday 30℃ 12:27pm',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16, fontWeight: FontWeight.w300),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/11.png',
                                      scale: 10,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Sunrise',
                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          DateFormat ().add_jm().format(state.weather.sunrise!)
                                              .toString(),
                                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/12.png',
                                      scale: 10,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Sunset',
                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          DateFormat ().add_jm().format(state.weather.sunset!)
                                              .toString(),
                                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.0),
                              child: Divider(
                                color: Colors.grey,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/13.png',
                                      scale: 10,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Temp max',
                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          '${state.weather.tempMax!.celsius!.round().toString()}℃',
                                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/14.png',
                                      scale: 10,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Temp min',
                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          '${state.weather.tempMin!.celsius!.round().toString()}℃',
                                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
