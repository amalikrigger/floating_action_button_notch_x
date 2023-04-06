import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'BottomAppBar Example',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int _increment = 0;
  bool _isPressed = false;

  void _onItemTapped() {
    setState(() {
      _increment++;
    });
  }

  late AnimationController _controller;
  late Animation<double> _myAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _myAnimation = CurvedAnimation(parent: _controller, curve: Curves.linear);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void floatingAction() {
    if (_isPressed) {
      _controller.reverse();
      setState(() {
        _isPressed = false;
      });
    } else {
      _controller.forward();
      setState(() {
        _isPressed = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text('BottomAppBar Example'),
      ),
      body: Center(
        child: Container(
          width: width,
          height: height,
          color: Colors.blueAccent,
          child: Center(
            child: Text(
              '$_increment',
              style: const TextStyle(fontSize: 50, color: Colors.white),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => {floatingAction(), _onItemTapped()},
        child: AnimatedIcon(
          icon: AnimatedIcons.add_event,
          progress: _myAnimation,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.home,
                color: Colors.white,
              ),
              onPressed: () => print(0),
            ),
            IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () => print(1),
            ),
          ],
        ),
      ),
    );
  }
}
