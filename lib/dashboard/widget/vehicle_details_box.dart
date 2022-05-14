import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vehicle_tracker/dashboard/logic/update_status/update_status_cubit.dart';
import 'package:vehicle_tracker/utility/loading_indicator.dart';

class VehicleDetails extends StatelessWidget {
  const VehicleDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = GoogleFonts.poppins(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Vehicle Condition: ',
                style: textStyle,
              ),
              BlocBuilder<UpdateStatusCubit, UpdateStatusState>(
                builder: (context, state) {
                  if (state is StatusFetched) {
                    return Text(
                      state.status.condition,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        color: state.status.condition
                                .toLowerCase()
                                .contains('normal')
                            ? Colors.green
                            : Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                      )),
                    );
                  } else if (state is NoStatusfound) {
                    return Text(
                      state.error,
                      style: textStyle,
                    );
                  } else {
                    return const StatusLoadingSpinner();
                  }
                },
              ),
            ],
          ),
          const Divider(color: Colors.black),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Fuel tank temp: ',
                style: textStyle,
              ),
              BlocBuilder<UpdateStatusCubit, UpdateStatusState>(
                builder: (context, state) {
                  if (state is StatusFetched) {
                    return Text(
                      '${state.status.temperature} °C',
                      style: textStyle,
                    );
                  } else if (state is NoStatusfound) {
                    return Text(
                      state.error,
                      style: textStyle,
                    );
                  } else {
                    return const StatusLoadingSpinner();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StatusLoadingSpinner extends StatelessWidget {
  const StatusLoadingSpinner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20.h,
      width: 20.w,
      child: const LoadingIndicator(),
    );
  }
}
