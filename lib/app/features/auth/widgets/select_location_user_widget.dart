
import '/core/helpers/extensions.dart';
import '/core/utils/color_manager.dart';
import '/core/utils/string_manager.dart';
import '/core/utils/style_manager.dart';
import '/core/widgets/app_button.dart';
import '/core/widgets/app_padding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectLocationUserWidget extends StatefulWidget {
  const SelectLocationUserWidget({super.key, this.confirmLocation});
  final Function(LatLng? selectedLocation)? confirmLocation;

  @override
  State<SelectLocationUserWidget> createState() =>
      _SelectLocationUserWidgetState();
}

class _SelectLocationUserWidgetState extends State<SelectLocationUserWidget> {
  late GoogleMapController _mapController;
  LatLng? _selectedLocation;

  void _onMapTap(LatLng position) {
    setState(() {
      _selectedLocation = position;
    });
  }

  void _confirmLocation() {
    if (LatLng != null) {

     widget.confirmLocation!=null? widget.confirmLocation!(_selectedLocation):"";
      Navigator.pop(context, _selectedLocation);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('الرجاء اختيار موقع من الخريطة')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) {
        print('object');
      },
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: ColorManager.whiteColor,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Material(
          clipBehavior: Clip.none,
          color: Colors.transparent,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: ColorManager.primaryColor,
                      borderRadius:
                      BorderRadius.vertical(top: Radius.circular(14.r)),
                    ),
                    child: ListTile(
                      title: Center(
                        child: Text(
                          StringManager.pickLocationText,
                          style: StyleManager.font16SemiBold(
                              color: ColorManager.whiteColor),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: LatLng(24.7136, 46.6753),
                            zoom: 10.0,
                          ),
                          onMapCreated: (controller) {
                            _mapController = controller;
                          },
                          onTap: _onMapTap,
                          markers: _selectedLocation != null
                              ? {
                            Marker(
                              markerId: MarkerId('selected'),
                              position: _selectedLocation!,
                            ),
                          }
                              : {},
                        ),
                        Visibility(
                          visible: _selectedLocation != null,
                          child: AppPaddingWidget(
                            child: AppButton(
                                onPressed: _confirmLocation,
                                text: StringManager.confirmLocationText
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              PositionedDirectional(
                end: 0,
                child: IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: Icon(
                      Icons.close,
                      color: ColorManager.whiteColor,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
