import 'package:flutter/material.dart';

import '../../constant/colors.dart';
import '../../constant/dimensions.dart';
import '../../main.dart';
import '../../utils/text_style.dart';
import 'internet_service.dart';

class ConnectivityBanner extends StatelessWidget {
  const ConnectivityBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool?>(
      stream: InternetService().connectionStatusStream,
      builder: (context, snapshot) {
        final networkStatus = snapshot.data;
        final show = networkStatus != null;

        return AnimatedSlide(
          offset: show ? const Offset(0, 0) : const Offset(0, -3), // slide in/out
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: double.maxFinite,
            padding: EdgeInsets.all(deviceAvgScreenSize * 0.01),
            color: networkStatus == false ? colorRed : colorGreen,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  networkStatus == false ? Icons.wifi_off : Icons.wifi,
                  color: colorWhite,
                  size: iconSize15px,
                ),
                SizedBox(width: commonPadding10px),
                Text(
                  networkStatus == false ? languages.offlineTryingToReconnect : languages.backOnline,
                  style: bodyText(textColor: colorWhite, fontSize: textSize12px),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
