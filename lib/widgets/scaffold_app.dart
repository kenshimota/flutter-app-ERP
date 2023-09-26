import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/drawer_app.dart';

class ScaffoldApp extends StatefulWidget {
  final Widget? body;
  const ScaffoldApp({super.key, this.body});

  @override
  State<ScaffoldApp> createState() => _ScaffoldApp();
}

class _ScaffoldApp extends State<ScaffoldApp> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
// esto lo acabo de agregar
  int screenIndex = 0;
  late bool showNavigationDrawer;

  void handleScreenChanged(int selectedScreen) {
    setState(() {
      screenIndex = selectedScreen;
    });
  }

  void _closeDrawer() {
    _scaffoldKey.currentState!.closeDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Drawer Demo'),
      ),
      body: widget.body,
      drawer: Container(
        child: DrawerApp(
          onClose: _closeDrawer,
          children: [
            AppBar(
              title: Text("Articles"),
              automaticallyImplyLeading: false,
              elevation: 0,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20),
              constraints: const BoxConstraints.expand(height: 80),
              child: const Text(
                "This is my first article.",
                style: TextStyle(fontSize: 20),
              ),
            ),
            const Divider(
              height: 0,
              color: Colors.black,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20),
              constraints: const BoxConstraints.expand(height: 80),
              child: const Text(
                "This is my second article.",
                style: TextStyle(fontSize: 20),
              ),
            ),
            const Divider(
              height: 0,
              color: Colors.black,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20),
              constraints: const BoxConstraints.expand(height: 80),
              child: const Text(
                "This is my third article.",
                style: TextStyle(fontSize: 20),
              ),
            ),
            const Divider(
              height: 0,
              color: Colors.black,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20),
              constraints: const BoxConstraints.expand(height: 80),
              child: const Text(
                "This is my forth article.",
                style: TextStyle(fontSize: 20),
              ),
            ),
            const Divider(
              height: 0,
              color: Colors.black,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20),
              constraints: const BoxConstraints.expand(height: 80),
              child: const Text(
                "This is my fifth article.",
                style: TextStyle(fontSize: 20),
              ),
            ),
            const Divider(
              height: 0,
              color: Colors.black,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20),
              constraints: const BoxConstraints.expand(height: 80),
              child: const Text(
                "This is my sixth article.",
                style: TextStyle(fontSize: 20),
              ),
            ),
            const Divider(
              height: 0,
              color: Colors.black,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20),
              constraints: const BoxConstraints.expand(height: 80),
              child: const Text(
                "This is my seventh article.",
                style: TextStyle(fontSize: 20),
              ),
            ),
            const Divider(
              height: 0,
              color: Colors.black,
            ),
          ],
        ),
      ),
      drawerEnableOpenDragGesture: false,
    );
  }
}
