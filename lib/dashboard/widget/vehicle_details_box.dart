import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class VehicleDetails extends StatelessWidget {
  const VehicleDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonNameTextStyle = GoogleFonts.poppins(
        textStyle: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 15.sp,
    ));
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      width: double.infinity,
      decoration: BoxDecoration(border: Border.all()),
      child: Column(
        children: [
          Text(
            'Vehicle Condition',
            style: buttonNameTextStyle,
          ),
          const Divider(color: Colors.black),
          Text(
            'Fuel tank temp',
            style: buttonNameTextStyle,
          ),
        ],
      ),
    );
  }
}