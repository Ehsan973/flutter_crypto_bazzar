import 'package:crypto_bazzar_app/data/constant/constants.dart';
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
      backgroundColor: blackColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'کریپتو بازار',
          style: TextStyle(fontFamily: 'morabae'),
        ),
        centerTitle: true,
        backgroundColor: blackColor,
      ),
      body: SafeArea(
        child: Center(
          child: ListView.builder(
              itemCount: crypto_list!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    '${crypto_list![index].name}',
                    style: TextStyle(
                      color: greenColor,
                      fontSize: 20,
                    ),
                  ),
                  subtitle: Text(
                    '${crypto_list![index].symbol}',
                    style: TextStyle(color: greyColor),
                  ),
                  leading: SizedBox(
                    width: 30,
                    child: Center(
                      child: Text(
                        '${crypto_list![index].rank.toString()}',
                        style: TextStyle(color: greyColor),
                      ),
                    ),
                  ),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${crypto_list![index].priceUsd.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: greyColor,
                              ),
                            ),
                            Text(
                              '${crypto_list![index].changePercent24hr.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: _getColorChangeText(
                                    crypto_list![index].changePercent24hr),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 40,
                          child: Center(
                            child: _getIconChange(
                                crypto_list![index].changePercent24hr),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }

  Widget _getIconChange(double changePercentag24hr) {
    return changePercentag24hr > 0
        ? Icon(
            Icons.trending_up,
            size: 24,
            color: greenColor,
          )
        : Icon(
            Icons.trending_down,
            size: 24,
            color: redColor,
          );
  }

  Color _getColorChangeText(double changePercentag24hr) {
    return changePercentag24hr > 0 ? greenColor : redColor;
  }
}
