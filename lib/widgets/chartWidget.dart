import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:stock_app/models/stockModel.dart';
import 'package:stock_app/services/stockDataService.dart';
import 'package:stock_app/utils/utils.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:async';


class ChartWidget extends StatefulWidget {
  @override
  _ChartWidgetState createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {

  bool _isLoading = false;
  List<StockModel> _stockModel = [];
  StockDataService _stockDataService = StockDataService();
  List<ChartData> _chartData = [];

  @override
  void initState() {
    this.getStockData();
    super.initState();
  } 

  @override
  Widget build(BuildContext context) {
    return Container(
      child: this._isLoading  == true ? CircularProgressIndicator() :
      charts.TimeSeriesChart(
        this._getChart(), animate: false,
      )
    );
  }

  Future<void> getStockData() async {
    this.setState(() {
      this._isLoading = true;
    });
    await this._stockDataService.getStockData()
    .then((response) {
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
        this._chartData.add(
          new ChartData(xAxis: i.date, yAxis: toNumber(i.volume))
        );
      });
    }
  }

  List<charts.Series<ChartData, DateTime>> _getChart() {
    return [
      charts.Series<ChartData, DateTime>(
        id: 'Stock',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (ChartData chartData, _) => DateTime.parse(chartData.xAxis),
        measureFn: (ChartData chartData, _) => chartData.yAxis,
        data: this._chartData
      ),
    ];
  }
}
