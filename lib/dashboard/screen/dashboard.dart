import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
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
    );
  }
}
