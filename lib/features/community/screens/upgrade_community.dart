import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import '../../../theme/pallete.dart';
import '../controller/community_controller.dart';

class UpgradeCommunity extends ConsumerStatefulWidget {
  final String name;
  const UpgradeCommunity({
    super.key,
    required this.name,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UpgradeCommunityState();
}

class _UpgradeCommunityState extends ConsumerState<UpgradeCommunity> {

  void upgradeCommunity(){
    ref.read(communityControllerProvider.notifier).upgradeCommunity(
        widget.name,
        context,
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upgrade Community"),
      ),
      body: Column(
        children: [
          const SizedBox(
              height: 20,
              width: double.infinity,
          ),
          const Text(
            'Attention! ',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 30),
          Container(
            child: Lottie.network(
              "https://assets7.lottiefiles.com/packages/lf20_73jq34.json"
              ,width:300,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: const [
                SizedBox(
                  height: 20,
                  width: double.infinity,
                ),
                Text("Careful, By upgrading.. Members of this community will be able only to Post Demands of rescue. \nAre you sure you want to upgrade? ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
      Padding(
        padding: const EdgeInsets.all(18.0),
        child: ElevatedButton(

          onPressed: () => upgradeCommunity(),
          style: ElevatedButton.styleFrom(
            backgroundColor: Pallete.greyColor,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: const Text(
            'Upgrade Anyway',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
        ],
      ),
    );
  }
}
