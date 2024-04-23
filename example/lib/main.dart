import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:micro_sensys/micro_sensys.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _initializeStatus = 'Unknown';
  String _tagNumber = 'Unknown';
  final _microSensysPlugin = MicroSensys();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _microSensysPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Text('Running on: $_platformVersion\n'),
                  Text('_initializeStatus: $_initializeStatus\n'),
                  Text('_tagNumber : $_tagNumber\n'),
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  _microSensysPlugin.initReader().then((value) {
                    setState(() {
                      _initializeStatus = value == true ? 'Success' : 'Failed';
                    });
                  }).catchError((onError) {
                    setState(() {
                      _initializeStatus = 'Failed : ${onError.toString()}';
                    });
                  });
                },
                child: const Text('Init Reader')),
            ElevatedButton(
                onPressed: () {
                  Permission.bluetooth.request().then((value) {
                    print('Request Permisson1 OK: $value');
                  }).catchError((onError) {
                    print('Request Permisson1 Error: $onError');
                  });

                  Permission.bluetoothScan.request().then((value) {
                    print('Request Permisson2 OK: $value');
                  }).catchError((onError) {
                    print('Request Permisson2 Error: $onError');
                  });

                  Permission.bluetoothConnect.request().then((value) {
                    print('Request Permisson3 OK: $value');
                  }).catchError((onError) {
                    print('Request Permisson3 Error: $onError');
                  });

                  Permission.location.request().then((value) {
                    print('Request Permisson4: $value');
                  }).catchError((onError) {
                    print('Request Permisson4 Error: $onError');
                  });
                },
                child: const Text('Request Permisson')),
            ElevatedButton(
                onPressed: () {
                  _microSensysPlugin.identifyTag().then((value) {
                    setState(() {
                      _tagNumber = value.toString();
                    });
                  }).catchError((onError) {
                    setState(() {
                      _tagNumber = 'Failed : ${onError.toString()}';
                    });
                  });
                },
                child: const Text('Identify')),
            ElevatedButton(
                onPressed: () {
                Timer.periodic(Duration(milliseconds: 200), (timer) {
                  _microSensysPlugin.identifyTag().then((value) {
                    setState(() {
                      _tagNumber = value.toString();
                    });
                  }).catchError((onError) {
                    setState(() {
                      _tagNumber = 'Failed : ${onError.toString()}';
                    });
                  });
                });
                },
                child: const Text('Identify in Loop')),
            ElevatedButton(
                onPressed: () {
                 setState(() {
                    _tagNumber = 'Cleared';
                 });
                },
                child: const Text('Clear TAG')),
          ],
        ),
      ),
    );
  }
}
