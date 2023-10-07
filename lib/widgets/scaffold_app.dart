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
        ),
      ),
      drawerEnableOpenDragGesture: false,
    );
  }
}
