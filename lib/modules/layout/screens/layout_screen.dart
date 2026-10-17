import 'package:evently_c20_online/modules/add_event/screens/add_event_screen.dart';
import 'package:evently_c20_online/modules/layout/screens/fav_screen.dart';
import 'package:evently_c20_online/modules/layout/screens/home_screen.dart';
import 'package:evently_c20_online/modules/layout/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus_pro/icons_plus_pro.dart';

class LayoutScreen extends StatefulWidget {
  static const String routeName = "layout";
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int selectedIndex = 0;
  List<Widget> screens = [HomeScreen(), FavScreen(), ProfileScreen()];
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(360),
        ),
        backgroundColor: theme.primaryColor,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, AddEventScreen.routeName).then((value) {
            setState(() {});
          });
        },
      ),
      body: screens[selectedIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (value) {
            selectedIndex = value;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Iconsax.home_1_outline),
              activeIcon: Icon(Iconsax.home_1_bold),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_outlined),
              activeIcon: Icon(Icons.favorite_rounded),
              label: "Favorite",
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.profile_circle_outline),
              activeIcon: Icon(Iconsax.profile_circle_bold),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
