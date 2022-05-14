import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vehicle_tracker/dashboard/logic/dashboard_data_controller/dashboarddatacontroller_cubit.dart';
import 'package:vehicle_tracker/dashboard/logic/sms_service/sms_service_bloc.dart';
import 'package:vehicle_tracker/dashboard/logic/update_location/updatelocation_cubit.dart';
import 'package:vehicle_tracker/dashboard/screen/dashboard.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UpdatelocationCubit>(
          create: (context) => UpdatelocationCubit(),
        ),
        BlocProvider<DashboarddatacontrollerCubit>(
          create: (context) => DashboarddatacontrollerCubit(
            updatelocationCubit: context.read<UpdatelocationCubit>(),
          ),
        ),
        BlocProvider<SmsServiceBloc>(
          create: (context) => SmsServiceBloc(
            dashboarddatacontrollerCubit:
                context.read<DashboarddatacontrollerCubit>(),
          ),
        ),
      ],
      child: ScreenUtilInit(
        designSize: Size(
          WidgetsBinding.instance.window.physicalSize.width /
              WidgetsBinding.instance.window.devicePixelRatio,
          WidgetsBinding.instance.window.physicalSize.height /
              WidgetsBinding.instance.window.devicePixelRatio,
        ),
        builder: (_) => MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.amber,
          ),
          home: const DashBoardScreen(),
        ),
      ),
    );
  }
}
