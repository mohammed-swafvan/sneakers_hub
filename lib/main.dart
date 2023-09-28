import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sneakers_hub/controllers/providers/main_screen_notifier.dart';
import 'package:sneakers_hub/presentation/screens/main_screen.dart';
import 'package:sneakers_hub/presentation/utils/custom_colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainScreenNotifier()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(325, 825),
        minTextAdapt: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Sneakers',
            theme: ThemeData(
              scaffoldBackgroundColor: CustomColors.backGroundColor,
              primarySwatch: Colors.blue,
              useMaterial3: true,
            ),
            home: MainScreen(),
          );
        },),
    );
  }
}
