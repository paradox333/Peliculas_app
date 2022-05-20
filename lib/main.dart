import 'package:flutter/material.dart';
import 'package:peliculas_app_2/providers/movies_provider.dart';
import 'package:peliculas_app_2/screens/screens.dart';
import 'package:provider/provider.dart';
void main() => runApp(AppState());

class AppState extends StatelessWidget {
  const AppState({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider( create: ( _ ) => MoviesProvider(), lazy: false, ),
       ],
       child: MyApp(),      
    );
    
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'home': ( _ ) => HomeScreen(),
        'details': ( _ ) => DetailsScreen()
      },
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          color: Colors.green
        )
      ),
    );
  }
}