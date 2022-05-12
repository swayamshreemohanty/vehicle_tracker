import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vehicle_tracker/dashboard/logic/bloc/sms_service_bloc.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  void initState() {
    context.read<SmsServiceBloc>().add(ListenToSms());
    context.read<SmsServiceBloc>().add(FetchSms(context: context));
    super.initState();
  }

  final _pageTitleTextStyle = GoogleFonts.poppins(
      textStyle: TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14.sp,
  ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Vehicle Tracker',
          style: _pageTitleTextStyle,
        ),
      ),
      body: Center(
        child: OutlinedButton(
            onPressed: () {
              context
                  .read<SmsServiceBloc>()
                  .add(SendSms(command: 'HIII', context: context));
            },
            child: const Text('Send SMS')),
      ),
    );
  }
}
