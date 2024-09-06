import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Importar flutter_svg para usar SVG icons

void main() {
  runApp(GetMaterialApp(
    home: ProfilePage(),
  ));
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Planes de Suscripción'),
        backgroundColor: Colors.grey[900],
        actions: [
          IconButton(
            icon: Icon(Icons.login),
            onPressed: () {
              // Acción de botón de inicio de sesión
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          HeaderSection(),
        
          GestureDetector(
            child: CustomCard(title: 'Mi Lista', pdfUrl: ''),
            onTap: () {
              // Acción al hacer clic en "Mi Lista"
              Get.to(() => PdfViewerPage(pdfUrl: ''));
            },
          ),
            CustomCard(title: 'Política de privacidad', pdfUrl: 'https://ayudaleyprotecciondatos.es/wp-content/uploads/2018/07/politica-privacidad-app.pdf'),
          CustomCard(title: 'Términos de uso', pdfUrl: 'https://uniandes.edu.co/sites/default/files/asset/document/terminos-condiciones-app-uniandes-2020-v1.pdf'),
          CustomCard(title: 'No vender mi información personal', pdfUrl: 'https://home.inai.org.mx/wp-content/documentos/DocumentosSectorPrivado/Guia_obligaciones_lfpdppp_junio2016.pdf'),
          CustomCard(title: 'Centro de ayuda', pdfUrl: ''),
        ],
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Con Premium\ntienes más',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          FeatureItem(text: 'Series y películas premium'),
          FeatureItem(text: 'Liga MX y más'),
          FeatureItem(text: 'Cancela cuando quieras'),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Mostrar notificación de felicitaciones
              Get.snackbar(
                '¡Felicidades!',
                'Gracias por tu compra del plan Premium. Disfruta de todas las funciones premium.',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Colors.orange,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text('Prueba Premium'),
          ),
          
          SizedBox(height: 10),
          Center(
            child: GestureDetector(
              onTap: () {
                // Acción al hacer clic en "Cerrar sesión"
              },
              child: Text(
                'Cerrar sesión',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        
        ],
      ),
    );
  }
}

class FeatureItem extends StatelessWidget {
  final String text;

  FeatureItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.check, color: Colors.orange),
        SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ],
    );
  }
}

class CustomCard extends StatelessWidget {
  final String title;
  final String pdfUrl;

  CustomCard({required this.title, required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          trailing: Icon(Icons.chevron_right, color: Colors.white),
          onTap: () {
            // Navegar a la página del visor de PDF pasando la URL
            Get.to(() => PdfViewerPage(pdfUrl: pdfUrl));
          },
        ),
        Divider(
          color: Colors.black,
          thickness: 1,
          indent: 20,
          endIndent: 20,
        ),
      ],
    );
  }
}

class PdfViewerPage extends StatelessWidget {
  final String pdfUrl;

  PdfViewerPage({required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Utilizar el ícono de flecha de retroceso estándar de Material Icons
          onPressed: () {
            // Acción al hacer clic en el ícono de flecha de retroceso
            Navigator.pop(context); // Cerrar la página actual del visor de PDF
          },
        ),
        title: Text('PDF Viewer'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: _getPdfFileFromUrl(pdfUrl),
              builder: (context, AsyncSnapshot<File> snapshot) {
                if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                  return PDFView(
                    filePath: snapshot.data!.path,
                    enableSwipe: true,
                    swipeHorizontal: true,
                    autoSpacing: false,
                    pageFling: false,
                    onError: (error) {
                      print(error.toString());
                    },
                    onViewCreated: (PDFViewController controller) {
                      // Configura el número total de páginas una vez que el controlador esté disponible
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error al cargar el PDF'));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<File> _getPdfFileFromUrl(String url) async {
    final response = await Dio().get(
      url,
      options: Options(responseType: ResponseType.bytes),
    );
    final file = File('${(await getTemporaryDirectory()).path}/filename.pdf');
    await file.writeAsBytes(response.data!, flush: true);
    return file;
  }
}
