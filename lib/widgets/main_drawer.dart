import 'package:book_my_slot/providers/user_provider.dart';
import 'package:book_my_slot/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainDrawer extends ConsumerStatefulWidget {
  const MainDrawer({
    super.key,
    required this.onSelectScreen,
  });

  final void Function(String identifier) onSelectScreen;

  @override
  ConsumerState<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends ConsumerState<MainDrawer> {

  @override
  Widget build(BuildContext context) {
    final user = ref.read(userProvider);
    return Drawer(
      elevation: 2,
      backgroundColor: MyColors.drawerColor,
      child: SingleChildScrollView(
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
                Icons.add_shopping_cart_rounded,
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
                widget.onSelectScreen('appointments');
              },
            ),
            if(user.role == 'admin')
            ListTile(
              hoverColor: Colors.white,
              leading: Icon(
                Icons.supervised_user_circle_rounded,
                size: 26,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              title: Text(
                'Doctors',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 24,
                    ),
              ),
              onTap: () {
                widget.onSelectScreen('doctors');
              },
            ),
            if(user.role == 'admin')
            ListTile(
              hoverColor: Colors.white,
              leading: Icon(
                Icons.supervised_user_circle_outlined,
                size: 26,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              title: Text(
                'Users',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 24,
                    ),
              ),
              onTap: () {
                widget.onSelectScreen('users');
              },
            ),
            if(user.role == 'admin')
            ListTile(
              hoverColor: Colors.white,
              leading: Icon(
                Icons.add_circle_rounded,
                size: 26,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              title: Text(
                'Add Doctor',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 24,
                    ),
              ),
              onTap: () {
                widget.onSelectScreen('addDoctor');
              },
            ),
            ListTile(
              hoverColor: Colors.white,
              leading: Icon(
                Icons.data_usage_rounded,
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
                widget.onSelectScreen('profile');
              },
            ),
            
          ],
        ),
      ),
    );
  }
}
