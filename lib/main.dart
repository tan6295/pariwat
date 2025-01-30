import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth.dart'; // น าเข้าไฟล์ที่ต้องการเรียกใช้จากหน้า 'auth.dart'
import 'signin_page.dart'; // น าเข้าไฟล์ที่ต้องการเรียกใช้จากหน้า 'signin_page.dart'
import 'home_page.dart'; // น าเข้าไฟล์ที่ต้องการเรียกใช้จากหน้า 'homepage_page.dart'

//Method หลักทีRun
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyA1LPAnfXpI5sCKz7QSOcMTIZGoWrOj9M4",
            authDomain: "testfirebasesw-1788b.firebaseapp.com",
            databaseURL:
                "https://testfirebasesw-1788b-default-rtdb.firebaseio.com",
            projectId: "testfirebasesw-1788b",
            storageBucket: "testfirebasesw-1788b.appspot.com",
            messagingSenderId: "622152614704",
            appId: "1:622152614704:web:074e52df2540a42c7a7ef5",
            measurementId: "G-GQHBF139KD"));
  } else {
    await Firebase.initializeApp();
  }

  runApp(MyApp());
}

// Class MyApp ส าหรับการแสดงผลหน้าจอ
class MyApp extends StatelessWidget {
  MyApp({super.key});
// ตรวจสอบ AuthService
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
      ),
      home: StreamBuilder(
        stream: _auth.authStateChanges, // ตรวจสอบการเชื่อมต่อ Stream
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            return HomePage(); // ตรวจสอบว่ามี HomePage และท างานได้
          } else {
            return const LoginPage(); // ตรวจสอบว่ามี LoginPage และท างานได้
          }
        },
      ),
      routes: {
        LoginPage.routeName: (BuildContext context) => const LoginPage(),
        HomePage.routeName: (BuildContext context) => HomePage(),
      },
    );
  }
}
