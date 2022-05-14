import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vehicle_tracker/config/send_sms_status.dart';
import 'package:vehicle_tracker/dashboard/logic/sms_service/sms_service_bloc.dart';
import 'package:vehicle_tracker/dashboard/logic/update_location/updatelocation_cubit.dart';
import 'package:vehicle_tracker/utility/loading_indicator.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = GoogleFonts.poppins(
      textStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14.sp,
      ),
    );
    return Container(
      decoration: BoxDecoration(border: Border.all()),
      child: Stack(children: [
        BlocBuilder<UpdatelocationCubit, UpdatelocationState>(
          builder: ((context, state) {
            if (state is LocationFetched) {
              return GoogleMap(
                myLocationEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    state.location.latitude,
                    state.location.longitude,
                  ),
                  zoom: 15,
                ),
                markers: <Marker>{
                  Marker(
                    markerId: const MarkerId('m1'),
                    position: LatLng(
                      state.location.latitude,
                      state.location.longitude,
                    ),
                  ),
                },
              );
            }
            if (state is NoLocationfound) {
              return Center(
                  child: Text(
                state.error,
                style: textStyle,
              ));
            } else {
              return const LoadingIndicator();
            }
          }),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: ElevatedButton(
              onPressed: () {
                context.read<SmsServiceBloc>().add(
                    SendSms(command: SendSMS.fetchLocation, context: context));
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 30.w),
              ),
              child: Text(
                'Refresh vehicle location',
                style: textStyle,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
