//used to render different views in parcel app

import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_parcel_app/parcel_app_theme.dart';
import 'package:flutter_parcel_app/ui/screens/login_view.dart';
import 'package:flutter_parcel_app/ui/screens/screens.dart';
import 'package:flutter_parcel_app/ui/widgets/widgets.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/home': (context) {
          return const HomeScreen();
        },
        '/send-parcel': (context) {
          return const Scaffold(
            body: SendParcelScreen(),
            bottomNavigationBar: MyBottomNavigationBar(),
          );
        },
        '/sign-in': ((context) {
          return SignInScreen(
            actions: [
              ForgotPasswordAction(((context, email) {
                Navigator.of(context)
                    .pushNamed('forgot-password', arguments: {'email': email});
              })),
              AuthStateChangeAction((((context, state) {
                if (state is SignedIn || state is UserCreated) {
                  var user = (state is SignedIn)
                      ? state.user
                      : (state as UserCreated).credential.user;
                  if (user == null) {
                    return;
                  }
                  if (state is UserCreated) {
                    user.updateDisplayName(user.displayName!.split('@')[0]);
                  }
                  if (!user.emailVerified) {
                    user.sendEmailVerification();
                    const snackBar = SnackBar(
                        content: Text(
                            "Please Check your email to verify your email address"));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  Navigator.of(context).pushReplacementNamed('/home');
                }
              })))
            ],
          );
        }),
        '/forgot-password': ((context) {
          final arguments = ModalRoute.of(context)?.settings.arguments
              as Map<String, dynamic>?;
          return ForgotPasswordScreen(
            email: arguments?['email'] as String,
            headerMaxExtent: 200,
          );
        }),
        '/profile': ((context) {
          return ProfileScreen(
            providers: [],
            actions: [
              SignedOutAction(((context) {
                Navigator.of(context).pushReplacementNamed('/home');
              }))
            ],
          );
        })
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ParcelAppTheme.lightTheme,
      home: const Scaffold(
        body: HomeScreen(),
        bottomNavigationBar: MyBottomNavigationBar(),
      ),
    );
  }
}
