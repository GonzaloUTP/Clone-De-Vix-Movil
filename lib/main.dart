import 'package:clondevix/Screens/ejemplo.dart';
import 'package:clondevix/api/firebaseapi.dart';
import 'package:clondevix/firebase_options.dart';
import 'package:clondevix/login2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:clondevix/Screens/LivePage.dart';
import 'package:clondevix/Screens/ProfilePage.dart';
import 'package:clondevix/Screens/SearchPage.dart';
import 'package:get/get.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Firebaseapi().initNotifications();
  runApp(GetMaterialApp(
    home: Login2(),
  ));
}

// Clase para representar los datos de cada carta
class CardData {
  final String text;
  final String imagePath;

  CardData({required this.text, required this.imagePath});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          titleLarge: TextStyle(color: Colors.white),
        ),
      ),
      home: Login2(),
      routes: {},
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
void login4() {
  FirebaseAuth.instance.signOut();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Establece el fondo del Scaffold a negro
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('VIX', style: TextStyle(color: Colors.white)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Ejemplo(),
                ));
              },
              child: Text(
                'Prueba Premium',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ),
          IconButton(
            onPressed: login4, 
            icon: Icon(Icons.logout)
            ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: <Widget>[
          HomePage(),
          LivePage(),
          CharacterList(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.live_tv),
            label: 'En vivo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar',
          ),
          
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
          
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  // Lista de cartas con datos diferentes
  List<CardData> cardList = [
    CardData(text: 'Placeholder 1', imagePath: 'assets/4.png'),
    CardData(text: 'Placeholder 2', imagePath: 'assets/5.png'),
    CardData(text: 'Placeholder 3', imagePath: 'assets/6.png'),
    // Añade más objetos CardData según sea necesario
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.black,
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryButton('Novelas'),
                  _buildCategoryButton('Noticias'),
                  _buildCategoryButton('Deportes'),
                  _buildCategoryButton('Más'),
                   _buildCategoryButton('Libros'),
                ],
              ),
            ),
          ),
          _buildImageCarousel(),
          _buildSectionTitle('Novelas mas vistas'),
          _buildPlaceholderRowTwod(),
          _buildSectionTitle('Proximamente'),
          _buildPlaceholderRowTwod(),
          _buildSectionTitle('Top 10 de la semana'),
          _buildPlaceholderRowTwod(),
          _buildSectionTitle('Lo nuevo de las estrellas y canal 5'),
          _buildPlaceholderRowTwod(),
          _buildSectionTitle('Nuevo en Vix'),
          _buildPlaceholderRowTwod(),
          _buildSectionTitle('venciendo el amor'),
          _buildPlaceholderRowTwod(),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0), // Ajustar el espaciado
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: BorderSide(color: Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        child: Text(text),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  Widget _buildPlaceholderRowTwod() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: cardList.map((cardData) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 150,
              height: 200,
              color: Colors.grey,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      cardData.imagePath,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 8),
                    Text(
                      cardData.text,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPlaceholderRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(3, (index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 150,
              height: 200,
              color: Colors.grey,
              child: Center(
                child: Text(
                  'Placeholder',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildImageCarousel() {
    List<String> imagePaths = [
      'assets/1.png',
      'assets/2.png',
      'assets/3.png',
      //'assets/4.png',
      //'assets/5.png',
    ];

    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      items: imagePaths.map((imagePath) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
              child: Center(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.fill, // Cambia BoxFit.cover a BoxFit.fill
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image.asset('assets/8.jpg'),
      nextScreen: MyApp(),
      splashTransition: SplashTransition.scaleTransition,
      pageTransitionType: PageTransitionType.fade,
      backgroundColor: Colors.black,
      duration: 3000,  // Duración de la splash screen en milisegundos
    );
  }
}
