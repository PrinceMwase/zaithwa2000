import 'package:flutter/material.dart';
import 'package:flutter_parcel_app/main.dart';
import 'package:flutter_parcel_app/src/authentication.dart';
import 'package:flutter_parcel_app/src/widgets.dart';
import 'package:flutter_parcel_app/ui/widgets/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async'; // new
import 'package:firebase_auth/firebase_auth.dart' // new
    hide
        EmailAuthProvider,
        PhoneAuthProvider; // new
import 'package:provider/provider.dart'; // new

// import 'firebase_options.dart';                          // new
// import 'src/authentication.dart';                        // new
// import 'src/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
        builder: (context, appState, child) => CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  title: Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Text(
                      'Track parcel',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  snap: true,
                  floating: true,
                  centerTitle: false,
                  titleSpacing: 0,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: CircleAvatar(
                        child: ClipOval(
                          child: Image.network(
                            '',
                          ),
                        ),
                      ),
                    ),
                  ],
                  shadowColor: Colors.transparent,
                  expandedHeight: 426,
                  pinned: true,
                  backgroundColor:
                      Theme.of(context).appBarTheme.backgroundColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 64),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Consumer<ApplicationState>(
                                  builder: (context, appState, _) => AuthFunc(
                                      loggedIn: appState.loggedIn,
                                      signOut: () {
                                        FirebaseAuth.instance.signOut();
                                      }),
                                ),
                                Text(
                                  'Enter parcel number or scan QR code',
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 40,
                                    top: 7,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          height: 49,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: Theme.of(context)
                                                .backgroundColor,
                                          ),
                                          child: const TextField(
                                            decoration: InputDecoration(
                                                border: InputBorder.none),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          print('Scan object pressed!');
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(14),
                                          width: 50,
                                          height: 49,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: Theme.of(context)
                                                .backgroundColor,
                                          ),
                                          child: SvgPicture.asset(
                                              'assets/images/icon_qrcode.svg'),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 48,
                                  width: double.infinity,
                                  child: TextButton(
                                    onPressed: () {
                                      print('button pressed');
                                    },
                                    child: Text(
                                      'Track parcel',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    style:
                                        Theme.of(context).textButtonTheme.style,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SliverPadding(
                  padding: EdgeInsets.only(top: 32),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 24,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'My parcels',
                            style: Theme.of(context).textTheme.headline3,
                          ),
                        ],
                      ),
                    )
                  ]),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Theme.of(context).backgroundColor,
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).shadowColor,
                                spreadRadius: 0,
                                blurRadius: 10,
                                offset: const Offset(
                                    0, 0), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: TransactionHome(
                                    context: context,
                                    transactions: appState.serviceRequest)
                                .children[index],
                          ),
                        ),
                      );
                    },
                    childCount: TransactionHome(
                            context: context,
                            transactions: appState.serviceRequest)
                        .children
                        .length,
                  ),
                ),
              ],
            ));
  }
}
