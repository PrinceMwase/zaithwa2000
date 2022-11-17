import 'package:flutter/material.dart';
import 'package:flutter_parcel_app/app.dart';
import 'dart:async'; // new
import 'package:firebase_auth/firebase_auth.dart' // new
    hide
        EmailAuthProvider,
        PhoneAuthProvider; // new
import 'package:firebase_core/firebase_core.dart'; // new
import 'package:firebase_ui_auth/firebase_ui_auth.dart'; // new
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart'; // new

import 'firebase_options.dart';

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
    ]);

    FirebaseAuth.instance.userChanges().listen((user) {
      print('user changes');
      if (user != null) {
        _loggedIn = true;
      } else {
        _loggedIn = false;
      }
      notifyListeners();
    });
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (context) => ApplicationState(),
      builder: ((context, child) => const App())));
}


// code lab
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// import 'src/widgets.dart';

// void main() {
//   runApp(const App());
// }

// class App extends StatelessWidget {
//   const App({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Firebase Meetup',
//       theme: ThemeData(
//         buttonTheme: Theme.of(context).buttonTheme.copyWith(
//               highlightColor: Colors.deepPurple,
//             ),
//         primarySwatch: Colors.deepPurple,
//         textTheme: GoogleFonts.robotoTextTheme(
//           Theme.of(context).textTheme,
//         ),
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: const HomePage(),
//     );
//   }
// }

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Firebase Meetup'),
//       ),
//       body: ListView(
//         children: <Widget>[
//           Image.asset('assets/codelab.png'),
//           const SizedBox(height: 8),
//           const IconAndDetail(Icons.calendar_today, 'October 30'),
//           const IconAndDetail(Icons.location_city, 'San Francisco'),
//           const Divider(
//             height: 8,
//             thickness: 1,
//             indent: 8,
//             endIndent: 8,
//             color: Colors.grey,
//           ),
//           const Header("What we'll be doing"),
//           const Paragraph(
//             'Join us for a day full of Firebase Workshops and Pizza!',
//           ),
//         ],
//       ),
//     );
//   }
// }