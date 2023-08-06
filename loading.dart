import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
            Colors.white
                .withOpacity(0.3), // Adjust the opacity here (0.0 to 1.0)
            BlendMode.dstATop,
          ),
          image: AssetImage('lib/assets/60ee651c35897acfc77e7cb33ac5b996.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: SpinKitFoldingCube(
          color: Colors.grey[100],
          size: 50.0,
        ),
      ),
    );
  }
}
