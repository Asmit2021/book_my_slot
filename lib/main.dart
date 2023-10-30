import 'package:book_my_slot/auth/login_screen.dart';
import 'package:book_my_slot/auth/splash_screen.dart';
import 'package:book_my_slot/providers/user_provider.dart';
import 'package:book_my_slot/services/auth_services.dart';
import 'package:book_my_slot/utils/color.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:book_my_slot/screens/tabs.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: MyColors.appBarColor, //const Color.fromARGB(255, 66, 33, 99),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(child: App()),
  );
}

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    authService.getUserData(context: context, ref: ref);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return MaterialApp(
        theme: theme,
        home: user.token.isNotEmpty ? const TabsScreen() : const LoginScreen());
  }
}
