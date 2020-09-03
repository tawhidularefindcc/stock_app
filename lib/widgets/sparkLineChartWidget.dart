import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:stock_app/models/stockModel.dart';
import 'package:stock_app/services/stockDataService.dart';
import 'package:stock_app/utils/utils.dart';

class SparkLineChartWidget extends StatefulWidget {
  static const String id = 'sparkline';
  @override
  _SparLlineChartWidgetState createState() => _SparLlineChartWidgetState();
}

class _SparLlineChartWidgetState extends State<SparkLineChartWidget> {
  bool _isLoading = false;
  List<StockModel> _stockModel = [];
  StockDataService _stockDataService = StockDataService();
  List<double> _chartData = [];

  @override
  void initState() {
    this.getStockData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stock Status in sparkline"),
      ),
      body: Center(
        child: this._isLoading == false ? Container(
          padding: EdgeInsets.all(10),
          height: 200,
          child: Center(
            child: Sparkline(
              data: this._chartData,
            ),
          ),
        ) : CircularProgressIndicator(),
      ),
    );
  }

  Future<void> getStockData() async {
    this.setState(() {
      this._isLoading = true;
    });
    await this._stockDataService.getStockData().then((response) {
      var data = json.decode(response.body) as List;
      this.setState(() {
        this._stockModel = data.map((model) {
          return StockModel.fromJson(model);
        }).toList();
        this._isLoading = false;
      });
    });
    for (StockModel i in this._stockModel) {
      this.setState(() {
        this._chartData.add(toNumber(i.volume).toDouble());
      });
    }
  }
}