import 'package:flutter/material.dart';
import 'package:stock_app/widgets/chartWidget.dart';
import 'package:stock_app/widgets/sparkLineChartWidget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: MyHomePage.id,
      routes: {
        MyHomePage.id: (context) => MyHomePage(),
        SparkLineChartWidget.id: (context) => SparkLineChartWidget()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  static const String id = '';
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.pushNamed(context, SparkLineChartWidget.id);
      },
      child: Icon(Icons.show_chart),),
      appBar: AppBar(
        title: Text("Stock Status in google chart"),
      ),
      body: Center(
        child: ChartWidget(),
      )
    );
  }
}