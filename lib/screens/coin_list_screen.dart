import 'package:crypto_bazzar_app/data/constant/constants.dart';
import 'package:crypto_bazzar_app/data/model/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CoinListScreen extends StatefulWidget {
  CoinListScreen({super.key, required this.crypto_list1});
  List<Crypto> crypto_list1;
  @override
  State<CoinListScreen> createState() => _CoinListScreenState();
}

class _CoinListScreenState extends State<CoinListScreen> {
  List<Crypto>? crypto_list, showList;
  var _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.crypto_list = widget.crypto_list1;
    this.showList = this.crypto_list;
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
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: TextField(
                  controller: _controller,
                  onChanged: _filterList,
                  textAlign: TextAlign.end,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8)),
                    fillColor: greenColor,
                    filled: true,
                    hintText: 'اسم رمزارز معتبر خودتون رو سرچ کنید',
                    hintStyle: TextStyle(
                      fontFamily: 'morabae',
                    ),
                  ),
                  style: TextStyle(),
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  color: blackColor,
                  backgroundColor: greenColor,
                  onRefresh: _refreshList,
                  child: ListView.builder(
                      itemCount: showList!.length,
                      itemBuilder: (context, index) {
                        return _getListTileItem(showList![index]);
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _refreshList() async {
    Response response = await Dio().get('https://api.coincap.io/v2/assets');

    crypto_list = response.data['data']
        .map<Crypto>((jsonMapObject) => Crypto.fromMapJson(jsonMapObject))
        .toList();

    setState(() {
      showList = crypto_list!
          .where(
            (element) => element.name
                .toLowerCase()
                .contains(_controller.text.toLowerCase()),
          )
          .toList();
    });
  }

  void _filterList(value) {
    setState(() {
      showList = crypto_list!
          .where(
            (element) =>
                element.name.toLowerCase().contains(value.toLowerCase()),
          )
          .toList();
    });
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

  Widget _getListTileItem(Crypto crypto) {
    return ListTile(
      title: Text(
        '${crypto.name}',
        style: TextStyle(
          color: greenColor,
          fontSize: 20,
        ),
      ),
      subtitle: Text(
        '${crypto.symbol}',
        style: TextStyle(color: greyColor),
      ),
      leading: SizedBox(
        width: 30,
        child: Center(
          child: Text(
            '${crypto.rank.toString()}',
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
                  '${crypto.priceUsd.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: greyColor,
                  ),
                ),
                Text(
                  '${crypto.changePercent24hr.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: _getColorChangeText(crypto.changePercent24hr),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 40,
              child: Center(
                child: _getIconChange(crypto.changePercent24hr),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
