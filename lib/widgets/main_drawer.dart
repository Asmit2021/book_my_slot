import 'package:book_my_slot/utils/color.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    super.key,
    required this.onSelectScreen,
  });

  final void Function(String identifier) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 2,
      backgroundColor: MyColors.drawerColor,
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  MyColors.appBarColor,
                  MyColors.appBarColor
                      .withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomLeft,
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.local_hospital_rounded,
                  size: 48,
                  color: Colors.red,
                ),
                const SizedBox(
                  width: 18,
                ),
                Text(
                  'Dashboard',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.white,
                      ),
                )
              ],
            ),
          ),
          ListTile(
            focusColor: Colors.white,
            hoverColor: Colors.white,
            leading: Icon(
              Icons.local_hospital,
              size: 26,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              'Appointments',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 24,
                  ),
            ),
            onTap: () {
              onSelectScreen('appointments');
            },
          ),
          ListTile(
            hoverColor: Colors.white,
            leading: Icon(
              Icons.circle,
              size: 26,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              'Profile',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 24,
                  ),
            ),
            onTap: () {
              onSelectScreen('profile');
            },
          ),
          
        ],
      ),
    );
  }
}
