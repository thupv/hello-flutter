import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

void main() => runApp(new MyApp());

@immutable
class AppState {
  final counter;

  AppState(this.counter);
}

enum Action { Increment }

AppState reducer(AppState prev, action) {
  if (action == Action.Increment) {
    return new AppState(prev.counter + 1);
  }
  return prev;
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final store = new Store<AppState>(reducer, initialState: new AppState(0));

  @override
  Widget build(BuildContext context) {
    return new StoreProvider<AppState>(
        store: store,
        child: new Scaffold(
          appBar: new AppBar(
            title: new Text('Hello-flutter-redux'),
          ),
          body: new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(
                  'You have pushed the button this many times:',
                ),
                new StoreConnector<AppState, int>(
                  converter: (store) => store.state.counter,
                  builder: (context, counter) => new Text('$counter',
                      style: Theme.of(context).textTheme.display1),
                )
              ],
            ),
          ),
          floatingActionButton: new StoreConnector<AppState, VoidCallback>(
              converter: (store) {
                return () => store.dispatch(Action.Increment);
              },
              builder: (context, callback) => new FloatingActionButton(
                    onPressed: callback,
                    tooltip: 'Increment',
                    child: new Icon(Icons.add),
                  )), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
