import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_with_streamprovider/my_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Provider(
      create: (context) => new MyModel(), //DI
      child: MaterialApp(
          title: 'Provider with StreamProvider',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MyHomePage(title: 'Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MyModel model;
  @override
  Widget build(BuildContext context) {

   this.model = Provider.of<MyModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              'Date Without StreamProvider :' + DateTime.now().toString(),
            ),
            StreamProvider<int>.value(
              initialData: 0,
              value: model.secondCountStream,
              child: SecondWidget(),
            ),
            StreamProvider<int>.value(
              value: model.thirdCountStream,
              child: ThirdWidget(),
            ),
            StreamProvider<int>.value(
              value: model.valueStream,
             child: ValueWidget(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    if(this.model != null) {
      model.dispose();
    }

    super.dispose();

  }
}

class SecondWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var model = Provider.of<MyModel>(context);

    return Column(
      children: <Widget>[
        Text(
          'Second Current Date :' + DateTime.now().toString(),
        ),
        FlatButton(
          onPressed: () {
            model.updateSecond();
          },
          child: Text("Increment Second: " + Provider.of<int>(context).toString()),
        ),
      ],
    );
  }

}

class ThirdWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var model = Provider.of<MyModel>(context);

    return Column(
      children: <Widget>[
        Text(
          'Third Current Date :' + DateTime.now().toString(),
        ),
        FlatButton(
          onPressed: () {
            model.updateThird();
          },
          child: Text("Increment Third: " + Provider.of<int>(context).toString()),
        ),
      ],
    );
  }

}

class ValueWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var model = Provider.of<MyModel>(context);

    return Column(
      children: <Widget>[
        Text(
          'Listening a value :' + Provider.of<int>(context).toString(),
        ),
        FlatButton(
          onPressed: () {
            model.changeValue();
          },
          child: Text("Change Value"),
        ),
      ],
    );
  }
}