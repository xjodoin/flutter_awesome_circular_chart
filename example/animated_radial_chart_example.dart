import 'package:awesome_circular_chart/awesome_circular_chart.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    home: new AnimatedRadialChartExample(),
  ));
}

class AnimatedRadialChartExample extends StatefulWidget {
  @override
  _AnimatedRadialChartExampleState createState() => new _AnimatedRadialChartExampleState();
}

class _AnimatedRadialChartExampleState extends State<AnimatedRadialChartExample> {
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();
  final _chartSize = const Size(200.0, 200.0);

  double value = 50.0;
  Color? labelColor = Colors.blue[200];

  void _increment() {
    setState(() {
      value += 10;
      List<CircularStackEntry> data = _generateChartData(value);
      _chartKey.currentState!.updateData(data);
    });
  }

  void _decrement() {
    setState(() {
      value -= 10;
      List<CircularStackEntry> data = _generateChartData(value);
      _chartKey.currentState!.updateData(data);
    });
  }

  List<CircularStackEntry> _generateChartData(double value) {
    Color? dialColor = Colors.blue[200];
    if (value < 0) {
      dialColor = Colors.red[200];
    } else if (value < 50) {
      dialColor = Colors.yellow[200];
    }
    labelColor = dialColor;

    List<CircularStackEntry> data = <CircularStackEntry>[
      new CircularStackEntry(
        <CircularSegmentEntry>[
          new CircularSegmentEntry(
            value,
            dialColor,
            rankKey: 'percentage',
          )
        ],
        rankKey: 'percentage',
      ),
    ];

    if (value > 100) {
      labelColor = Colors.green[200];

      data.add(new CircularStackEntry(
        <CircularSegmentEntry>[
          new CircularSegmentEntry(
            value - 100,
            Colors.green[200],
            rankKey: 'percentage',
          ),
        ],
        rankKey: 'percentage2',
      ));
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle _labelStyle =
        Theme.of(context).textTheme.headlineMedium!.merge(new TextStyle(color: labelColor));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Percentage Dial'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: AnimatedCircularChart(
              key: _chartKey,
              size: _chartSize,
              initialChartData: _generateChartData(value),
              chartType: CircularChartType.Radial,
              edgeStyle: SegmentEdgeStyle.round,
              percentageValues: true,
              holeLabel: '$value%',
              labelStyle: _labelStyle,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ElevatedButton(
                onPressed: _decrement,
                child: const Icon(Icons.remove),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.red[200]),
                  textStyle: WidgetStateProperty.all(TextStyle(color: Colors.white)),
                  shape: WidgetStateProperty.all(CircleBorder()),
                ),
              ),
              ElevatedButton(
                onPressed: _increment,
                child: const Icon(Icons.add),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.blue[200]),
                  textStyle: WidgetStateProperty.all(TextStyle(color: Colors.white)),
                  shape: WidgetStateProperty.all(CircleBorder()),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
