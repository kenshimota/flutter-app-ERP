import 'package:flutter/material.dart';

ThemeData themeLight() => ThemeData(
      // This is the theme of your application.
      //
      // TRY THIS: Try running your application with "flutter run". You'll see
      // the application has a blue toolbar. Then, without quitting the app,
      // try changing the seedColor in the colorScheme below to Colors.green
      // and then invoke "hot reload" (save your changes or press the "hot
      // reload" button in a Flutter-supported IDE, or press "r" if you used
      // the command line to start the app).
      //
      // Notice that the counter didn't reset back to zero; the application
      // state is not lost during the reload. To reset the state, use hot
      // restart instead.
      //
      // This works for code too, not just values: Most code changes can be
      // tested with just a hot reload.

      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.pink,
        surface: Colors.pink,
        onPrimary: Colors.pink,
        error: Colors.red,
        brightness: Brightness.light,
      ),

      scaffoldBackgroundColor: const Color(0xFFdddddd),

      drawerTheme: const DrawerThemeData(
        backgroundColor: Colors.white,
      ),

      dialogTheme: const DialogTheme(
        backgroundColor: Colors.white,
      ),

      iconTheme: const IconThemeData(color: Colors.pink),

      inputDecorationTheme: InputDecorationTheme(
        iconColor: Colors.pink,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          iconColor: Colors.pink,
          foregroundColor: Colors.pink,
        ),
      ),

      dialogBackgroundColor: Colors.white,

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            foregroundColor: Colors.pink,
            shape: ContinuousRectangleBorder(
              side: const BorderSide(color: Colors.pink, width: 1),
              borderRadius: BorderRadius.circular(10),
            )),
      ),

      useMaterial3: true,
    );
