import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/drawer_app.dart';
import 'package:flutter_app_erp/widgets/typography.dart';

class ScaffoldApp extends StatefulWidget {
  final Widget? body;
  final String? title;

  const ScaffoldApp({
    super.key,
    this.body,
    this.title,
  });

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
        leading: IconButton(
      icon: const Icon(Icons.menu, color: Colors.white),
      onPressed: () {
        _scaffoldKey.currentState!.openDrawer();
      },
    ),
        title: TypographyApp(
          text: widget.title ?? 'Drawer Demo',
          variant: "h3",
          color: "white",
        ),
      ),
      body: widget.body,
      
      drawer: DrawerApp(
        onClose: _closeDrawer,
      ),
      drawerEnableOpenDragGesture: false,
    );
  }
}
