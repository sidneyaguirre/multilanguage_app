import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:responsive_app/theme/color_schemes.g.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _changeTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            //Añadir esto luego del primer flutter gen-l10n
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'), // English
            Locale('es'), // Spanish
            //Añade aquí los otros Locale que quieras usar
          ],
          //pasamos el scheme que tenemos en nuestro archivo importado
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightColorScheme,
          ),
          // agregar colores
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: darkColorScheme,
          ),
          themeMode: _themeMode,
          home: child,
        );
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: IconButton.outlined(
                onPressed: _changeTheme,
                icon: _themeMode == ThemeMode.light
                    ? const Icon(Icons.dark_mode)
                    : const Icon(Icons.light_mode),
              ),
            ),
          ],
          elevation: 5, //añade una pequeña sombra bajo la barra
          //entre mayor la elevación, más grande la sombra
          title: const Text('My app'),
        ),
        body: const MyApp(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    
    var mq = MediaQuery.sizeOf(context);

    //Formatos de Color
    Color c1 = const Color(0xffec407a).withOpacity(0.5);
    Color c2 = const Color.fromARGB(0xFF, 0x42, 0xA5, 0xF5);
    Color c3 = const Color.fromARGB(255, 66, 165, 245);
    Color c4 = const Color.fromRGBO(66, 165, 245, 1.0);

    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: theme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              localizations.helloWorld,
              style: TextStyle(
                color: theme.onPrimaryContainer,
              ),
            ),
            Text(
              localizations.save,
              style: TextStyle(
                color: theme.onPrimaryContainer,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: theme.primaryContainer,
                    ),
                    height: mq.height * 0.5,
                    width: 200.w,
                    child: Text(
                      'This is a very long text that '
                      'won\'t fit the line.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                ),
                const Text(
                  'Goodbye',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
