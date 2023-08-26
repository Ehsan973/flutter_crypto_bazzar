import 'package:crypto_bazzar_app/data/model/crypto.dart';
import 'package:flutter/material.dart';

class CoinListScreen extends StatefulWidget {
  CoinListScreen({super.key, required this.crypto_list1});
  List<Crypto> crypto_list1;
  @override
  State<CoinListScreen> createState() => _CoinListScreenState();
}

class _CoinListScreenState extends State<CoinListScreen> {
  List<Crypto>? crypto_list;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.crypto_list = widget.crypto_list1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView.builder(
              itemCount: crypto_list!.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(8),
                  color: Colors.blueGrey[300],
                  height: 150,
                  child: Center(
                    child: Text(
                      '${crypto_list![index].name}',
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
