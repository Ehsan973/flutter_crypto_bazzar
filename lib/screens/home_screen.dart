import 'package:crypto_bazzar_app/data/model/crypto.dart';
import 'package:crypto_bazzar_app/screens/coin_list_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Center(
          child: SpinKitCubeGrid(
            color: Colors.green,
            size: 80,
          ),
        ),
      ),
    );
  }

  void _getData() async {
    Response response = await Dio().get('https://api.coincap.io/v2/assets');
    List<Crypto> crypto_list = response.data['data']
        .map<Crypto>((jsonMapObject) => Crypto.fromMapJson(jsonMapObject))
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CoinListScreen(crypto_list1: crypto_list),
      ),
    );
  }
}
