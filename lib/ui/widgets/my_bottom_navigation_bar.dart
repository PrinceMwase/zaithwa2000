import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_parcel_app/ui/screens/screens.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _selectedIndex = 0;
  late List<String> _children;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.of(context).pushReplacementNamed(_children[_selectedIndex]);
    });
  }

  @override
  void initState() {
    _selectedIndex = 0;
    _children = ['/', '/send-parcel', '/send-parcel'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedFontSize: 12,
      unselectedFontSize: 12,
      selectedLabelStyle: Theme.of(context).textTheme.headline5,
      unselectedLabelStyle: Theme.of(context).textTheme.headline5,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: _selectedIndex == Navigator.of(context)
              ? SvgPicture.asset('assets/images/icon_my_parcels.svg')
              : SvgPicture.asset('assets/images/icon_my_parcels_grey.svg'),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: _selectedIndex == 1
              ? SvgPicture.asset('assets/images/icon_send_parcel.svg')
              : SvgPicture.asset('assets/images/icon_send_parcel_grey.svg'),
          label: 'Send parcel',
        ),
        BottomNavigationBarItem(
          icon: _selectedIndex == 2
              ? SvgPicture.asset('assets/images/icon_parcel_center.svg')
              : SvgPicture.asset('assets/images/icon_parcel_center_grey.svg'),
          label: 'Parcel center',
        ),
      ],
      currentIndex: _selectedIndex,
      unselectedItemColor: Theme.of(context).unselectedWidgetColor,
      selectedItemColor: Colors.black,
      onTap: _onItemTapped,
    );
  }
}
