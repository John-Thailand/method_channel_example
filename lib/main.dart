import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const batteryChannel = MethodChannel('mukku.com/battery');
  String batteryLevel = 'Waiting...';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(batteryLevel),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await getBatteryLevel();
        },
        tooltip: 'Get Battery Level',
        child: const Icon(Icons.battery_full),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future getBatteryLevel() async {
    final arguments = {'name': 'Naoki Honda'};
    final String newBateryLevel =
        await batteryChannel.invokeMethod('getBatteryLevel', arguments);

    setState(() {
      batteryLevel = '$newBateryLevel%';
    });
  }
}
