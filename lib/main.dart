import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_parcel_app/app.dart';
import 'dart:async'; // new
import 'package:firebase_auth/firebase_auth.dart' // new
    hide
        EmailAuthProvider,
        PhoneAuthProvider; // new
import 'package:firebase_core/firebase_core.dart'; // new
import 'package:firebase_ui_auth/firebase_ui_auth.dart'; // new

import 'package:flutter_parcel_app/state/transaction_model.dart';

import 'package:provider/provider.dart'; // new

import 'firebase_options.dart';

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  bool _loggedIn = false;
  String _userId = '';
  bool _sendingParcel = false;

  bool get sendingParcel => _sendingParcel;

  bool get loggedIn => _loggedIn;
  String get userId => _userId;

  StreamSubscription<QuerySnapshot>? _serviceSubscription;
  List<Service> _serviceRequests = [];
  List<Service> get serviceRequest => _serviceRequests;

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
    ]);

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
        _userId = user.uid;

        _serviceSubscription = FirebaseFirestore.instance
            .collection('transactions')
            .orderBy('timestamp', descending: true)
            .snapshots()
            .listen((snapshot) {
          _serviceRequests = [];
          for (final document in snapshot.docs) {
            _serviceRequests.add(
              Service(
                id: document.id,
                type: document.data()['service_type'] as String,
                status: document.data()['service_status'] as String,
                timestamp: document.data()['timestamp'] as int,
              ),
            );
          }
          notifyListeners();
        });
      } else {
        _loggedIn = false;
        _userId = '';
        _serviceRequests = [];
        _serviceSubscription?.cancel();
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
  // runApp(ChangeNotifierProvider(
  //     create: (context) => ApplicationState(),
  //     builder: ((context, child) => const App())));
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => TransactionModel()),
    ChangeNotifierProvider(create: (context) => ApplicationState()),
  ], builder: ((context, child) => const App())));
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