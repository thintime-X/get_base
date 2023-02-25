import 'package:example/repository.dart';
import 'package:flutter/material.dart';

Repository repository = Repository();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
  }

  void _incrementCounter() {
    /*repository.pwdLogin();
    setState(() {
      _counter++;
    });*/
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => TowPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TowPage extends StatefulWidget {
  const TowPage({Key? key}) : super(key: key);

  @override
  State<TowPage> createState() => _TowPageState();
}

class _TowPageState extends State<TowPage> {

  @override
  void initState() {
    repository.addCancelTokenListener(runtimeType.toString());
    super.initState();
  }

  @override
  void dispose() {
    repository.removeCancelTokenListener(runtimeType.toString());
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              repository.pwdLogin();
              repository.pwdLogin();
              repository.pwdLogin();
              repository.pwdLogin(bindPage: false);
            },
            child: const Text(
              "请求",
            ),
          ),
        ],
      ),
    );
  }
}
